import 'package:flutter/material.dart';
import 'package:game_testing/player_progress/player_progress.dart';
import 'package:game_testing/theme/button_design.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import '../../../helper/connection_checker.dart';
import '../../../router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/responsive_config.dart';

class GameResultScreen extends StatefulWidget {
  final int level;
  final String difficulty;
  final String game_path;

  const GameResultScreen(
      {super.key,
      required this.level,
      required this.difficulty,
      required this.game_path});

  @override
  State<GameResultScreen> createState() => _QuickMathsResultScreen();
}

class _QuickMathsResultScreen extends State<GameResultScreen> {
  bool isConnectedWithInternet = false;

  @override
  void initState() {
    print("Player score: ${widget.level}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<PlayerProgress>().reset();
      await context
          .read<PlayerProgress>()
          .getLatestFromStore(widget.game_path, widget.difficulty);
      if (mounted) {
        //print("Stored high score: ${context.read<PlayerProgress>().highestLevelReached}");
        context
            .read<PlayerProgress>()
            .setLevelReached(widget.level, widget.game_path, widget.difficulty);
      } else {
        //print("Widget not mounted, cannot access context.");
        return;
      }
    });
    hasSecureInternetConnection().then((value) {
      setState(() {
        isConnectedWithInternet = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkDimmed,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go(RoutePath.menu.path);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.primaryDarkVariant,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: AppColors.primaryDarkVariant,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Symbols.trophy,
                color: AppColors.primaryDarkVariant,
                size: ResponsiveConfig.iconSize(context, size: IconSize.xxl),
              ),
              SizedBox(
                height: ResponsiveConfig.spacing(context, size: SpacingSize.s),
              ),
              Text('Level ${widget.level}',
                  style: AppTheme.titleTextStyle(context)),
              SizedBox(
                height: ResponsiveConfig.spacing(context, size: SpacingSize.s),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF121826), // surfaceDark
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Color(0xFF2C3444)), // borderDark
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFF393428),
                            // mediumDifficulty tint
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.stars_rounded,
                              color: Color(0xFFFFB300), size: 24),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.watch<PlayerProgress>().isNewHighScore?'New High Score!':'Good job!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                context.watch<PlayerProgress>().isNewHighScore?"Congratulations!":"You can do it next time!",
                                style: TextStyle(
                                  color: Color(0xFF90A4AE), // textSecondaryDark
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    // --- Simplified Progress Graph ---
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: CustomPaint(
                        painter:
                            LineGraphPainter(scores: [10, 15, 12, 25, 22, widget.level]),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LAST 5 GAMES',
                          style: TextStyle(
                              color: Color(0xFF455A64),
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'CURRENT',
                          style: TextStyle(
                              color: Color(0xFF455A64),
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ResponsiveConfig.spacing(context, size: SpacingSize.m),
              ),
              GlobalStandingCard(performancePercent: 0.85),
              SizedBox(
                height: ResponsiveConfig.spacing(context, size: SpacingSize.m),
              ),
              Padding(
                padding:
                    ResponsiveConfig.padding(context, size: PaddingSize.xs),
                child: BasicBlueButton(
                    route: RoutePath.gameSelection, label: "Play more!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GlobalStandingCard extends StatelessWidget {
  final double performancePercent; // e.g., 0.85 for 85%

  const GlobalStandingCard({
    super.key,
    required this.performancePercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:  Color(0xFF121826), // surfaceDark
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color:  Color(0xFF2C3444)), // borderDark
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GLOBAL STANDING',
                style: TextStyle(
                  color: Color(0xFF00E5FF), // primaryDark Variant
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              Icon(Icons.trending_up_rounded, color: Color(0xFF00E5FF), size: 20),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Top ${((1 - performancePercent) * 100).round()}%",
            style:  TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PERFORMANCE',
                style: TextStyle(color: Color(0xFF455A64), fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                '${(performancePercent * 100).toInt()}% beaten!',
                style:  TextStyle(color: Color(0xFF455A64), fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          // --- Custom Progress Bar ---
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:  Color(0xFF1A1F2E),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: performancePercent,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF2196F3)]),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:  Color(0xFF00E5FF),
                        blurRadius: 8,
                        offset:  Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            'You beat ${(performancePercent * 100).toInt()}% of players this week.',
            style:  TextStyle(
              color: Color(0xFF90A4AE),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class LineGraphPainter extends CustomPainter {
  final List<int> scores;

  LineGraphPainter({required this.scores});

  @override
  void paint(Canvas canvas, Size size) {
    if (scores.isEmpty) return;

    final paint = Paint()
      ..color =  Color(0xFF00E5FF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [ Color(0xFF00E5FF).withOpacity(0.2), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final fillPath = Path();

    final maxScore = scores.reduce((a, b) => a > b ? a : b);
    final dx = size.width / (scores.length - 1);

    for (int i = 0; i < scores.length; i++) {
      final x = i * dx;
      final y = size.height - (scores[i] / maxScore * size.height);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        // Simple cubic bezier for smoothing
        final prevX = (i - 1) * dx;
        final prevY = size.height - (scores[i - 1] / maxScore * size.height);
        path.cubicTo(
          prevX + dx / 2, prevY,
          x - dx / 2, y,
          x, y,
        );
        fillPath.cubicTo(
          prevX + dx / 2, prevY,
          x - dx / 2, y,
          x, y,
        );
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw current point glow
    final lastX = size.width;
    final lastY = size.height - (scores.last / maxScore * size.height);
    canvas.drawCircle(Offset(lastX, lastY), 5, Paint()..color = Colors.white);
    canvas.drawCircle(
      Offset(lastX, lastY),
      10,
      Paint()..color =  Color(0xFF00E5FF).withOpacity(0.3),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

