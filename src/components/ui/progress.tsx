interface ProgressProps {
  value: number; // 0–100
  variant?: "electric" | "iris" | "signal" | "phosphor" | "amber";
  height?: "sm" | "md";
  label?: string;
  className?: string;
}

const barColors: Record<string, string> = {
  electric: "bg-electric",
  iris: "bg-iris",
  signal: "bg-signal",
  phosphor: "bg-phosphor",
  amber: "bg-amber",
};

export function Progress({
  value,
  variant = "electric",
  height = "md",
  label,
  className = "",
}: ProgressProps) {
  const clamped = Math.max(0, Math.min(100, value));
  const h = height === "sm" ? "h-1.5" : "h-2.5";

  return (
    <div className={className}>
      {label && (
        <div className="flex justify-between mb-1.5 text-xs">
          <span className="text-text-secondary">{label}</span>
          <span className="text-text-primary font-medium font-mono">{clamped}%</span>
        </div>
      )}
      <div
        className={`w-full ${h} bg-bg-overlay rounded-full overflow-hidden`}
        role="progressbar"
        aria-valuenow={clamped}
        aria-valuemin={0}
        aria-valuemax={100}
        aria-label={label ?? `${clamped}%`}
      >
        <div
          className={`${h} ${barColors[variant]} rounded-full transition-[width] duration-500 ease-out`}
          style={{ width: `${clamped}%` }}
        />
      </div>
    </div>
  );
}
