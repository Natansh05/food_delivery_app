// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
// import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
// import 'package:provider/provider.dart';

// import 'package:FlavorFleet/main.dart';
// import 'package:FlavorFleet/src/themes/theme_provider.dart'; // Adjust import as needed

// class FakeFirebaseApp extends Fake implements FirebaseAppPlatform {
//   @override
//   String get name => 'default';

//   @override
//   FirebaseOptions get options => const FirebaseOptions(
//     apiKey: 'fake',
//     appId: 'fake',
//     messagingSenderId: 'fake',
//     projectId: 'fake',
//   );
// }

// class MockFirebaseCore extends Fake
//     with MockPlatformInterfaceMixin
//     implements FirebasePlatform {
//   @override
//   Future<FirebaseAppPlatform> initializeApp({
//     String? name,
//     FirebaseOptions? options,
//   }) async {
//     return FakeFirebaseApp();
//   }

//   @override
//   FirebaseAppPlatform app([String? name]) => FakeFirebaseApp();

//   @override
//   List<FirebaseAppPlatform> get apps => [FakeFirebaseApp()];
// }

// class MockThemeProvider extends ChangeNotifier implements ThemeProvider {
//   ThemeData _themeData = ThemeData.light();

//   @override
//   bool get isDarkMode => false;

//   @override
//   void toggleTheme() {
//     // mock implementation
//   }

//   @override
//   void setLightMode() {
//     // mock implementation
//     _themeData = ThemeData.light();
//     notifyListeners();
//   }

//   @override
//   ThemeData get themeData => _themeData;

//   @override
//   set themeData(ThemeData value) {
//     _themeData = value;
//     notifyListeners();
//   }
// }

// void main() {
//   setUpAll(() async {
//     FirebasePlatform.instance = MockFirebaseCore();
//   });

//   testWidgets('App loads with mock Firebase and ThemeProvider',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider<ThemeProvider>(
//             create: (_) => MockThemeProvider(),
//           ),
//         ],
//         child: const MyApp(),
//       ),
//     );
//     await tester.pumpAndSettle();
//     expect(find.byType(MaterialApp), findsOneWidget);
//   });
// }
