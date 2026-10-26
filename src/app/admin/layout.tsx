import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Admin — Ivoire Cyber Shield",
  robots: "noindex, nofollow",
};

export default function AdminLayout({ children }: LayoutProps<"/">) {
  return <>{children}</>;
}
