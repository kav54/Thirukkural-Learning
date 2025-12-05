import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../kural/presentation/bloc/kural_bloc.dart';
import '../../../kural/presentation/pages/daily_kural_page.dart';
import '../../../library/presentation/pages/library_page.dart';
import '../../../quiz/presentation/pages/quiz_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../kural/domain/services/children_explanation_service.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  int _selectedIndex = 0;
  bool _showTamilExplanation = true;
  final ChildrenExplanationService _childrenService = ChildrenExplanationService();

  late final List<Widget> _pages;

  // Soft color palette for daily rotation
  final List<Map<String, Color>> _dailyColorPalettes = [
    {
      'bg': const Color(0xFFFFE0E0), // Soft Pink
      'accent': const Color(0xFFFF6B9D),
      'text': const Color(0xFF4A0E2E),
    },
    {
      'bg': const Color(0xFFE0F2FE), // Soft Blue
      'accent': const Color(0xFF7AC3F4),
      'text': const Color(0xFF0C4A6E),
    },
    {
      'bg': const Color(0xFFFEF3C7), // Soft Yellow
      'accent': const Color(0xFFFBBF24),
      'text': const Color(0xFF78350F),
    },
    {
      'bg': const Color(0xFFE0F2E9), // Soft Green
      'accent': const Color(0xFF6EE7B7),
      'text': const Color(0xFF064E3B),
    },
    {
      'bg': const Color(0xFFF3E8FF), // Soft Purple
      'accent': const Color(0xFF8B5CF6),
      'text': const Color(0xFF4C1D95),
    },
    {
      'bg': const Color(0xFFFFE4CC), // Soft Peach
      'accent': const Color(0xFFFFA068),
      'text': const Color(0xFF7C2D12),
    },
    {
      'bg': const Color(0xFFE0E7FF), // Soft Lavender
      'accent': const Color(0xFF818CF8),
      'text': const Color(0xFF312E81),
    },
  ];

  Map<String, Color> get _todayColors {
    final dayOfWeek = DateTime.now().weekday - 1; // 0-6 (Monday-Sunday)
    return _dailyColorPalettes[dayOfWeek % _dailyColorPalettes.length];
  }

  @override
  void initState() {
    super.initState();
    
    _pages = [
      _buildHomePage(),
      const LibraryPage(),
      _buildQuizPage(),
      _buildProfilePage(),
    ];
    
    // Load children explanations and daily kural after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _childrenService.loadExplanations();
      if (mounted) {
        context.read<KuralBloc>().add(GetDailyKuralEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Minimal Header
            _buildMinimalHeader(),
            
            const SizedBox(height: 20),
            
            // Weekly Streak Banner
            _buildWeeklyGoalBanner(),
            
            const SizedBox(height: 24),
            
            // Kural of the Day Card
            _buildKuralOfTheDayCard(),
            
            const SizedBox(height: 24),
            
            // Daily Challenge Link
            _buildDailyChallengeLink(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizPage() {
    return const QuizPage();
  }

  Widget _buildProfilePage() {
    return const ProfilePage();
  }

  Widget _buildMinimalHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kural of the Day',
                style: GoogleFonts.quicksand(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                'Daily wisdom for life',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Icon(Icons.menu, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildKuralOfTheDayCard() {
    return BlocBuilder<KuralBloc, KuralState>(
      builder: (context, state) {
        if (state is KuralLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        if (state is KuralError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(state.message),
            ),
          );
        }
        
        if (state is KuralLoaded) {
          final kural = state.kural;
          
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: _todayColors['bg'],
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: _todayColors['accent']!.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Kural Number Badge
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'KURAL #${kural.number}',
                          style: GoogleFonts.quicksand(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: _todayColors['text'],
                          ),
                        ),
                      ),
                      // Favorite Button
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: _todayColors['accent']),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to favorites!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                // Kural Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        '${kural.line1Tamil}\n${kural.line2Tamil}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mukta(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _todayColors['text'],
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Audio Player
                      _buildAudioPlayer(),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Explanation Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Language Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EXPLANATION',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _todayColors['text']!.withOpacity(0.7),
                              letterSpacing: 1.2,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: _todayColors['accent']!.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                _buildLangButton('தமிழ்', _showTamilExplanation, () {
                                  setState(() => _showTamilExplanation = true);
                                }),
                                _buildLangButton('ENG', !_showTamilExplanation, () {
                                  setState(() => _showTamilExplanation = false);
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _showTamilExplanation ? kural.meaningTamil : kural.meaningEnglish,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: _todayColors['text'],
                          height: 1.6,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Children's Explanation
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _todayColors['accent']!.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('💡', style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 8),
                                Text(
                                  'For Little Learners',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: _todayColors['text'],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _childrenService.getExplanationOrDefault(
                                kural.number,
                                'This kural teaches us an important lesson about life. It helps us understand how to be better people and live happily with others!',
                              ),
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: _todayColors['text']!.withOpacity(0.9),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLangButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? _todayColors['accent'] : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : _todayColors['text']!.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          // Play Button
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF7AC3F4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Waveform (simplified with bars)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(15, (index) {
                final heights = [8.0, 12.0, 16.0, 10.0, 14.0, 18.0, 12.0, 16.0, 14.0, 10.0, 16.0, 12.0, 14.0, 10.0, 8.0];
                return Container(
                  width: 3,
                  height: heights[index],
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7AC3F4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Time
          Text(
            '0:05',
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Volume Icon
          const Icon(
            Icons.volume_up,
            color: Color(0xFF7AC3F4),
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallengeLink() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DailyKuralPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.emoji_events, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Challenge',
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Test your knowledge & earn rewards!',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // Keep old methods for reference but they won't be used
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFFF8FAFC),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'For You',
            style: GoogleFonts.quicksand(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          Row(
            children: [
              Icon(Icons.notifications_outlined, size: 24, color: Colors.grey.shade700),
              const SizedBox(width: 12),
              Icon(Icons.settings_outlined, size: 24, color: Colors.grey.shade700),
              const SizedBox(width: 12),
              Icon(Icons.add, size: 24, color: Colors.grey.shade700),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyGoalBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFDBEAFE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.flag, color: Color(0xFF2563EB), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
                children: const [
                  TextSpan(text: 'Your weekly goal: '),
                  TextSpan(
                    text: '0/3 days',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.catamaran(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayKuralCard() {
    return BlocBuilder<KuralBloc, KuralState>(
      builder: (context, state) {
        if (state is KuralLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is KuralError) {
          return Center(child: Text(state.message));
        }
        
        if (state is KuralLoaded) {
          final kural = state.kural;
          
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'KURAL #${kural.number}',
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const Icon(Icons.bookmark_border, color: Color(0xFFF59E0B)),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Kural Text
                Text(
                  '${kural.line1Tamil}\n${kural.line2Tamil}',
                  style: GoogleFonts.catamaran(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Explanation Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Toggle Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EXPLANATION',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                _buildLangButton('TAM', _showTamilExplanation, () {
                                  setState(() => _showTamilExplanation = true);
                                }),
                                _buildLangButton('ENG', !_showTamilExplanation, () {
                                  setState(() => _showTamilExplanation = false);
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _showTamilExplanation ? kural.meaningTamil : kural.meaningEnglish,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: const Color(0xFFE2E8F0),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Real Life Example
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lightbulb_outline, color: Color(0xFF38BDF8), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Real Life Example',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF38BDF8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Just like \'A\' is the first letter you learn in school, God is the beginning of everything in this world!',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          color: const Color(0xFFCBD5E1),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Action Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.volume_up, size: 18),
                      label: Text(
                        'Listen',
                        style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF0F172A),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                    Icon(Icons.share, color: Colors.grey.shade400),
                  ],
                ),
              ],
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }


  Widget _buildShortsSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildShortCard(
            'Virtue of\nGiving',
            Icons.menu_book,
            const LinearGradient(
              colors: [Color(0xFFA78BFA), Color(0xFFDDD6FE)],
            ),
          ),
          const SizedBox(width: 12),
          _buildShortCard(
            'The Power\nof Words',
            Icons.lightbulb_outline,
            const LinearGradient(
              colors: [Colors.white, Colors.white],
            ),
            isDark: true,
          ),
          const SizedBox(width: 12),
          _buildShortCard(
            'Mastering\nSelf Control',
            Icons.psychology_outlined,
            const LinearGradient(
              colors: [Color(0xFF6EE7B7), Color(0xFFA7F3D0)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortCard(String title, IconData icon, Gradient gradient, {bool isDark = false}) {
    return Container(
      width: 140,
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: const Color(0xFFE2E8F0)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isDark 
                    ? const Color(0xFFF1F5F9) 
                    : Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 16,
                color: isDark ? const Color(0xFF334155) : Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      backgroundColor: Colors.white,
      elevation: 2,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'For You',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book_rounded),
          label: 'Library',
        ),
        NavigationDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school_rounded),
          label: 'Quiz',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
