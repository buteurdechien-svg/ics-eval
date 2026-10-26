import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ attemptId: string }> }
) {
  try {
    const { attemptId } = await params;
    const format = request.nextUrl.searchParams.get("format");
    const db = createServerClient();

    // Get the attempt
    const { data: attempt } = await db
      .from("attempts")
      .select("*")
      .eq("id", attemptId)
      .eq("status", "soumis")
      .single();

    if (!attempt) {
      return NextResponse.json(
        { error: "Résultats introuvables ou tentative non terminée." },
        { status: 404 }
      );
    }

    // Authorization: verify the session token matches
    const token = request.headers.get("x-attempt-token");
    // For PDF download, we allow if referer is our own domain or token matches
    const referer = request.headers.get("referer") ?? "";
    const host = request.headers.get("host") ?? "";
    const isOwnDomain = referer.includes(host);

    if (!isOwnDomain && token !== attempt.id) {
      return NextResponse.json(
        { error: "Accès non autorisé à ces résultats." },
        { status: 403 }
      );
    }

    // Get candidate
    const { data: candidate } = await db
      .from("candidates")
      .select("nom, prenom, email")
      .eq("id", attempt.candidate_id)
      .single();

    if (!candidate) {
      return NextResponse.json({ error: "Candidat introuvable" }, { status: 404 });
    }

    // Get WhatsApp link only if admitted
    let whatsappLink: string | undefined;
    if (attempt.admis) {
      const { data: setting } = await db
        .from("app_settings")
        .select("value")
        .eq("key", "whatsapp_link")
        .single();
      if (setting?.value) whatsappLink = setting.value;
    }

    // JSON response for the results page
    if (format === "json") {
      return NextResponse.json({
        candidat: {
          nom: candidate.nom,
          prenom: candidate.prenom,
        },
        attempt: {
          id: attempt.id,
          pourcentage: Number(attempt.pourcentage),
          bonnesReponses: attempt.bonnes_reponses,
          totalQuestions: attempt.total_questions,
          appreciation: attempt.appreciation,
          admis: attempt.admis,
          domaines: attempt.domaines_json,
          pointsForts: attempt.points_forts ?? [],
          pointsFaibles: attempt.points_faibles ?? [],
          dureeSecondes: attempt.duree_secondes,
        },
        whatsappLink,
      });
    }

    // PDF generation
    const { jsPDF } = await import("jspdf");
    const doc = new jsPDF({ orientation: "portrait", unit: "mm", format: "a4" });

    const pageW = 210;
    const margin = 20;
    const contentW = pageW - 2 * margin;
    let y = margin;

    // Helper
    const addText = (text: string, x: number, yPos: number, options: { fontSize?: number; fontStyle?: string; color?: [number, number, number]; maxWidth?: number } = {}) => {
      doc.setFontSize(options.fontSize ?? 10);
      if (options.color) doc.setTextColor(...options.color);
      else doc.setTextColor(30, 30, 30);
      const lines = doc.splitTextToSize(text, options.maxWidth ?? contentW);
      doc.text(lines, x, yPos);
      return yPos + lines.length * (options.fontSize ?? 10) * 0.45;
    };

    // Header
    doc.setFillColor(13, 17, 23);
    doc.rect(0, 0, pageW, 50, "F");
    doc.setTextColor(255, 255, 255);
    doc.setFontSize(18);
    doc.text("Procès-verbal d'évaluation", margin, 22);
    doc.setFontSize(10);
    doc.text("Initiation au Pentest Web avec l'Intelligence Artificielle", margin, 32);
    doc.setFontSize(8);
    doc.text("Ivoire Cyber Shield", margin, 42);

    y = 60;

    // Candidate info
    y = addText(`Candidat : ${candidate.prenom} ${candidate.nom}`, margin, y, { fontSize: 11 });
    const maskedEmail = candidate.email.replace(/(.{2}).*(@.*)/, "$1***$2");
    y = addText(`E-mail : ${maskedEmail}`, margin, y + 2, { fontSize: 9, color: [100, 100, 100] });
    y = addText(`Tentative : ${attempt.id}`, margin, y + 2, { fontSize: 8, color: [100, 100, 100] });
    y = addText(`Date : ${new Date(attempt.started_at).toLocaleDateString("fr-FR", { dateStyle: "long" })}`, margin, y + 2, { fontSize: 9 });
    const minutes = Math.floor(attempt.duree_secondes / 60);
    const seconds = attempt.duree_secondes % 60;
    y = addText(`Durée utilisée : ${minutes} min ${seconds.toString().padStart(2, "0")} s`, margin, y + 2, { fontSize: 9 });

    y += 6;

    // Score
    if (attempt.admis) {
      doc.setFillColor(63, 185, 80);
    } else {
      doc.setFillColor(218, 54, 51);
    }
    doc.roundedRect(margin, y, contentW, 22, 3, 3, "F");
    doc.setTextColor(255, 255, 255);
    doc.setFontSize(16);
    doc.text(`${attempt.pourcentage}%`, margin + 8, y + 10);
    doc.setFontSize(10);
    doc.text(
      `${attempt.bonnes_reponses}/${attempt.total_questions} bonnes réponses — ${attempt.admis ? "ADMIS AU SEUIL" : "SEUIL NON ATTEINT"}`,
      margin + 30,
      y + 10
    );
    doc.setFontSize(9);
    doc.text(attempt.appreciation, margin + 8, y + 18);

    y += 30;

    // Domains
    doc.setTextColor(30, 30, 30);
    doc.setFontSize(12);
    doc.text("Résultats par domaine", margin, y);
    y += 7;

    const domaines = attempt.domaines_json as Array<{
      nom: string;
      bonnesReponses: number;
      totalQuestions: number;
      pourcentage: number;
      recommandations: string[];
    }>;

    for (const d of domaines) {
      if (y > 260) { doc.addPage(); y = margin; }

      doc.setFontSize(10);
      doc.setTextColor(30, 30, 30);
      const pctText = d.pourcentage < 0 ? "Non évalué" : `${d.pourcentage}% (${d.bonnesReponses}/${d.totalQuestions})`;
      doc.text(`${d.nom} — ${pctText}`, margin, y);
      y += 3;

      // Progress bar
      if (d.pourcentage >= 0) {
        doc.setFillColor(33, 38, 45);
        doc.roundedRect(margin, y, contentW, 3, 1, 1, "F");
        const barColor = d.pourcentage >= 70 ? [63, 185, 80] : d.pourcentage >= 50 ? [210, 153, 34] : [218, 54, 51];
        doc.setFillColor(barColor[0], barColor[1], barColor[2]);
        doc.roundedRect(margin, y, contentW * (d.pourcentage / 100), 3, 1, 1, "F");
      }
      y += 6;

      // Recommendations
      if (d.recommandations?.length) {
        for (const r of d.recommandations) {
          doc.setFontSize(8);
          doc.setTextColor(100, 100, 100);
          y = addText(`— ${r}`, margin + 4, y, { fontSize: 8, maxWidth: contentW - 8 });
          y += 1;
        }
      }
      y += 4;
    }

    // Points forts / faibles
    if (y > 240) { doc.addPage(); y = margin; }
    y += 4;
    doc.setFontSize(10);
    doc.setTextColor(63, 185, 80);
    doc.text("Points forts", margin, y);
    y += 5;
    if (attempt.points_forts?.length) {
      for (const p of attempt.points_forts) {
        y = addText(`— ${p}`, margin + 4, y, { fontSize: 9, color: [80, 80, 80] });
        y += 1;
      }
    } else {
      y = addText("Aucun domaine au-dessus de 70%", margin + 4, y, { fontSize: 9, color: [140, 140, 140] });
    }

    y += 5;
    doc.setTextColor(218, 54, 51);
    doc.setFontSize(10);
    doc.text("Points à renforcer", margin, y);
    y += 5;
    if (attempt.points_faibles?.length) {
      for (const p of attempt.points_faibles) {
        y = addText(`— ${p}`, margin + 4, y, { fontSize: 9, color: [80, 80, 80] });
        y += 1;
      }
    } else {
      y = addText("Tous les domaines au-dessus de 50%", margin + 4, y, { fontSize: 9, color: [140, 140, 140] });
    }

    // Footer
    y += 10;
    if (y > 270) { doc.addPage(); y = margin; }
    doc.setDrawColor(200, 200, 200);
    doc.line(margin, y, pageW - margin, y);
    y += 5;
    y = addText(
      "Ce document est un procès-verbal d'évaluation théorique de niveau débutant. Il ne constitue pas une certification professionnelle.",
      margin,
      y,
      { fontSize: 7, color: [130, 130, 130] }
    );

    const pdfBuffer = doc.output("arraybuffer");

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename="PV_${candidate.prenom}_${candidate.nom}.pdf"`,
      },
    });
  } catch (err) {
    console.error("PV generation error:", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
