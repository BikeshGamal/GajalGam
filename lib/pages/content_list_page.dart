import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/settings_dialog.dart';
import 'gajal_reader_page.dart';
import 'sayari_reader_page.dart';

class ContentListPage extends StatefulWidget {
  const ContentListPage({super.key});

  @override
  State<ContentListPage> createState() => _ContentListPageState();
}

class _ContentListPageState extends State<ContentListPage> {
  int gajalCount = 0;
  int sayariCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadContentCounts();
  }

  Future<void> loadContentCounts() async {
    try {
      final gajalResponse =
          await rootBundle.loadString('assets/data/gajals.json');
      final gajalData = json.decode(gajalResponse);
      final gajals = gajalData['gajals'] as List;

      final sayariResponse =
          await rootBundle.loadString('assets/data/sayaris.json');
      final sayariData = json.decode(sayariResponse);
      final sayaris = sayariData['sayaris'] as List;

      setState(() {
        gajalCount = gajals.length;
        sayariCount = sayaris.length;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        gajalCount = 15; // fallback
        sayariCount = 15; // fallback
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF2C1810) : const Color(0xFFF5F1E8),
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFD2691E).withOpacity(0.8),
                      const Color(0xFFFF8C42).withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.r,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'गजलगम',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Dancing Script',
                    letterSpacing: 1.2.w,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(1.w, 1.h),
                        blurRadius: 2.r,
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
            margin: EdgeInsets.only(right: 12.w),
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
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: isDarkMode
                    ? const Color(0xFFD4A574)
                    : const Color(0xFF8B4513),
                size: 24.sp,
              ),
              onPressed: () => AppInfoDialog.show(context),
              tooltip: 'About',
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/cover_page.png'),
            fit: BoxFit.cover,
            opacity: isDarkMode ? 0.1 : 0.15,
            colorFilter: ColorFilter.mode(
              isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.white.withOpacity(0.2),
              BlendMode.overlay,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFF3D2817)
                        : const Color(0xFFE8E0D0),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: isDarkMode
                          ? const Color(0xFF6B4E3D)
                          : const Color(0xFFD0C0A0),
                      width: 1.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF6B4E3D)
                              : const Color(0xFFD0C0A0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          'गजल र सायरीहरू',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? const Color(0xFFF5F1E8)
                                : const Color(0xFF2C1810),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                padding: EdgeInsets.all(8.w),
                                itemCount: gajalCount + sayariCount,
                                itemBuilder: (context, index) {
                                  final isGajal = index < gajalCount;
                                  final itemIndex =
                                      isGajal ? index : index - gajalCount;
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 6.h),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: isDarkMode
                                            ? [
                                                const Color(0xFF6B4E3D)
                                                    .withOpacity(0.8),
                                                const Color(0xFF4A3426)
                                                    .withOpacity(0.9),
                                              ]
                                            : [
                                                const Color(0xFFE8DCC0)
                                                    .withOpacity(0.9),
                                                const Color(0xFFD0C0A0)
                                                    .withOpacity(0.8),
                                              ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(
                                        color: const Color(0xFFD2691E)
                                            .withOpacity(0.3),
                                        width: 1.5.w,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFD2691E)
                                              .withOpacity(0.2),
                                          blurRadius: 8.r,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        onTap: () {
                                          if (isGajal) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GajalReaderPage(
                                                        gajalId: itemIndex + 1),
                                              ),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SayariReaderPage(
                                                        sayariId:
                                                            itemIndex + 1),
                                              ),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(16.w),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 50.w,
                                                height: 50.w,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: isGajal
                                                        ? [
                                                            const Color(
                                                                0xFFD2691E),
                                                            const Color(
                                                                0xFFFF8C42),
                                                          ]
                                                        : [
                                                            const Color(
                                                                0xFF8B4513),
                                                            const Color(
                                                                0xFFCD853F),
                                                          ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: (isGajal
                                                              ? const Color(
                                                                  0xFFD2691E)
                                                              : const Color(
                                                                  0xFF8B4513))
                                                          .withOpacity(0.4),
                                                      blurRadius: 6.r,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${itemIndex + 1}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 16.w),
                                              Expanded(
                                                child: Text(
                                                  isGajal
                                                      ? 'गजल ${itemIndex + 1}'
                                                      : 'सायरी ${itemIndex + 1}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.sp,
                                                    color: isDarkMode
                                                        ? const Color(
                                                            0xFFF5F1E8)
                                                        : const Color(
                                                            0xFF2C1810),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(8.w),
                                                decoration: BoxDecoration(
                                                  color: (isGajal
                                                          ? const Color(
                                                              0xFFD2691E)
                                                          : const Color(
                                                              0xFF8B4513))
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: isGajal
                                                      ? const Color(0xFFD2691E)
                                                      : const Color(0xFF8B4513),
                                                  size: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
