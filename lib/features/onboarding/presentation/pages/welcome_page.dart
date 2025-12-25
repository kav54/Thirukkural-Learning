import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../features/home/presentation/pages/home_dashboard_page.dart';
import '../../../../features/kural/presentation/bloc/kural_bloc.dart';
import '../../../../injection_container.dart' as di;

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Illustration Placeholder
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.family_restroom_rounded,
                  size: 100,
                  color: Colors.deepPurple,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Title
              Text(
                'வணக்கம்!\nதிருக்குறள் உலகிற்கு\nவரவேற்கிறோம்',
                textAlign: TextAlign.center,
                style: GoogleFonts.catamaran(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Subtitle
              Text(
                'Learn 1 Thirukkural daily, the fun way!',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const Spacer(),
              
              // CTA Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => di.sl<KuralBloc>(),
                          child: const HomeDashboardPage(),
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6), // Primary Purple
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'தொடங்குக (Get Started)',
                    style: GoogleFonts.catamaran(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
