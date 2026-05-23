import 'package:flutter/material.dart';
import 'package:game_testing/screens/quick_maths/quick_maths_logic/level_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/responsive_config.dart';
import '../quick_maths/widget/simple_numpad.dart';
import 'widget/equation_display.dart';

class QuickMathsGameScreen extends StatefulWidget {
  QuickMathsGameScreen({super.key, required this.difficulty});

  String difficulty = 'Easy';

  @override
  State<QuickMathsGameScreen> createState() => _QuickMathsGameScreenState();
}

class _QuickMathsGameScreenState extends State<QuickMathsGameScreen> {
  String playerAnswer = "";
  bool? _prevIsCorrect;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lvl = Provider.of<QuickMathsLevelState>(context, listen: false);
      // listen to isCorrect changes so we can clear the player's answer after animation ends
      lvl.addListener(_onLevelStateChanged);
      _prevIsCorrect = lvl.isCorrect;
      lvl.gameSetup();
    });
  }

  @override
  void dispose() {
    // remove our listener
    try {
      Provider.of<QuickMathsLevelState>(context, listen: false)
          .removeListener(_onLevelStateChanged);
    } catch (_) {}
    super.dispose();
  }

  void _onLevelStateChanged() {
    final lvl = Provider.of<QuickMathsLevelState>(context, listen: false);
    final current = lvl.isCorrect;
    // when animation finishes (was non-null, now null) clear the player's answer
    if (_prevIsCorrect != current) {
      if (_prevIsCorrect != null && current == null) {
        setState(() {
          playerAnswer = "";
        });
      }
      _prevIsCorrect = current;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Responsive tile height for equations (will be clamped)
    double tileHeight = screenHeight * 0.09; // ~9% of height per tile
    if (tileHeight < 56) tileHeight = 56;
    if (tileHeight > 96) tileHeight = 96;

    final equations = context.watch<QuickMathsLevelState>().equations;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Provider.of<QuickMathsLevelState>(context, listen: false)
                  .stopTimer();
              context.go(RoutePath.menu.path);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: ResponsiveConfig.padding(context, size: PaddingSize.s),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ensure children fill width and respect outer padding
          children: [
            Padding(
              padding: ResponsiveConfig.edgeInsetsSymmetric(
                context,
                horizontal: SpacingSize.none,
                vertical: SpacingSize.s,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDarkVariant,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LEVEL',
                          style: AppTheme.descriptionTextStyle(context),
                        ),
                        Text('LIVES',
                            style: AppTheme.descriptionTextStyle(context)),
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveConfig.spacing(context,
                          size: SpacingSize.xxs),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context
                              .watch<QuickMathsLevelState>()
                              .level
                              .toString()
                              .padLeft(2, '0'),
                          style: AppTheme.subtitleTextStyle(context),
                        ),
                        Row(children: [
                          Row(
                            children: [
                              LivesIcon(
                                livesNeeded: 3,
                              ),
                              LivesIcon(
                                livesNeeded: 2,
                              ),
                              LivesIcon(
                                livesNeeded: 1,
                              ),
                            ],
                          )
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ), //Displaying Level & Lives
            Padding(
              // keep only small vertical padding; horizontal alignment comes from body padding
              padding: ResponsiveConfig.edgeInsetsSymmetric(
                context,
                horizontal: SpacingSize.none,
                vertical: SpacingSize.s,
              ),
              child: ProgressBarCountdown(
                total: context
                    .watch<QuickMathsLevelState>()
                    .totalSeconds
                    .toDouble(),
                remaining: context.watch<QuickMathsLevelState>().timeRemaining,
                backgroundColor: AppColors.surfaceDarkVariant,
                color: AppColors.primaryDarkVariant,
                height: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ), //Countdown
            Expanded(
              flex: 7,
              child: Padding(
                // keep only vertical spacing here; L/R uses outer body padding
                padding: ResponsiveConfig.edgeInsetsSymmetric(
                  context,
                  horizontal: SpacingSize.none,
                  vertical: SpacingSize.s,
                ),
                child: Center(
                  child: Builder(builder: (_) {
                    final eqs = context.watch<QuickMathsLevelState>().equations;
                    if (eqs.isEmpty) {
                      return Text(
                        'No equations',
                        style: AppTheme.subtitleTextStyle(context),
                        textAlign: TextAlign.center,
                      );
                    }
                    final top = eqs.first;

                    final providerIsCorrect = context.watch<QuickMathsLevelState>().isCorrect;

                    return SizedBox.expand(
                      child: MathEquationCard(
                        firstNumber: top.firstNumber.toString(),
                        secondNumber: top.secondNumber.toString(),
                        operator: top.operator,
                        playerAnswer: playerAnswer,
                        isCorrect: providerIsCorrect,
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  // no extra horizontal inset here; outer body padding governs L/R spacing
                  padding: ResponsiveConfig.edgeInsetsSymmetric(
                    context,
                    horizontal: SpacingSize.none,
                    vertical: SpacingSize.s,
                  ),
                  // add a transparent Material so any InkWell / InkResponse within the numpad works correctly
                  child: Material(
                    color: Colors.transparent,
                    child: SimpleNumpad(
                      buttonBorderRadius: 8,
                      gridSpacing: 6,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.surfaceDarkVariant,
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveConfig.textSize(context,
                              size: TextSize.xxl),
                          fontFamily: 'GoogleSans',
                          fontVariations: [FontVariation('wght', 700)]),
                      useBackspace: true,
                      optionText: 'Clear',
                      onPressed: (str) {
                        final lvl = context.read<QuickMathsLevelState>();
                        // ignore inputs while feedback animation is active
                        if (lvl.isCorrect != null) return;
                        // handle special keys
                        setState(() {
                          if (str == 'Clear') {
                            playerAnswer = "";
                          } else if (str == 'BACKSPACE') {
                            if (playerAnswer.isNotEmpty) {
                              playerAnswer = playerAnswer.substring(
                                  0, playerAnswer.length - 1);
                            }
                            return;
                          } else {
                            playerAnswer += str;
                          }
                        });
                        // try parse and evaluate
                        final parsed = int.tryParse(playerAnswer);
                        if (parsed != null &&
                            context
                                .read<QuickMathsLevelState>()
                                .equations
                                .isNotEmpty &&
                            context
                                    .read<QuickMathsLevelState>()
                                    .equations
                                    .first
                                    .result
                                    .toString()
                                    .length ==
                                parsed.toString().length) {
                          // call evaluate and let level_state manage timer/animation and eventual state reset
                          context.read<QuickMathsLevelState>().evaluate(parsed);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.m)), // slightly smaller gap
          ],
        ),
      ),
    );
  }
}

class LivesIcon extends StatelessWidget {
  const LivesIcon({super.key, required this.livesNeeded});

  final int livesNeeded;

  @override
  Widget build(BuildContext context) {
    return Icon(
      context.watch<QuickMathsLevelState>().lives >= livesNeeded
          ? Icons.favorite
          : Icons.heart_broken_outlined,
      color: AppColors.iconLogic,
      size: ResponsiveConfig.iconSize(context, size: IconSize.l),
    );
  }
}

class ProgressBarCountdown extends StatelessWidget {
  final double total;
  final double remaining;
  final double height;
  final Color color;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;

  const ProgressBarCountdown({
    Key? key,
    required this.total,
    required this.remaining,
    this.height = 6.0,
    this.color = Colors.blue,
    this.backgroundColor = const Color(0xFF2C3444),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double clampedTotal = (total <= 0) ? 1.0 : total;
    final double progress = (remaining / clampedTotal).clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: height,
            color: backgroundColor,
          ),
          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
