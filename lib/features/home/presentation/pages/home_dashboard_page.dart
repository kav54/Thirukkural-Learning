import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../kural/presentation/bloc/kural_bloc.dart';
import '../../../kural/presentation/pages/daily_kural_page.dart';
import '../../../library/presentation/pages/library_page.dart';
import '../../../quiz/presentation/pages/quiz_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  int _selectedIndex = 0;
  bool _showTamilExplanation = true;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    _pages = [
      _buildHomePage(),
      const LibraryPage(),
      _buildQuizPage(),
      _buildProfilePage(),
    ];
    
    // Load daily kural after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KuralBloc>().add(GetDailyKuralEvent());
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
      child: Column(
        children: [
          // Header
          _buildHeader(),
          
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weekly Goal Banner
                  _buildWeeklyGoalBanner(),
                  
                  const SizedBox(height: 10),
                  
                  // Today's Kural Section
                  _buildSectionTitle('இன்றைய குறள்', 'Picked based on your learning path.'),
                  
                  // Kural Card
                  _buildTodayKuralCard(),
                  
                  const SizedBox(height: 32),
                  
                  // Smarter in 5 minutes
                  _buildSectionTitle('Smarter in 5 minutes', 'Shorts help you learn something new every day.'),
                  
                  _buildShortsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizPage() {
    return const QuizPage();
  }

  Widget _buildProfilePage() {
    return const ProfilePage();
  }

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

  Widget _buildLangButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF59E0B) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isActive ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
          ),
        ),
      ),
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
