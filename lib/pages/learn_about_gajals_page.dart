import 'package:flutter/material.dart';

import '../widgets/settings_dialog.dart';

class LearnAboutGajalsPage extends StatelessWidget {
  const LearnAboutGajalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF2C1810) : const Color(0xFFFFFDF5),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color:
                isDarkMode ? const Color(0xFF2C1810) : const Color(0xFFFFFDF5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFD2691E),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Diary lines background
              CustomPaint(
                size: Size.infinite,
                painter: DiaryLinesPainter(),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDiarySection(
                        '🟣 गजल के हो?',
                        '''गजल एक प्रकारको कविता हो, जसको सुरुवात इस्लामी देशहरूमा फारसी र अरबी भाषामा भयो र पछि उर्दू हुँदै नेपालीमा पनि गहिरो प्रभाव छोडेको छ। 
यो कविता प्रेम, वियोग, जीवन-दर्शन, समाज, मनोभाव, अध्यात्म जस्ता गहिरा भावनाहरू अभिव्यक्त गर्न प्रयोग गरिन्छ।
गजललाई हाम्रा नेपाली श्रोताहरूले अझ बढी आत्मीयताको साथ ग्रहण गर्न थालेका छन्।''',
                        isDarkMode),
                    const SizedBox(height: 24),
                    _buildDiarySection(
                        '🟩 गजलको संरचना',
                        '''1. शेर:
गजल अनेकौं शेर बाट बनिएको हुन्छ।
प्रत्येक शेर दुई पङ्क्तिबाट बनेको हुन्छ र त्यो दुई पंक्तिले मिलेर एक स्वतंत्र भावना व्यक्त गर्छ।
उदाहरण:
छोरा म सब भएर एक्लो आश्रममा छु,
फेरी शब्द खर्ची मेरो खबर सोध्नु पर्दैन ।

2. मतला:
गजलको पहिलो शेर हो।
यसमा दुबै पंक्तिमा रदीफ आउँछ।

3. रदीफ:
गजलको हरेक दोस्रो पङ्क्तिको अन्त्यमा आउने एकै शब्द वा वाक्यांश हो।
जस्तै:
तिमीलाई सम्झन्छु...
हरेक रात सम्झन्छु...

4. काफिया:
रदीफ अघिको तुकिला शब्दहरू।
जस्तै: ...बन्छु, ...रन्छु, ...छु

5. मकता:
गजलको अन्तिम शेरमा कविको उपनाम/नाम आउँछ।
यसले व्यक्तिगत स्पर्श दिन्छ।''',
                        isDarkMode),
                    const SizedBox(height: 24),
                    _buildDiarySection(
                        '🟦 गजल लेख्ने नियमहरू',
                        '''एकै गजलभित्र एउटै रदीफ प्रयोग हुनुपर्छ।
रदीफ अघिको काफिया मिल्नुपर्छ।
शेरहरू एक अर्कासँग विषयमा सिधा नजोडिए पनि हुन्छ।
शब्दहरूको लय, मीटर मिलाउनु आवश्यक छ।
मतला, मकता अनिवार्य हुँदैन, तर प्रभावशाली हुन्छ।
गजल कम्तिमा ५ शेर को हुन्छ।''',
                        isDarkMode),
                    const SizedBox(height: 24),
                    _buildDiarySection(
                        '🟨 गजल लेख्ने प्रक्रिया',
                        '''विषय चयन गर्नुहोस् — प्रेम, पीडा, समाज, संघर्ष आदि।
रदीफ र काफिया निर्धारण गर्नुहोस्।
रदीफ: "सम्झन्छु"
काफिया: बन्छु, फन्छु, गन्छु
पहिलो शेर तयार गर्नुहोस् — दुबै लाइनमा रदीफ प्रयोग गरेर।
अब बाँकी शेरहरू लेख्नुहोस्।
अन्तिममा मकता लेख्नुहोस् — नाम राखेर।''',
                        isDarkMode),
                    const SizedBox(height: 24),
                    _buildDiarySection(
                        '🧠 एक उदाहरण गजल:',
                        '''मतला:
मैले कोर्ने गजलहरुको महत्वपुर्ण शेर हौ तिमी
मेरो हरेक रचनाको श्रृङ्गारिक अक्षर हौ तिमी
शेरहरू:
मापन हुन्न उनको प्रेमको यती भन्न सक्छु 
मैले फेर्ने हरेक श्वासको घडी पला बेर हौ तिमी 
धनले कहिले धनि होला कहिले होला गरिब यहाँ 
तर मायाँ स्नेहको सर्बोच्च कुबेर हौ तिमी''',
                        isDarkMode),
                    const SizedBox(height: 24),
                    _buildDiarySection(
                        '💡 टिप्स:',
                        '''छोटो र भावनात्मक शब्द प्रयोग गर्नुहोस्।
दैनिक भोगाइलाई शेरको रूपमा रूपान्तरण गर्नुहोस्।
आफूले लेखेको गजल बारम्बार पढ्नुहोस् – लय मिल्छ कि जाँच गर्नुहोस्।
प्राय: श्रोताले सजिलै बुझ्ने सरल भाषा प्रयोग गर्नुहोस्।''',
                        isDarkMode),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiarySection(String title, String content, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:
                isDarkMode ? const Color(0xFFD4A574) : const Color(0xFF8B4513),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            height: 1.8,
            fontFamily: 'Dancing Script',
            color:
                isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF2C2C2C),
          ),
        ),
      ],
    );
  }
}

class DiaryLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE8E8E8)
      ..strokeWidth = 1.0;

    const lineSpacing = 28.0;
    for (double y = 60; y < size.height - 20; y += lineSpacing) {
      canvas.drawLine(Offset(24, y), Offset(size.width - 24, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
