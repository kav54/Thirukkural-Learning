# Thirukkural Journey

A gamified Tamil educational app teaching 1,330 ancient Tamil poems (Thirukkural) through interactive learning.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **BLoC** for state management.

### Folder Structure

```
lib/
├── core/                   # Core functionality shared across features
│   ├── error/              # Failures and Exceptions
│   ├── usecases/           # Base UseCase interface
│   ├── utils/              # Constants, Extensions
│   ├── network/            # Network info (connectivity)
│   └── services/           # Service locator (GetIt)
├── features/
│   └── kural/              # Feature: Kural Display & Management
│       ├── data/
│       │   ├── datasources/
│       │   │   └── kural_local_data_source.dart
│       │   ├── models/     # Data models (Isar DB)
│       │   └── repositories/
│       │       └── kural_repository_impl.dart
│       ├── domain/
│       │   ├── entities/   # Pure Dart classes
│       │   ├── repositories/
│       │   │   └── kural_repository.dart
│       │   └── usecases/
│       │       └── get_daily_kural.dart
│       └── presentation/
│           ├── bloc/       # BLoC / Cubit
│           ├── pages/
│           └── widgets/
├── main.dart
└── injection_container.dart # DI Setup
```

## 🚀 Tech Stack

### Frontend
- **Flutter** (Dart) - Cross-platform framework
- **flutter_bloc** - State management
- **Isar** - Local NoSQL database (offline-first)
- **Equatable** - Value equality
- **Dartz** - Functional programming (Either, Option)

### Backend (Planned)
- **Firebase Auth** - Authentication
- **Cloud Firestore** - User progress sync
- **Firebase Storage** - Audio files
- **Firebase Analytics** - Analytics
- **Firebase Crashlytics** - Crash reporting

### Other
- **GetIt** - Dependency injection
- **just_audio** - Audio playback
- **connectivity_plus** - Network status
- **flutter_local_notifications** - Local notifications

## 📦 Setup

### Prerequisites
- Flutter SDK 3.38.3+
- Dart 3.10.1+
- Android Studio / Xcode
- VS Code (recommended)

### Installation

1. **Clone the repository**
   ```bash
   cd "/Users/kavya.d/Documents/Tirukkural App/Thirukkural Learning"
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (Isar)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🎯 Current Status

### ✅ Completed
- Clean Architecture setup
- BLoC state management
- Isar local database integration
- Dependency injection (GetIt)
- Daily Kural feature (domain, data, presentation layers)
- Basic UI for displaying Kural

### 🚧 In Progress
- Kural data seeding (1,330 kurals)
- Audio integration
- Quiz games
- User authentication

### 📋 To Do
- [ ] Load all 1,330 Kurals into Isar database
- [ ] Implement audio narration
- [ ] Build quiz games (Wordle, MCQ, Match)
- [ ] Streak tracking
- [ ] Social sharing
- [ ] Firebase integration
- [ ] Bilingual toggle (Tamil/English)

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 📱 Running on Devices

### iOS
```bash
flutter run -d ios
```

### Android
```bash
flutter run -d android
```

### Web
```bash
flutter run -d chrome
```

## 🔧 Development

### Adding a new feature

1. Create feature folder in `lib/features/`
2. Follow Clean Architecture layers:
   - `domain/` - Entities, Repositories (interfaces), UseCases
   - `data/` - Models, DataSources, Repositories (implementations)
   - `presentation/` - BLoC, Pages, Widgets
3. Register dependencies in `injection_container.dart`

### Code Generation

After modifying Isar models:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## 📄 License

This project is for educational purposes.

## 👥 Contributors

- Kavya D.

---

**Built with ❤️ using Flutter**
