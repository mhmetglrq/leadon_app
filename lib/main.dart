import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leadon_app/features/auth/controller/auth_controller.dart';
import 'package:leadon_app/features/home/screen/home_page.dart';
import 'package:leadon_app/features/landing/landing_screen.dart';
import 'package:leadon_app/router.dart';

import 'common/widgets/error.dart';
import 'common/widgets/loader.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateRoute: (settings) => genarateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingPage();
              }
              return const HomePage();
            },
            error: ((error, stackTrace) {
              return ErrorScreen(error: error.toString());
            }),
            loading: () => const Loader(),
          ),
    );
  }
}
