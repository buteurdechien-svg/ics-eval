import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { AdminLoginSchema } from "@/lib/schemas";
import { generateSessionToken, ADMIN_SESSION_COOKIE } from "@/lib/admin-auth";

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = AdminLoginSchema.safeParse(body);

    if (!parsed.success) {
      return NextResponse.json(
        { error: "Identifiants invalides" },
        { status: 400 }
      );
    }

    const db = createServerClient();

    // Authenticate with Supabase Auth
    const { data, error } = await db.auth.signInWithPassword({
      email: parsed.data.email,
      password: parsed.data.password,
    });

    if (error || !data.user) {
      return NextResponse.json(
        { error: "E-mail ou mot de passe incorrect" },
        { status: 401 }
      );
    }

    // Generate session token
    const sessionToken = generateSessionToken();

    // Use a fresh service-role client for the insert.
    // After signInWithPassword the first client holds the user's JWT,
    // which is subject to RLS and has no INSERT policy on admin_audit_logs.
    const dbAdmin = createServerClient();

    // Log the login
    const { error: insertError } = await dbAdmin.from("admin_audit_logs").insert({
      admin_email: parsed.data.email,
      action: "login",
      details: {
        session_token: sessionToken,
        user_agent: request.headers.get("user-agent"),
      },
      ip_address: (request.headers.get("x-forwarded-for") ?? "").split(",")[0].trim() || null,
    });

    if (insertError) {
      console.error("Failed to insert admin audit log:", insertError);
      return NextResponse.json(
        { error: "Erreur lors de la création de session" },
        { status: 500 }
      );
    }

    // Set session cookie
    const response = NextResponse.json({ success: true });
    response.cookies.set(ADMIN_SESSION_COOKIE, sessionToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      path: "/",
      maxAge: 60 * 60 * 8, // 8 hours
    });

    return response;
  } catch (err) {
    console.error("Admin auth error:", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}

export async function DELETE() {
  // Logout
  const response = NextResponse.json({ success: true });
  response.cookies.set(ADMIN_SESSION_COOKIE, "", {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: 0,
  });
  return response;
}
