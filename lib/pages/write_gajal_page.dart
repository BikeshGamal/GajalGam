import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../widgets/settings_dialog.dart';

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

// Nepali digit & date formatting
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

class WriteGajalPage extends StatefulWidget {
  final UserGajal? editGajal;

  const WriteGajalPage({super.key, this.editGajal});

  @override
  State<WriteGajalPage> createState() => _WriteGajalPageState();
}

class _WriteGajalPageState extends State<WriteGajalPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.editGajal != null) {
      _titleController.text = widget.editGajal!.title;
      _contentController.text = widget.editGajal!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveGajal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final gajal = UserGajal(
        id: widget.editGajal?.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        createdAt: widget.editGajal?.createdAt ?? DateTime.now(),
      );

      final dbHelper = DatabaseHelper();
      if (widget.editGajal != null) {
        await dbHelper.updateGajal(gajal);
      } else {
        await dbHelper.insertGajal(gajal);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.editGajal != null
                  ? 'गजल सफलतापूर्वक अपडेट भयो!'
                  : 'गजल सफलतापूर्वक सेभ भयो!',
              style: TextStyle(
                  fontSize: SizeConfig.scaleText(16), color: Colors.white),
            ),
            backgroundColor: const Color(0xFFB8860B),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'हेर्नुहोस्',
              textColor: Colors.white,
              onPressed: () => Navigator.pop(context, true),
            ),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('गजल सेभ गर्न समस्या भयो! Error: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF2C1810) : const Color(0xFFF5F1E8),
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(5),
              vertical: SizeConfig.scaleHeight(1.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.scaleWidth(4),
                    vertical: SizeConfig.scaleHeight(1)),
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
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFFD2691E),
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
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: isDarkMode
                    ? const Color(0xFFD4A574)
                    : const Color(0xFF8B4513),
                size: SizeConfig.scaleText(24),
              ),
              onPressed: () => AppInfoDialog.show(context),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.scaleWidth(4)),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF3D2817)
                      : const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(3)),
                  border: Border.all(
                    color: isDarkMode
                        ? const Color(0xFF6B4E3D)
                        : const Color(0xFFD0C0A0),
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'गजलको शीर्षक',
                    labelStyle: TextStyle(
                        color: isDarkMode
                            ? const Color(0xFFD4A574)
                            : const Color(0xFF8B4513),
                        fontSize: SizeConfig.scaleText(16)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(SizeConfig.scaleWidth(4)),
                  ),
                  style: TextStyle(
                      color: isDarkMode
                          ? const Color(0xFFE0E0E0)
                          : const Color(0xFF2C2C2C),
                      fontSize: SizeConfig.scaleText(18)),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'कृपया गजलको शीर्षक लेख्नुहोस्'
                      : null,
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(2)),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFF3D2817)
                        : const Color(0xFFFFFFFF),
                    borderRadius:
                        BorderRadius.circular(SizeConfig.scaleWidth(3)),
                    border: Border.all(
                      color: isDarkMode
                          ? const Color(0xFF6B4E3D)
                          : const Color(0xFFD0C0A0),
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    controller: _contentController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      labelText: 'आफ्नो गजल यहाँ लेख्नुहोस्...',
                      labelStyle: TextStyle(
                        color: isDarkMode
                            ? const Color(0xFFD4A574)
                            : const Color(0xFF8B4513),
                        fontSize: SizeConfig.scaleText(16),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(SizeConfig.scaleWidth(4)),
                    ),
                    style: TextStyle(
                        color: isDarkMode
                            ? const Color(0xFFE0E0E0)
                            : const Color(0xFF2C2C2C),
                        fontSize: SizeConfig.scaleText(16),
                        height: 1.8),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'कृपया गजलको सामग्री लेख्नुहोस्'
                            : null,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(2)),
              SizedBox(
                width: double.infinity,
                height: SizeConfig.scaleHeight(7),
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveGajal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD2691E),
                    foregroundColor:
                        isDarkMode ? const Color(0xFFF5F1E8) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.scaleWidth(3)),
                    ),
                  ),
                  child: _isSaving
                      ? SizedBox(
                          width: SizeConfig.scaleWidth(6),
                          height: SizeConfig.scaleWidth(6),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          widget.editGajal != null
                              ? 'अपडेट गर्नुहोस्'
                              : 'सेभ गर्नुहोस्',
                          style: TextStyle(
                              fontSize: SizeConfig.scaleText(18),
                              fontWeight: FontWeight.bold),
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
