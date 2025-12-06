import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/data_seeding_service.dart';
import 'core/services/notification_service.dart';
import 'features/kural/presentation/bloc/kural_bloc.dart';
import 'features/onboarding/presentation/pages/splash_page.dart';
import 'injection_container.dart' as di;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ); 
  } catch (e) {
     print('⚠️ Firebase initialization failed: $e');
  }

  await di.init();
  
  final seedingService = DataSeedingService(di.sl());
  await seedingService.seedKuralsIfNeeded();
  
  try {
    final notificationService = di.sl<NotificationService>();
    await notificationService.initialize();
    await notificationService.requestPermissions();
    
    await notificationService.scheduleDailyKuralNotification(hour: 9, minute: 0);
    await notificationService.scheduleStreakReminder(hour: 20, minute: 0);
    
    print('✅ Notifications initialized successfully');
  } catch (e) {
    print('⚠️ Notification setup failed (app will continue): $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KuralBloc>(
          create: (context) => di.sl<KuralBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Thirukkural Journey',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
