import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../database/database_helper.dart';

// Global responsive utility
class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  static double scaleWidth(double width) => blockSizeHorizontal * width;
  static double scaleHeight(double height) => blockSizeVertical * height;
  static double scaleText(double fontSize) => fontSize * (screenWidth / 400);
}

// Utility function for Nepali date formatting
String formatNepaliDate(DateTime date) {
  const nepaliMonths = [
    'जनवरी',
    'फेब्रुअरी',
    'मार्च',
    'अप्रिल',
    'मे',
    'जुन',
    'जुलाई',
    'अगस्त',
    'सेप्टेम्बर',
    'अक्टोबर',
    'नोभेम्बर',
    'डिसेम्बर'
  ];

  String toNepaliDigits(String number) {
    const englishToNepali = {
      '0': '०',
      '1': '१',
      '2': '२',
      '3': '३',
      '4': '४',
      '5': '५',
      '6': '६',
      '7': '७',
      '8': '८',
      '9': '९',
    };
    String result = number;
    englishToNepali.forEach((english, nepali) {
      result = result.replaceAll(english, nepali);
    });
    return result;
  }

  final day = toNepaliDigits(date.day.toString());
  final month = nepaliMonths[date.month - 1];
  final year = toNepaliDigits(date.year.toString());
  return '$day $month $year';
}

class UserGajalReaderPage extends StatefulWidget {
  final UserGajal gajal;
  final List<UserGajal> allGajals;
  final int currentIndex;

  const UserGajalReaderPage({
    super.key,
    required this.gajal,
    required this.allGajals,
    required this.currentIndex,
  });

  @override
  State<UserGajalReaderPage> createState() => _UserGajalReaderPageState();
}

class _UserGajalReaderPageState extends State<UserGajalReaderPage>
    with TickerProviderStateMixin {
  late int currentIndex;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isFlipping = false;

  String toNepaliDigits(String number) {
    const englishToNepali = {
      '0': '०',
      '1': '१',
      '2': '२',
      '3': '३',
      '4': '४',
      '5': '५',
      '6': '६',
      '7': '७',
      '8': '८',
      '9': '९',
    };
    String result = number;
    englishToNepali.forEach((english, nepali) {
      result = result.replaceAll(english, nepali);
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.easeInOutQuart,
      ),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playFlipSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/page_flip.mp3'));
    } catch (e) {}
  }

  void nextPage() {
    if (currentIndex < widget.allGajals.length - 1 && !isFlipping) {
      setState(() => isFlipping = true);
      playFlipSound();
      _flipController.forward().then((_) {
        setState(() {
          currentIndex++;
          isFlipping = false;
        });
        _flipController.reset();
      });
    }
  }

  void previousPage() {
    if (currentIndex > 0 && !isFlipping) {
      setState(() => isFlipping = true);
      playFlipSound();
      _flipController.forward().then((_) {
        setState(() {
          currentIndex--;
          isFlipping = false;
        });
        _flipController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final currentGajal = widget.allGajals[currentIndex];

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF2C1810) : const Color(0xFFF5F1E8),
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.scaleWidth(5),
            vertical: SizeConfig.scaleHeight(1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleWidth(4),
                  vertical: SizeConfig.scaleHeight(1),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFD2691E).withOpacity(0.8),
                      const Color(0xFFFF8C42).withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: SizeConfig.scaleWidth(2),
                      offset: Offset(0, SizeConfig.scaleHeight(0.5)),
                    ),
                  ],
                ),
                child: Text(
                  'गजलगम',
                  style: TextStyle(
                    fontSize: SizeConfig.scaleText(24),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Dancing Script',
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFFD2691E),
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD2691E), Color(0xFFFF8C42)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: SizeConfig.scaleWidth(3)),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(4),
              vertical: SizeConfig.scaleHeight(1),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [
                        const Color(0xFF4A3728).withOpacity(0.9),
                        const Color(0xFF6B4E3D).withOpacity(0.8),
                      ]
                    : [
                        const Color(0xFFF0E6D2).withOpacity(0.9),
                        const Color(0xFFE8DCC0).withOpacity(0.8),
                      ],
              ),
              borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(3)),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bookmark,
                  color: isDarkMode
                      ? const Color(0xFFD4A574)
                      : const Color(0xFF8B4513),
                  size: SizeConfig.scaleText(16),
                ),
                SizedBox(width: SizeConfig.scaleWidth(1.5)),
                Text(
                  toNepaliDigits(
                      '${currentIndex + 1}/${widget.allGajals.length}'),
                  style: TextStyle(
                    color: isDarkMode
                        ? const Color(0xFFD4A574)
                        : const Color(0xFF8B4513),
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.scaleText(14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx > screenWidth / 2) {
            nextPage();
          } else {
            previousPage();
          }
        },
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_flipAnimation.value * 3.14159),
              child: _buildPage(currentGajal, isDarkMode),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(UserGajal gajal, bool isDarkMode) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(SizeConfig.scaleWidth(4)),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF3D2817) : const Color(0xFFE8E0D0),
        borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(3)),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF6B4E3D) : const Color(0xFFD0C0A0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: SizeConfig.scaleWidth(2),
            offset: Offset(0, SizeConfig.scaleHeight(1)),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.scaleWidth(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                gajal.title,
                style: TextStyle(
                  fontSize: SizeConfig.scaleText(24),
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? const Color(0xFFD4A574)
                      : const Color(0xFF8B4513),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(2)),
            Center(
              child: Text(
                'लेखिएको मिति: ${formatNepaliDate(gajal.createdAt)}',
                style: TextStyle(
                  fontSize: SizeConfig.scaleText(12),
                  color: isDarkMode
                      ? const Color(0xFF8B7355)
                      : const Color(0xFF8B4513),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(4)),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  gajal.content,
                  style: TextStyle(
                    fontSize: SizeConfig.scaleText(14),
                    height: 1.6,
                    color: isDarkMode
                        ? const Color(0xFFE0E0E0)
                        : const Color(0xFF2C2C2C),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  Text(
                    '← अघिल्लो',
                    style: TextStyle(
                      color: isDarkMode
                          ? const Color(0xFF8B7355)
                          : const Color(0xFF8B4513),
                      fontSize: SizeConfig.scaleText(14),
                    ),
                  ),
                if (currentIndex < widget.allGajals.length - 1)
                  Text(
                    'अर्को →',
                    style: TextStyle(
                      color: isDarkMode
                          ? const Color(0xFF8B7355)
                          : const Color(0xFF8B4513),
                      fontSize: SizeConfig.scaleText(14),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
