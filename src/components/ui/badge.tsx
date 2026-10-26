type BadgeVariant = "electric" | "iris" | "signal" | "phosphor" | "amber" | "muted";

interface BadgeProps {
  variant?: BadgeVariant;
  children: React.ReactNode;
  className?: string;
}

const variantClasses: Record<BadgeVariant, string> = {
  electric: "bg-electric/15 text-electric border-electric/25",
  iris: "bg-iris/15 text-iris border-iris/25",
  signal: "bg-signal/15 text-signal border-signal/25",
  phosphor: "bg-phosphor/15 text-phosphor border-phosphor/25",
  amber: "bg-amber/15 text-amber border-amber/25",
  muted: "bg-bg-overlay text-text-secondary border-border-default",
};

export function Badge({ variant = "muted", children, className = "" }: BadgeProps) {
  return (
    <span
      className={`
        inline-flex items-center px-2 py-0.5 text-xs font-medium
        rounded-[var(--radius-sm)] border
        ${variantClasses[variant]}
        ${className}
      `}
    >
      {children}
    </span>
  );
}
