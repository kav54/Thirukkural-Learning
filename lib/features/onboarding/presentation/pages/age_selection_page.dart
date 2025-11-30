import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../features/home/presentation/pages/home_dashboard_page.dart';
import '../../../../features/kural/presentation/bloc/kural_bloc.dart';
import '../../../../injection_container.dart' as di;

class AgeSelectionPage extends StatefulWidget {
  const AgeSelectionPage({super.key});

  @override
  State<AgeSelectionPage> createState() => _AgeSelectionPageState();
}

class _AgeSelectionPageState extends State<AgeSelectionPage> {
  int? _selectedAgeGroup;
  int? _selectedAvatarIndex;
  final TextEditingController _nameController = TextEditingController();

  final List<Map<String, dynamic>> _ageGroups = [
    {'range': '6-8', 'label': 'Little Learner', 'color': const Color(0xFFEC4899)},
    {'range': '9-11', 'label': 'Young Scholar', 'color': const Color(0xFF8B5CF6)},
    {'range': '12-14', 'label': 'Teen Explorer', 'color': const Color(0xFFF59E0B)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question
              Text(
                'உங்கள் வயது என்ன?',
                style: GoogleFonts.catamaran(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'How old are you?',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 24),

              // Age Groups
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_ageGroups.length, (index) {
                  final isSelected = _selectedAgeGroup == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedAgeGroup = index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _ageGroups[index]['color']
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected
                              ? Border.all(color: _ageGroups[index]['color'], width: 2)
                              : null,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: _ageGroups[index]['color'].withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: Column(
                          children: [
                            Text(
                              _ageGroups[index]['range'],
                              style: GoogleFonts.catamaran(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Years',
                              style: GoogleFonts.quicksand(
                                fontSize: 12,
                                color: isSelected ? Colors.white70 : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              // Avatar Selection
              Text(
                'Choose your Avatar',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 8, // Reduced for MVP
                itemBuilder: (context, index) {
                  final isSelected = _selectedAvatarIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAvatarIndex = index),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                        border: isSelected
                            ? Border.all(color: Colors.deepPurple, width: 3)
                            : null,
                      ),
                      child: Icon(
                        Icons.face,
                        size: 32,
                        color: Colors.deepPurple.shade300,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Name Input
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name / உங்கள் பெயர்',
                  labelStyle: GoogleFonts.quicksand(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 48),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (_selectedAgeGroup != null &&
                          _selectedAvatarIndex != null &&
                          _nameController.text.isNotEmpty)
                      ? () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => di.sl<KuralBloc>(),
                                child: const HomeDashboardPage(),
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
