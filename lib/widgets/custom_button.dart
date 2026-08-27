// ─────────────────────────────────────────────────────────────
// FILE: lib/widgets/dashboard_card.dart
// PURPOSE: Generic glowing stat card used on HomeScreen.
//          Shows an icon, metric value, label, and optional
//          subtitle. Supports accent color customization.
// ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String? subtitle;
  final Color accentColor;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.subtitle,
    this.accentColor = AppColors.neonCyan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF111827), Color(0xFF0D1B2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.08),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon in glowing container ──────────────────────
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: accentColor.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.2),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Icon(icon, color: accentColor, size: 20),
            ),

            const SizedBox(height: 14),

            // ── Metric value ───────────────────────────────────
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: accentColor,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 4),

            // ── Label ──────────────────────────────────────────
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),

            // ── Optional subtitle ──────────────────────────────
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 11,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// WIDE DASHBOARD CARD (full width, horizontal layout)
// Use for prominent metrics like "Today's Focus Time"
// ─────────────────────────────────────────────────────────────
class DashboardCardWide extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String? actionLabel;
  final Color accentColor;
  final VoidCallback? onTap;

  const DashboardCardWide({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.actionLabel,
    this.accentColor = AppColors.neonCyan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accentColor.withOpacity(0.12),
              AppColors.bgDark,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // ── Icon ───────────────────────────────────────────
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.3),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Icon(icon, color: accentColor, size: 22),
            ),

            const SizedBox(width: 16),

            // ── Text content ───────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // ── Optional arrow/action ──────────────────────────
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: accentColor.withOpacity(0.5),
              ),
          ],
        ),
      ),
    );
  }
}