import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gajal_reader_page.dart';

class SayariReaderPage extends StatefulWidget {
  final int sayariId;
  const SayariReaderPage({super.key, required this.sayariId});

  @override
  State<SayariReaderPage> createState() => _SayariReaderPageState();
}

class _SayariReaderPageState extends State<SayariReaderPage>
    with TickerProviderStateMixin {
  List<dynamic> sayaris = [];
  int currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool isFlipping = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );

    loadSayaris();
  }

  Future<void> loadSayaris() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/sayaris.json');
      final data = json.decode(response);
      setState(() {
        sayaris = data['sayaris'];
        currentIndex = widget.sayariId - 1;
      });
    } catch (e) {
      print('Error loading sayaris: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentIndex < sayaris.length - 1 && !isFlipping) {
      setState(() => isFlipping = true);
      _animationController.forward().then((_) {
        setState(() => currentIndex++);
        _animationController.reset();
        setState(() => isFlipping = false);
      });
    } else if (currentIndex == sayaris.length - 1 && !isFlipping) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const GajalReaderPage(gajalId: 1)),
      );
    }
  }

  void previousPage() {
    if (currentIndex > 0 && !isFlipping) {
      setState(() => isFlipping = true);
      _animationController.forward().then((_) {
        setState(() => currentIndex--);
        _animationController.reset();
        setState(() => isFlipping = false);
      });
    }
  }

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
    englishToNepali.forEach((e, n) => result = result.replaceAll(e, n));
    return result;
  }

  Widget _buildColorfulText(String content) {
    final lines = content.split('\n');
    final colors = [
      Color(0xFF8B4513),
      Color(0xFF2E8B57),
      Color(0xFF4169E1),
      Color(0xFF8B008B),
      Color(0xFFFF6347),
      Color(0xFF32CD32),
      Color(0xFF9932CC),
      Color(0xFFFF4500),
      Color(0xFF008B8B),
      Color(0xFFB22222),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.asMap().entries.map((entry) {
        final index = entry.key;
        final line = entry.value;
        final color = colors[index % colors.length];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(line,
              style: TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  color: color,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Dancing Script',
                  fontStyle: FontStyle.italic)),
        );
      }).toList(),
    );
  }

  Widget _buildPage(Map<String, dynamic> sayari) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFDF5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFD2691E), width: 2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]),
      child: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: DiaryLinesPainter()),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(sayari['title'] ?? '',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Dancing Script',
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF2C3E50))),
                  ),
                  const SizedBox(height: 32),
                  _buildColorfulText(sayari['content'] ?? ''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageAnimation(Map<String, dynamic> sayari) {
    final slideOffset = Offset(_slideAnimation.value * 0.3, 0);
    final opacity = isFlipping ? (1.0 - _fadeAnimation.value) : 1.0;
    final scale = isFlipping ? _scaleAnimation.value : 1.0;

    return Transform.translate(
      offset: slideOffset,
      child: Transform.scale(
        scale: scale,
        child: Opacity(opacity: opacity, child: _buildPage(sayari)),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD2691E).withOpacity(0.8),
                    const Color(0xFFFF8C42).withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'गजलगम',
                style: TextStyle(
                  fontSize: 24,
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
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF0E6D2).withOpacity(0.9),
                const Color(0xFFE8DCC0).withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bookmark, color: const Color(0xFF8B4513), size: 16),
              const SizedBox(width: 6),
              Text(
                toNepaliDigits('${currentIndex + 1}/${sayaris.length}'),
                style: const TextStyle(
                    color: Color(0xFF8B4513),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (sayaris.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F1E8),
        appBar: _buildAppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentSayari = sayaris[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx > screenWidth / 2)
            nextPage();
          else
            previousPage();
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0)
            nextPage();
          else if (details.primaryVelocity! > 0) previousPage();
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => _buildPageAnimation(currentSayari),
        ),
      ),
    );
  }
}

class DiaryLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFE8E8E8)
      ..strokeWidth = 1.0;
    const lineSpacing = 32.0;
    for (double y = 60; y < size.height - 20; y += lineSpacing) {
      canvas.drawLine(Offset(24, y), Offset(size.width - 24, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
