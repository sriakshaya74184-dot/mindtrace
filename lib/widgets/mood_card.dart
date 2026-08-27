// ─────────────────────────────────────────────────────────────
// FILE: lib/widgets/mood_card.dart
// PURPOSE: Displays a single MoodModel entry as a dark neon
//          card — shows emoji, label, timestamp, tags, and
//          optional note. Used in MoodScreen & ReportScreen.
// ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../models/mood_model.dart';
import '../theme/app_theme.dart';

class MoodCard extends StatelessWidget {
  final MoodModel mood;
  final VoidCallback? onTap;

  const MoodCard({
    super.key,
    required this.mood,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF111827), Color(0xFF0D1B2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            // Left accent border uses the mood color
            color: mood.level.color.withOpacity(0.35),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: mood.level.color.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Colored left accent bar ────────────────────────
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: mood.level.color,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: mood.level.color.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // ── Emoji ──────────────────────────────────────────
            Text(
              mood.level.emoji,
              style: const TextStyle(fontSize: 36),
            ),

            const SizedBox(width: 14),

            // ── Content ────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mood label + time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mood.level.label,
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: mood.level.color,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        mood.timeDisplay,
                        style: const TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 12,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),

                  // Optional note
                  if (mood.note != null && mood.note!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      mood.note!,
                      style: const TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Tags
                  if (mood.tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: mood.tags.map((tag) => _TagChip(tag)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Small tag chip ─────────────────────────────────────────────
class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.neonCyan.withOpacity(0.08),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.neonCyan.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        '#$label',
        style: const TextStyle(
          fontFamily: 'Rajdhani',
          fontSize: 11,
          color: AppColors.neonCyan,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}