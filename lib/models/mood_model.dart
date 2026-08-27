// ─────────────────────────────────────────────────────────────
// FILE: lib/models/mood_model.dart
// PURPOSE: Data model for a mood log entry.
//          In a real app, this would be saved to SQLite or
//          a cloud database. Includes helper methods for
//          serialization and display.
// ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ── Mood level enum (1 = worst, 5 = best) ─────────────────────
enum MoodLevel {
  terrible(1, '😔', 'TERRIBLE', AppColors.moodTerrible),
  bad     (2, '😟', 'BAD',      AppColors.moodBad),
  neutral (3, '😐', 'NEUTRAL',  AppColors.moodNeutral),
  good    (4, '🙂', 'GOOD',     AppColors.moodGood),
  great   (5, '😄', 'GREAT',    AppColors.moodGreat);

  final int value;
  final String emoji;
  final String label;
  final Color color;

  const MoodLevel(this.value, this.emoji, this.label, this.color);

  // Factory: get MoodLevel from int value
  static MoodLevel fromValue(int val) {
    return MoodLevel.values.firstWhere(
          (m) => m.value == val,
      orElse: () => MoodLevel.neutral,
    );
  }
}

// ── Mood log entry model ───────────────────────────────────────
class MoodModel {
  final String id;           // Unique entry ID
  final MoodLevel level;     // Mood rating
  final String? note;        // Optional journal note
  final List<String> tags;   // e.g. ['stressed', 'tired', 'work']
  final DateTime timestamp;  // When it was logged

  const MoodModel({
    required this.id,
    required this.level,
    this.note,
    this.tags = const [],
    required this.timestamp,
  });

  // ── Convert to Map for storage ────────────────────────────────
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level.value,
      'note': note,
      'tags': tags.join(','),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // ── Create from stored Map ────────────────────────────────────
  factory MoodModel.fromMap(Map<String, dynamic> map) {
    return MoodModel(
      id: map['id'] as String,
      level: MoodLevel.fromValue(map['level'] as int),
      note: map['note'] as String?,
      tags: (map['tags'] as String).isEmpty
          ? []
          : (map['tags'] as String).split(','),
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  // ── Human-readable time display ───────────────────────────────
  String get timeDisplay {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24)   return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  // ── Sample / dummy entries for UI testing ─────────────────────
  static List<MoodModel> get sampleData => [
    MoodModel(
      id: '1',
      level: MoodLevel.great,
      note: 'Focused session, completed all tasks.',
      tags: ['productive', 'focused'],
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    MoodModel(
      id: '2',
      level: MoodLevel.good,
      note: 'Morning walk helped clear my mind.',
      tags: ['exercise', 'calm'],
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    MoodModel(
      id: '3',
      level: MoodLevel.neutral,
      tags: ['tired'],
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    MoodModel(
      id: '4',
      level: MoodLevel.bad,
      note: 'Too much screen time, felt drained.',
      tags: ['stressed', 'screen-time'],
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    MoodModel(
      id: '5',
      level: MoodLevel.great,
      tags: ['rested', 'social'],
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];
}