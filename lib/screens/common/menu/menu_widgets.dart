import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// THEME & CONSTANTS (Apex Podium / Smart Games Dark Palette)
/// ---------------------------------------------------------------------------
class SmartGamesTheme {
  static const Color background = Color(0xFF0C0E14);
  static const Color surfaceCard = Color(0xFF191C21);
  static const Color surfaceCardBorder = Color(0xFF2C3444);

  // Accents
  static const Color cyan = Color(0xFF00E5FF);
  static const Color cyanGlow = Color(0x3300E5FF);
  static const Color amber = Color(0xFFFFB300);
  static const Color amberGlow = Color(0x33FFB300);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF90A4AE);
  static const Color textMuted = Color(0xFF455A64);
  static const Color lockedColor = Color(0xFF1F242F);
  static const Color lockedIcon = Color(0xFF374151);
}

/// ---------------------------------------------------------------------------
/// 1. N-DAY STREAK WIDGET
/// ---------------------------------------------------------------------------

class StreakDayStatus {
  final String label; // "M", "T", "W", "T", "F", "S", "TODAY"
  final bool isCompleted;
  final bool isToday;

  const StreakDayStatus({
    required this.label,
    this.isCompleted = false,
    this.isToday = false,
  });
}

class NDayStreakCard extends StatelessWidget {
  final int streakDays;
  final int milestoneTarget;
  final int daysRemaining;
  final String milestoneBadgeName;
  final List<StreakDayStatus> weekDays;

  const NDayStreakCard({
    super.key,
    this.streakDays = 12,
    this.milestoneTarget = 14,
    this.daysRemaining = 2,
    this.milestoneBadgeName = "2-week master streak badge",
    this.weekDays = const [
      StreakDayStatus(label: 'M', isCompleted: true),
      StreakDayStatus(label: 'T', isCompleted: true),
      StreakDayStatus(label: 'W', isCompleted: true),
      StreakDayStatus(label: 'T', isCompleted: true),
      StreakDayStatus(label: 'F', isCompleted: true),
      StreakDayStatus(label: 'S', isCompleted: true),
      StreakDayStatus(label: 'TODAY', isCompleted: true, isToday: true),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SmartGamesTheme.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: SmartGamesTheme.surfaceCardBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Streak Title + Active Badge + Counter (12 / 14)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$streakDays Day Streak',
                style: const TextStyle(
                  color: SmartGamesTheme.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: SmartGamesTheme.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: SmartGamesTheme.amber.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    color: SmartGamesTheme.amber,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$streakDays ',
                      style: const TextStyle(
                        color: SmartGamesTheme.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: '/ $milestoneTarget',
                      style: const TextStyle(
                        color: SmartGamesTheme.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Subtitle / Next milestone hint
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: SmartGamesTheme.textSecondary,
                fontSize: 13,
                height: 1.35,
              ),
              children: [
                const TextSpan(text: "You're "),
                TextSpan(
                  text: '$daysRemaining days away',
                  style: const TextStyle(
                    color: SmartGamesTheme.amber,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: ' from unlocking the $milestoneBadgeName!'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 7-day progress indicator row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays.map((day) => _buildDayItem(day)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(StreakDayStatus day) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day.label,
          style: TextStyle(
            color: day.isToday ? SmartGamesTheme.cyan : SmartGamesTheme.textMuted,
            fontSize: day.isToday ? 10 : 11,
            fontWeight: day.isToday ? FontWeight.w800 : FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: day.isToday
                ? SmartGamesTheme.cyan
                : (day.isCompleted
                ? SmartGamesTheme.amber
                : SmartGamesTheme.lockedColor),
            boxShadow: [
              if (day.isToday)
                BoxShadow(
                  color: SmartGamesTheme.cyan.withOpacity(0.8),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              else if (day.isCompleted)
                BoxShadow(
                  color: SmartGamesTheme.amber.withOpacity(0.4),
                  blurRadius: 6,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// 2. TODAY'S COGNITIVE ROUTINE (LINEAR PIPELINE STEPPER WIDGET)
/// ---------------------------------------------------------------------------
enum RoutineStepState { done, active, locked }

class RoutineStepItem {
  final String title;
  final String statusText;
  final IconData icon;
  final RoutineStepState state;

  const RoutineStepItem({
    required this.title,
    required this.statusText,
    required this.icon,
    required this.state,
  });
}

class TodaysCognitiveRoutineCard extends StatelessWidget {
  final String resetCountdown; // e.g. "05:42:19"
  final int completedCount;
  final int totalCount;
  final String activeGameTitle;
  final List<RoutineStepItem> steps;
  final VoidCallback? onPlayNext;

  const TodaysCognitiveRoutineCard({
    super.key,
    this.resetCountdown = '05:42:19',
    this.completedCount = 2,
    this.totalCount = 4,
    this.activeGameTitle = 'Target Trio',
    this.steps = const [
      RoutineStepItem(
        title: 'Quick Maths',
        statusText: 'Done',
        icon: Icons.check_rounded,
        state: RoutineStepState.done,
      ),
      RoutineStepItem(
        title: 'Blink Count',
        statusText: 'Done',
        icon: Icons.check_rounded,
        state: RoutineStepState.done,
      ),
      RoutineStepItem(
        title: 'Target Trio',
        statusText: 'Next',
        icon: Icons.track_changes_rounded, // or custom target icon
        state: RoutineStepState.active,
      ),
      RoutineStepItem(
        title: 'Color Shift',
        statusText: 'Locked',
        icon: Icons.lock_outline_rounded,
        state: RoutineStepState.locked,
      ),
    ],
    this.onPlayNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SmartGamesTheme.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: SmartGamesTheme.surfaceCardBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Tag & Resets Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DAILY SET',
                style: TextStyle(
                  color: SmartGamesTheme.cyan,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF14171E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: SmartGamesTheme.surfaceCardBorder,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('⏳', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 6),
                    Text(
                      resetCountdown,
                      style: const TextStyle(
                        color: SmartGamesTheme.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Main Header Title
          const Text(
            "Today's Cognitive Routine",
            style: TextStyle(
              color: SmartGamesTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 14),

          // Routine Status row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ROUTINE STATUS',
                style: TextStyle(
                  color: SmartGamesTheme.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$completedCount ',
                      style: const TextStyle(
                        color: SmartGamesTheme.cyan,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const TextSpan(
                      text: '/ ',
                      style: TextStyle(
                        color: SmartGamesTheme.textMuted,
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: '$totalCount COMPLETED',
                      style: const TextStyle(
                        color: SmartGamesTheme.cyan,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Connected Linear Process Nodes
          _buildProcessDiagram(),
          const SizedBox(height: 28),

          // Play Next Game CTA Button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: onPlayNext ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2979FF), // Vibrant Neon Blue
                foregroundColor: Colors.white,
                elevation: 10,
                shadowColor: const Color(0xFF2979FF).withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.play_arrow_rounded, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Play Next Game ($activeGameTitle)',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessDiagram() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            // Connecting line running behind nodes
            Positioned(
              top: 24, // Vertically centered through 48px circles
              left: 30,
              right: 30,
              child: CustomPaint(
                size: Size(constraints.maxWidth - 60, 2),
                painter: _ProcessLinePainter(steps: steps),
              ),
            ),

            // Step nodes row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: steps.asMap().entries.map((entry) {
                return Expanded(
                  child: _buildNode(entry.value),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNode(RoutineStepItem step) {
    Color borderColor;
    Color nodeBg;
    Color iconColor;
    bool hasGlow = false;

    switch (step.state) {
      case RoutineStepState.done:
        borderColor = const Color(0xFF00E676); // Emerald / Mint
        nodeBg = SmartGamesTheme.surfaceCard;
        iconColor = const Color(0xFF00E676);
        hasGlow = false;
        break;
      case RoutineStepState.active:
        borderColor = SmartGamesTheme.cyan;
        nodeBg = SmartGamesTheme.surfaceCard;
        iconColor = SmartGamesTheme.cyan;
        hasGlow = true;
        break;
      case RoutineStepState.locked:
        borderColor = SmartGamesTheme.lockedIcon;
        nodeBg = SmartGamesTheme.lockedColor;
        iconColor = SmartGamesTheme.lockedIcon;
        hasGlow = false;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circular Node with optional glow
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: nodeBg,
            border: Border.all(
              color: borderColor,
              width: step.state == RoutineStepState.locked ? 1.5 : 2,
            ),
            boxShadow: [
              if (hasGlow) ...[
                BoxShadow(
                  color: SmartGamesTheme.cyan.withOpacity(0.55),
                  blurRadius: 14,
                  spreadRadius: 2,
                ),
              ],
            ],
          ),
          child: Center(
            child: Icon(
              step.icon,
              color: iconColor,
              size: 22,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Game Title
        Text(
          step.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: step.state == RoutineStepState.locked
                ? SmartGamesTheme.textMuted
                : SmartGamesTheme.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),

        // Status Subtitle (Done / • Next / Locked)
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (step.state == RoutineStepState.active) ...[
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: SmartGamesTheme.cyan,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              step.statusText,
              style: TextStyle(
                color: step.state == RoutineStepState.done
                    ? SmartGamesTheme.textSecondary
                    : (step.state == RoutineStepState.active
                    ? SmartGamesTheme.cyan
                    : SmartGamesTheme.textMuted),
                fontSize: 10,
                fontWeight: step.state == RoutineStepState.active
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Custom painter for solid / glowing vs dashed connection lines between step nodes
class _ProcessLinePainter extends CustomPainter {
  final List<RoutineStepItem> steps;

  _ProcessLinePainter({required this.steps});

  @override
  void paint(Canvas canvas, Size size) {
    if (steps.length < 2) return;

    final segmentWidth = size.width / (steps.length - 1);

    for (int i = 0; i < steps.length - 1; i++) {
      final startX = i * segmentWidth;
      final endX = (i + 1) * segmentWidth;
      final y = size.height / 2;

      final current = steps[i];
      final next = steps[i + 1];

      // If connecting two finished nodes or completed-to-active node: solid glowing cyan/green line
      final isConnected = (current.state == RoutineStepState.done &&
          (next.state == RoutineStepState.done || next.state == RoutineStepState.active));

      if (isConnected) {
        final paint = Paint()
          ..color = const Color(0xFF00E676)
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

        // Subtle glow line
        final glowPaint = Paint()
          ..color = const Color(0xFF00E676).withOpacity(0.3)
          ..strokeWidth = 6
          ..style = PaintingStyle.stroke;

        canvas.drawLine(Offset(startX, y), Offset(endX, y), glowPaint);
        canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
      } else {
        // Dashed muted line for upcoming/locked segments
        final dashPaint = Paint()
          ..color = SmartGamesTheme.lockedIcon
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

        const dashWidth = 4.0;
        const dashSpace = 4.0;
        double currentX = startX;

        while (currentX < endX) {
          canvas.drawLine(
            Offset(currentX, y),
            Offset((currentX + dashWidth).clamp(startX, endX), y),
            dashPaint,
          );
          currentX += dashWidth + dashSpace;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
