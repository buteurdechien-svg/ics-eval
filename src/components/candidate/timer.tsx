"use client";

import { useEffect, useState, useCallback } from "react";

interface TimerProps {
  expiresAt: string; // ISO timestamp
  onExpire: () => void;
}

export function Timer({ expiresAt, onExpire }: TimerProps) {
  const [remaining, setRemaining] = useState<number>(() =>
    Math.max(0, Math.floor((new Date(expiresAt).getTime() - Date.now()) / 1000))
  );

  const handleExpire = useCallback(onExpire, [onExpire]);

  useEffect(() => {
    const tick = () => {
      const diff = Math.max(0, Math.floor((new Date(expiresAt).getTime() - Date.now()) / 1000));
      setRemaining(diff);
      if (diff <= 0) {
        handleExpire();
        return;
      }
    };

    tick(); // sync immediately
    const interval = setInterval(tick, 1000);
    return () => clearInterval(interval);
  }, [expiresAt, handleExpire]);

  const minutes = Math.floor(remaining / 60);
  const seconds = remaining % 60;
  const pad = (n: number) => n.toString().padStart(2, "0");

  // Color shifts: normal → warning (< 5min) → critical (< 1min)
  const isWarning = remaining <= 300 && remaining > 60;
  const isCritical = remaining <= 60;

  let colorClass = "text-text-primary";
  let glowClass = "";
  if (isCritical) {
    colorClass = "text-signal";
    glowClass = "animate-pulse";
  } else if (isWarning) {
    colorClass = "text-amber";
  }

  return (
    <div
      className={`font-mono font-semibold tabular-nums ${colorClass} ${glowClass}`}
      role="timer"
      aria-live="polite"
      aria-label={`Temps restant : ${minutes} minutes et ${seconds} secondes`}
    >
      <span className="text-3xl tracking-tight">
        {pad(minutes)}:{pad(seconds)}
      </span>
    </div>
  );
}
