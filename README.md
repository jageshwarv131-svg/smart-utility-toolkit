# Smart Utility Toolkit

A comprehensive Flutter application featuring a collection of useful utility tools and calculators.

## Features

### Calculators & Tools
- **Calculator**: Basic arithmetic operations with scientific functions
- **Age Calculator**: Calculate age in years, months, and days
- **EMI Calculator**: Calculate Equated Monthly Installment for loans
- **BMI Calculator**: Calculate Body Mass Index with health status
- **Unit Converter**: Convert between various units (length, weight, temperature, etc.)
- **QR Code Generator**: Generate QR codes from text or URLs
- **QR Code Scanner**: Scan QR codes using device camera

### Utilities
- **Notes**: Create, edit, and delete notes with local storage
- **Stopwatch**: Timer and stopwatch functionality
- **Timer**: Countdown timer with notifications
- **Password Generator**: Generate secure random passwords
- **Text Counter**: Count characters, words, and lines
- **Flashlight**: Use device LED as flashlight (if supported)
- **Compass**: Digital compass with device heading (if supported)

## Technical Stack

- **Framework**: Flutter (Latest Stable)
- **Language**: Dart 3.0+
- **Architecture**: MVVM with Provider state management
- **Design**: Material Design 3
- **Target**: Android (API 21+)
- **Safety**: Null Safety enabled

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── config/
│   ├── theme/               # Theme configuration
│   ├── routes/              # Route definitions
│   └── ads/                 # AdMob configuration
├── models/                  # Data models
├── providers/               # State management
├── services/                # Business logic
├── views/                   # UI screens
├── widgets/                 # Reusable components
└── utils/                   # Utility functions

assets/
├── images/                  # Image assets
├── icons/                   # Icon assets
├── animations/              # Animation assets
└── fonts/                   # Custom fonts

android/
├── app/                     # Android app module
└── gradle/                  # Build configuration
```

## Getting Started

### Prerequisites
- Flutter SDK (Latest Stable)
- Dart 3.0+
- Android Studio / Android SDK
- Google Mobile Ads account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/jageshwarv131-svg/smart-utility-toolkit.git
cd smart-utility-toolkit
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure AdMob:
   - Update `lib/config/ads/ad_unit_ids.dart` with your Ad Unit IDs
   - Test IDs are pre-configured

4. Run the app:
```bash
flutter run
```

### Building Release APK

```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

## AdMob Integration

The app includes Google Mobile Ads SDK with support for:
- Banner Ads
- Native Ads
- Interstitial Ads
- Rewarded Ads

All test Ad Unit IDs are configured. Replace them with production IDs in `lib/config/ads/ad_unit_ids.dart`.

## Performance Optimizations

- Lazy loading of widgets
- Provider state management for efficient rebuilds
- Cached images and data
- Optimized build configuration
- Code splitting

## Permissions Required

- Camera (for QR Scanner and Compass)
- Flashlight (for Torch feature)
- Contacts (optional, for future features)

## Build Configuration

### Continuous Integration

GitHub Actions workflow automatically:
- Builds release APK on push to main
- Runs tests
- Uploads artifact for download

## API Reference

### State Management
All features use Provider for state management:
```dart
Final<FeatureProvider> featureProvider = StateNotifierProvider((ref) {
  return FeatureProvider();
});
```

### Adding New Features

1. Create model in `lib/models/`
2. Create provider in `lib/providers/`
3. Create service in `lib/services/`
4. Create view in `lib/views/`
5. Add to bottom navigation

## Contributing

Contributions are welcome! Please follow the coding standards:
- Use meaningful variable names
- Add comments for complex logic
- Follow Dart formatting guidelines
- Test thoroughly before submitting PR

## License

MIT License - See LICENSE file for details

## Author

Jageshwar V

## Support

For issues or feature requests, please open an issue on GitHub.
