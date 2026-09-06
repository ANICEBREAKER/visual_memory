import 'package:flutter/material.dart';
import 'package:game_testing/router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/responsive_config.dart';
import '../quick_maths/quick_maths_game_screen.dart';
import 'color_shift_logic/level_state.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ColorShiftGameScreen extends StatefulWidget {
  const ColorShiftGameScreen({super.key});

  @override
  State<ColorShiftGameScreen> createState() => _ColorShiftGameScreenState();
}

class _ColorShiftGameScreenState extends State<ColorShiftGameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ColorShiftLevelState>(context, listen: false).gameSetup();
    });
  }

  @override
  void dispose() {
    context.read<ColorShiftLevelState>().stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<ColorShiftLevelState>().stopTimer();
            context.go(RoutePath.menu.path); // TODO: Change this sometime
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: ResponsiveConfig.padding(context, size: PaddingSize.s),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        Text('',
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
                              .watch<ColorShiftLevelState>()
                              .level
                              .toString()
                              .padLeft(2, '0'),
                          style: AppTheme.subtitleTextStyle(context),
                        ),
                        Row(),
                      ],
                    ),
                  ],
                ),
              ),
            ), //Displaying Level & Lives
            SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.s),
            ),
            //Timer
            Padding(
              padding: ResponsiveConfig.edgeInsetsSymmetric(
                context,
                horizontal: SpacingSize.none,
                vertical: SpacingSize.s,
              ),
              child: ProgressBarCountdown( //May need to move the time to a widget file
                total: context
                    .watch<ColorShiftLevelState>()
                    .totalSeconds
                    .toDouble(),
                remaining:
                    context.watch<ColorShiftLevelState>().timeRemaining,
                backgroundColor: AppColors.surfaceDarkVariant,
                color: AppColors.primaryDarkVariant,
                height: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
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
                child: Center(
                  child: Text(
                    context.watch<ColorShiftLevelState>().displayedText.toUpperCase(),
                    style: TextStyle(
                      fontSize: ResponsiveConfig.textSize(context, size: TextSize.fourxl), // 100
                      fontWeight: FontWeight.w900,
                      color: context.watch<ColorShiftLevelState>().getTextColor(), // Use mapped color
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveConfig.spacing(context, size: SpacingSize.s),
            ),
            Expanded(
              child: context.watch<ColorShiftLevelState>().isVocalMode
                  ? SoundInterface()
                  : answerButtons(),
            ),
          ],
        ),
      ),
    );
  }
}

class answerButtons extends StatelessWidget {
  const answerButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1, // Square cells
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final colorName = context.watch<ColorShiftLevelState>().colorList[index];
        return Visibility(
          visible: index < context.watch<ColorShiftLevelState>().colorsInPlay,
          child: InkWell(
            onTap: () {
              context.read<ColorShiftLevelState>().evaluate(colorName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceDarkVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderDark
                ),
              ),
              child: Center(
                child: Text(
                  colorName.toUpperCase(),
                  style: TextStyle(
                    fontSize: ResponsiveConfig.textSize(context, size: TextSize.l),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDarkVariant,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SoundInterface extends StatefulWidget {
  const SoundInterface({Key? key}) : super(key: key);

  @override
  _SoundInterfaceState createState() => _SoundInterfaceState();
}

class _SoundInterfaceState extends State<SoundInterface> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    try {
      _speechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          debugPrint('Speech status: $status');
          setState(() {});
        },
        onError: (errorNotification) {
          debugPrint('Speech error: $errorNotification');
          setState(() {});
        },
      );
    } catch (e) {
      debugPrint('Speech initialization failed: $e');
      _speechEnabled = false;
    }
    setState(() {});
  }

  void _startListening() async {
    _lastWords = '';
    await _speechToText.listen(
      onResult: _onSpeechResult,
      cancelOnError: true,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.toFinal().recognizedWords.trim().split(' ').last;
    });

    final colorList = context.read<ColorShiftLevelState>().colorList;
    if (colorList.contains(_lastWords.toLowerCase())) {
      context.read<ColorShiftLevelState>().evaluate(_lastWords.toLowerCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _speechToText.isListening
              ? _lastWords
              : _speechEnabled
                  ? 'Tap the microphone to start listening...'
                  : 'Speech recognition not available.',
          style: TextStyle(fontSize: 20.0),
        ),
        const SizedBox(height: 20),
        FloatingActionButton(
          onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
          tooltip: 'Listen',
          child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ],
    );
  }
}
