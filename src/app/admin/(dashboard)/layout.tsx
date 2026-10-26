import { AdminShell } from "@/components/admin/admin-shell";

export default function DashboardLayout({ children }: LayoutProps<"/">) {
  return <AdminShell>{children}</AdminShell>;
}
