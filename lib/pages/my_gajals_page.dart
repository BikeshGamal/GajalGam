import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../widgets/settings_dialog.dart';
import 'user_gajal_reader_page.dart';
import 'write_gajal_page.dart';

// Utility functions for Nepali formatting
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

  final day = toNepaliDigits(date.day.toString());
  final month = nepaliMonths[date.month - 1];
  final year = toNepaliDigits(date.year.toString());

  return '$day $month $year';
}

class MyGajalsPage extends StatefulWidget {
  const MyGajalsPage({super.key});

  @override
  State<MyGajalsPage> createState() => _MyGajalsPageState();
}

class _MyGajalsPageState extends State<MyGajalsPage> {
  List<UserGajal> _userGajals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGajals();
  }

  Future<void> _loadGajals() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dbHelper = DatabaseHelper();
      final gajals = await dbHelper.getAllGajals();

      setState(() {
        _userGajals = gajals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('गजलहरू लोड गर्न समस्या भयो! Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteGajal(UserGajal gajal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('गजल मेटाउनुहोस्'),
        content: Text('के तपाईं "${gajal.title}" गजल मेटाउन चाहनुहुन्छ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('रद्द गर्नुहोस्'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('मेटाउनुहोस्'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final dbHelper = DatabaseHelper();
        await dbHelper.deleteGajal(gajal.id!);
        _loadGajals(); // Reload the list
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'गजल सफलतापूर्वक मेटाइयो!',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFFB8860B), // Dark orange background
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('गजल मेटाउन समस्या भयो!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
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
                        const Color(0xFF6B4E3D).withOpacity(0.8),
                      ]
                    : [
                        const Color(0xFFF0E6D2).withOpacity(0.9),
                        const Color(0xFFE8DCC0).withOpacity(0.8),
                      ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
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
                size: 24,
              ),
              onPressed: () => AppInfoDialog.show(context),
              tooltip: 'About',
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _userGajals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_note,
                        size: 80,
                        color: isDarkMode
                            ? const Color(0xFF6B4E3D)
                            : const Color(0xFFD0C0A0),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'तपाईंले अहिलेसम्म कुनै गजल लेख्नुभएको छैन',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode
                              ? const Color(0xFF8B7355)
                              : const Color(0xFF8B4513),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'नयाँ गजल लेख्न "+" बटन थिच्नुहोस्',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? const Color(0xFF8B7355)
                              : const Color(0xFF8B4513),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _userGajals.length,
                  itemBuilder: (context, index) {
                    final gajal = _userGajals[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF3D2817)
                            : const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isDarkMode
                              ? const Color(0xFF6B4E3D)
                              : const Color(0xFFD0C0A0),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          gajal.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? const Color(0xFFD4A574)
                                : const Color(0xFF8B4513),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              gajal.content.length > 100
                                  ? '${gajal.content.substring(0, 100)}...'
                                  : gajal.content,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode
                                    ? const Color(0xFFE0E0E0)
                                    : const Color(0xFF2C2C2C),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'लेखिएको मिति: ${formatNepaliDate(gajal.createdAt)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode
                                    ? const Color(0xFF8B7355)
                                    : const Color(0xFF8B4513),
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'read') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserGajalReaderPage(
                                    gajal: gajal,
                                    allGajals: _userGajals,
                                    currentIndex: index,
                                  ),
                                ),
                              );
                            } else if (value == 'edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WriteGajalPage(
                                    editGajal: gajal,
                                  ),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  _loadGajals(); // Reload if edited
                                }
                              });
                            } else if (value == 'delete') {
                              _deleteGajal(gajal);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'read',
                              child: Row(
                                children: [
                                  Icon(Icons.visibility),
                                  SizedBox(width: 8),
                                  Text('पढ्नुहोस्'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('सम्पादन गर्नुहोस्'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('मेटाउनुहोस्',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserGajalReaderPage(
                                gajal: gajal,
                                allGajals: _userGajals,
                                currentIndex: index,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WriteGajalPage(),
            ),
          ).then((result) {
            if (result == true) {
              _loadGajals(); // Reload if new gajal was added
            }
          });
        },
        backgroundColor:
            isDarkMode ? const Color(0xFF6B4E3D) : const Color(0xFF8B4513),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
