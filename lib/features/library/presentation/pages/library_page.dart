import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import '../../../../injection_container.dart' as di;
import '../../../kural/data/models/kural_model.dart';
import '../../../kural/domain/services/favorites_service.dart';
import 'favorites_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _currentLevel = 0; // 0: Themes, 1: Chapters, 2: Kurals
  String _currentTheme = '';
  int _currentChapter = 0;
  String _currentChapterName = '';

  final Isar _isar = di.sl<Isar>();
  final FavoritesService _favoritesService = di.sl<FavoritesService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _currentLevel == 0
                  ? _buildThemesView()
                  : _currentLevel == 1
                      ? _buildChaptersView()
                      : _buildKuralsView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (_currentLevel == 0) {
      // Root header with search
      return Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFFF8FAFC),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade600),
                    const SizedBox(width: 10),
                    Text(
                      'Search...',
                      style: GoogleFonts.quicksand(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            StreamBuilder<int>(
              stream: _favoritesService.watchFavoriteCount(),
              builder: (context, snapshot) {
                final count = snapshot.data ?? 0;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FavoritesPage()),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Icon(Icons.favorite, color: Color(0xFFEC4899)),
                      ),
                      if (count > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEC4899),
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              count > 99 ? '99+' : count.toString(),
                              style: GoogleFonts.quicksand(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      // Deep navigation header with back button
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _goBack,
            ),
            Expanded(
              child: Text(
                _currentLevel == 1 ? _currentTheme : _currentChapterName,
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 48), // Balance the back button
          ],
        ),
      );
    }
  }

  Widget _buildThemesView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Library',
            style: GoogleFonts.catamaran(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          _buildThemeCard(
            'அறத்துப்பால்',
            'Virtue',
            '38 Chapters',
            Icons.spa,
            const LinearGradient(
              colors: [Color(0xFFEC4899), Color(0xFFDB2777)],
            ),
            () => _openTheme('Virtue'),
          ),
          const SizedBox(height: 16),
          _buildThemeCard(
            'பொருட்பால்',
            'Wealth',
            '70 Chapters',
            Icons.paid,
            const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
            ),
            () => _openTheme('Wealth'),
          ),
          const SizedBox(height: 16),
          _buildThemeCard(
            'காமத்துப்பால்',
            'Love',
            '25 Chapters',
            Icons.favorite,
            const LinearGradient(
              colors: [Color(0xFFEAB308), Color(0xFFCA8A04)],
            ),
            () => _openTheme('Love'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(
    String titleTamil,
    String titleEnglish,
    String subtitle,
    IconData icon,
    Gradient gradient,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleTamil,
                    style: GoogleFonts.catamaran(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$titleEnglish • $subtitle',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Icon(icon, size: 36, color: Colors.white.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildChaptersView() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getChapters(_currentTheme),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No chapters found'));
        }

        final chapters = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return _buildChapterItem(
              chapter['number'],
              chapter['nameTamil'],
              chapter['nameEnglish'],
            );
          },
        );
      },
    );
  }

  Widget _buildChapterItem(int number, String nameTamil, String nameEnglish) {
    return GestureDetector(
      onTap: () => _openChapter(number, nameTamil),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              '$number',
              style: GoogleFonts.catamaran(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8B5CF6),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameTamil,
                    style: GoogleFonts.catamaran(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    nameEnglish,
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildKuralsView() {
    return FutureBuilder<List<KuralModel>>(
      future: _getKurals(_currentChapter),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No kurals found'));
        }

        final kurals = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: kurals.length,
          itemBuilder: (context, index) {
            final kural = kurals[index];
            return _buildKuralItem(kural);
          },
        );
      },
    );
  }

  Widget _buildKuralItem(KuralModel kural) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Color(0xFFF59E0B), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kural #${kural.number}',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, size: 18),
                color: const Color(0xFFCBD5E1),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${kural.line1Tamil}\n${kural.line2Tamil}',
            style: GoogleFonts.catamaran(
              fontSize: 15,
              color: const Color(0xFF1E293B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            kural.meaningEnglish,
            style: GoogleFonts.quicksand(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getChapters(String theme) async {
    final kurals = await _isar.kuralModels.where().findAll();
    
    // Define chapter ranges for each theme
    int startChapter, endChapter;
    switch (theme) {
      case 'Virtue':
        startChapter = 1;
        endChapter = 38;
        break;
      case 'Wealth':
        startChapter = 39;
        endChapter = 108;
        break;
      case 'Love':
        startChapter = 109;
        endChapter = 133;
        break;
      default:
        startChapter = 1;
        endChapter = 133;
    }
    
    // Group by chapter and filter by theme
    final chapterMap = <int, Map<String, dynamic>>{};
    for (var kural in kurals) {
      // Only include chapters within the theme's range
      if (kural.chapterNumber >= startChapter && kural.chapterNumber <= endChapter) {
        if (!chapterMap.containsKey(kural.chapterNumber)) {
          chapterMap[kural.chapterNumber] = {
            'number': kural.chapterNumber,
            'nameTamil': kural.chapterName,
            'nameEnglish': 'Chapter ${kural.chapterNumber}',
          };
        }
      }
    }
    
    return chapterMap.values.toList()..sort((a, b) => a['number'].compareTo(b['number']));
  }

  Future<List<KuralModel>> _getKurals(int chapterNumber) async {
    return await _isar.kuralModels
        .filter()
        .chapterNumberEqualTo(chapterNumber)
        .findAll();
  }

  void _openTheme(String theme) {
    setState(() {
      _currentTheme = theme;
      _currentLevel = 1;
    });
  }

  void _openChapter(int chapterNumber, String chapterName) {
    setState(() {
      _currentChapter = chapterNumber;
      _currentChapterName = chapterName;
      _currentLevel = 2;
    });
  }

  void _goBack() {
    setState(() {
      if (_currentLevel == 2) {
        _currentLevel = 1;
      } else if (_currentLevel == 1) {
        _currentLevel = 0;
      }
    });
  }
}
