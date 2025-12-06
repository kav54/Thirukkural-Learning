import 'package:flutter/material.dart';
import 'core/services/data_seeding_service.dart';
import 'core/services/notification_service.dart';
import 'features/onboarding/presentation/pages/splash_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  
  // Seed kurals data
  final seedingService = DataSeedingService(di.sl());
  await seedingService.seedKuralsIfNeeded();
  
  // Initialize and setup notifications (with error handling)
  try {
    final notificationService = di.sl<NotificationService>();
    await notificationService.initialize();
    await notificationService.requestPermissions();
    
    // Schedule default notifications (9 AM daily kural, 8 PM streak reminder)
    await notificationService.scheduleDailyKuralNotification(hour: 9, minute: 0);
    await notificationService.scheduleStreakReminder(hour: 20, minute: 0);
    
    print('✅ Notifications initialized successfully');
  } catch (e) {
    print('⚠️ Notification setup failed (app will continue): $e');
    // App continues even if notifications fail
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thirukkural Journey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
