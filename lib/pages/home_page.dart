import 'package:flutter/material.dart';

import '../widgets/settings_dialog.dart';
import 'content_list_page.dart';
import 'my_gajals_page.dart';
import 'write_gajal_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF5F1E8),
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
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
              colors: [
                Color(0xFFD2691E),
                Color(0xFFFF8C42),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [
                        const Color(0xFF4A3728).withOpacity(0.9),
                        const Color(0xFF6B4E3D).withOpacity(0.7),
                      ]
                    : [
                        const Color(0xFFD0C0A0).withOpacity(0.9),
                        const Color(0xFFE8DCC0).withOpacity(0.7),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                AppInfoDialog.show(context);
              },
              icon: Icon(
                Icons.info_outline,
                color: isDarkMode
                    ? const Color(0xFFF5F1E8)
                    : const Color(0xFF2C1810),
                size: 24,
              ),
              tooltip: 'About',
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    const Color(0xFF2C1810),
                    const Color(0xFF1A1A1A),
                    const Color(0xFF0F0F0F),
                  ]
                : [
                    const Color(0xFFFAF7F0),
                    const Color(0xFFF0E6D2),
                    const Color(0xFFE8DCC0),
                  ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Poem Section with Blood-like Effect
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDarkMode
                        ? [
                            const Color(0xFF2A1810).withOpacity(0.9),
                            const Color(0xFF1A0F0A).withOpacity(0.8),
                          ]
                        : [
                            const Color(0xFFFFFDF8).withOpacity(0.95),
                            const Color(0xFFF5F0E8).withOpacity(0.9),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF8B0000).withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B0000).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: const Color(0xFF660000).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full original content with blood effect
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'तिम्रो साथ पाए पछी भार बोक्न मन लाग्छ',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.8,
                          color: const Color(0xFF8B0000),
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              color: const Color(0xFF8B0000).withOpacity(0.5),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Second line
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'तिमी संगै भएको पल समय रोक्न मन लाग्छ',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.8,
                          color: const Color(0xFF8B0000),
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              color: const Color(0xFF8B0000).withOpacity(0.5),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Third line
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'म सुगम ठाउंको दुर्गम मान्छे हुँ प्रिय',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.8,
                          color: const Color(0xFF8B0000),
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              color: const Color(0xFF8B0000).withOpacity(0.5),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Fourth line
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'दुर्गम ममा सुगम प्रेमको बेर्ना रोप्न मन लाग्छ',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.8,
                          color: const Color(0xFF8B0000),
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              color: const Color(0xFF8B0000).withOpacity(0.5),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Action Buttons Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Read More Button
                    _buildActionButton(
                      context: context,
                      title: 'थप पढ्नुहोस्',
                      subtitle: 'गजल र सायरी संग्रह',
                      icon: Icons.library_books,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8B4513),
                          Color(0xFFCD853F),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContentListPage(),
                          ),
                        );
                      },
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 16),

                    // Write Your Own Gajal Button
                    _buildActionButton(
                      context: context,
                      title: 'आफ्नो गजल लेख्नुहोस्',
                      subtitle: 'नयाँ गजल सिर्जना गर्नुहोस्',
                      icon: Icons.edit,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFD2691E),
                          Color(0xFFFF8C42),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WriteGajalPage(),
                          ),
                        );
                      },
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 16),

                    // My Gajals Button
                    _buildActionButton(
                      context: context,
                      title: 'मेरा गजलहरू',
                      subtitle: 'तपाईंका सिर्जनाहरू',
                      icon: Icons.folder_special,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6B4E3D),
                          Color(0xFF8B7355),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyGajalsPage(),
                          ),
                        );
                      },
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onPressed,
    required bool isDarkMode,
  }) {
    return Container(
      width: double.infinity,
      height: 82,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
