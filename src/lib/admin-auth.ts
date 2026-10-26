import { cookies } from "next/headers";
import { createServerClient } from "./supabase-server";

const ADMIN_SESSION_COOKIE = "ics_admin_session";

/**
 * Verify admin session from cookie.
 * Returns the admin user or null.
 */
export async function getAdminSession() {
  const cookieStore = await cookies();
  const sessionToken = cookieStore.get(ADMIN_SESSION_COOKIE)?.value;
  if (!sessionToken) return null;

  const db = createServerClient();
  // We store admin sessions as a simple signed token = admin user id
  // In production, use Supabase Auth; here we use a lightweight approach
  const { data: admin } = await db
    .from("admin_audit_logs")
    .select("admin_email")
    .eq("action", "login")
    .eq("details->>session_token", sessionToken)
    .order("created_at", { ascending: false })
    .limit(1)
    .single();

  return admin ? { email: admin.admin_email, sessionToken } : null;
}

/**
 * Create a session token for admin login.
 */
export function generateSessionToken(): string {
  const bytes = new Uint8Array(32);
  crypto.getRandomValues(bytes);
  return Array.from(bytes, (b) => b.toString(16).padStart(2, "0")).join("");
}

export { ADMIN_SESSION_COOKIE };
