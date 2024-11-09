import 'dart:math';
import 'package:chakravyuh/screens/instruction_screen.dart';
import 'package:chakravyuh/screens/question_screen.dart';
import 'package:chakravyuh/widgets/next_button.dart';
import 'package:flutter/material.dart';

class FloatingTextScreen extends StatefulWidget {
  const FloatingTextScreen({super.key});

  @override
  _FloatingTextScreenState createState() => _FloatingTextScreenState();
}

class _FloatingTextScreenState extends State<FloatingTextScreen>
    with TickerProviderStateMixin {
  final Random _random = Random();
  final String _staticText = 'b';
  final List<TextItem> _textItems = [];
  late Size _screenSize = Size.zero;

  // Store random position for static text
  late double _staticTextX;
  late double _staticTextY;

  final List<String> _words = [
    'a',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    'a',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    'a',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    'a',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];

  Color _generateBrightColor() {
    const minBrightness = 200;
    return Color.fromARGB(
      255,
      minBrightness + _random.nextInt(56),
      minBrightness + _random.nextInt(56),
      minBrightness + _random.nextInt(56),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _initializeStaticTextPosition();
        _initializeTextItems();
        _startAnimation();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.of(context).size;
    _initializeStaticTextPosition();
  }

  void _initializeStaticTextPosition() {
    const padding = 40.0; // Padding from screen edges
    const bottomReservedHeight = 80.0; // Reserved space for button area

    // Ensure the static text position is not near the Next button
    do {
      _staticTextX =
          padding + _random.nextDouble() * (_screenSize.width - 2 * padding);
      _staticTextY = padding +
          _random.nextDouble() *
              (_screenSize.height - bottomReservedHeight - 2 * padding);
    } while (
        _staticTextY > _screenSize.height - bottomReservedHeight - padding);
  }

  void _initializeTextItems() {
    _textItems.clear(); // Clear existing items before adding new ones
    for (int i = 0; i < 100; i++) {
      // Increase the loop count to 100 for more alphabets
      _textItems.add(
        TextItem(
          text: _words[_random.nextInt(_words.length)],
          xPosition: _random.nextDouble() * _screenSize.width,
          yPosition: _random.nextDouble() * _screenSize.height,
          xVelocity: (_random.nextDouble() - 0.5) * 50,
          yVelocity: (_random.nextDouble() - 0.5) * 50,
          size: 14 + _random.nextInt(16),
          color: _generateBrightColor(),
          vsync: this,
        ),
      );
    }
  }

  void _startAnimation() {
    for (final textItem in _textItems) {
      textItem.controller.duration =
          Duration(seconds: 20 + _random.nextInt(20));
      textItem.controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    for (final item in _textItems) {
      item.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background layer for floating text
          ...List.generate(
            _textItems.length,
            (index) => AnimatedBuilder(
              animation: _textItems[index].controller,
              builder: (context, child) {
                final double animationValue =
                    _textItems[index].controller.value;

                final double newXPosition = _textItems[index].xPosition +
                    (_textItems[index].xVelocity *
                        sin(animationValue * pi * 2));
                final double newYPosition = _textItems[index].yPosition +
                    (_textItems[index].yVelocity *
                        cos(animationValue * pi * 2));

                if (newXPosition < 0 || newXPosition > _screenSize.width) {
                  _textItems[index].xVelocity *= -1;
                }
                if (newYPosition < 0 || newYPosition > _screenSize.height) {
                  _textItems[index].yVelocity *= -1;
                }

                return Positioned(
                  left: newXPosition,
                  top: newYPosition,
                  child: Text(
                    _textItems[index].text,
                    style: TextStyle(
                      fontSize: _textItems[index].size.toDouble(),
                      color: _textItems[index].color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          // Static text
          Positioned(
            left: _staticTextX,
            top: _staticTextY,
            child: Text(
              _staticText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Next button on top layer
          const Align(
            alignment: Alignment.bottomCenter, // Changed to bottomCenter
            child: Padding(
              padding: EdgeInsets.only(bottom: 32.0), // Added bottom padding
              child: NextButton(nextScreen: QuestionScreen(title: "Question")),
            ),
          ),
        ],
      ),
    );
  }
}

class TextItem {
  String text;
  double xPosition;
  double yPosition;
  double xVelocity;
  double yVelocity;
  int size;
  Color color;
  late final AnimationController controller;

  TextItem({
    required this.text,
    required this.xPosition,
    required this.yPosition,
    required this.xVelocity,
    required this.yVelocity,
    required this.size,
    required this.color,
    required TickerProvider vsync,
  }) {
    controller = AnimationController(
      duration: Duration.zero,
      vsync: vsync,
    );
  }
}
