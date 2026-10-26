import { Suspense } from "react";
import { AdminShell } from "@/components/admin/admin-shell";

export default function DashboardLayout({ children }: LayoutProps<"/">) {
  return (
    <Suspense
      fallback={
        <div className="min-h-dvh flex items-center justify-center">
          <div className="w-6 h-6 border-2 border-electric border-t-transparent rounded-full animate-spin" />
        </div>
      }
    >
      <AdminShell>{children}</AdminShell>
    </Suspense>
  );
}
