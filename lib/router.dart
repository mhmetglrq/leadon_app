import 'package:flutter/material.dart';
import 'package:leadon_app/features/auth/screen/sign_up_page.dart';
import 'package:leadon_app/features/auth/screen/user_detail_page.dart';
import 'package:leadon_app/features/auth/screen/verify_otp.dart';
import 'package:leadon_app/features/home/screen/home_page.dart';

import 'common/widgets/error.dart';
import 'features/landing/landing_screen.dart';

Route<dynamic> genarateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingPage.routeName:
      return MaterialPageRoute(builder: (context) => const LandingPage());
    case SignUpPage.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpPage());
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      final router = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OTPScreen(
                verificationId: verificationId,
                router: router,
              ));

    case UserDetailPage.routeName:
      return MaterialPageRoute(builder: (context) => const UserDetailPage());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => const HomePage());
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "Something wrong. This page doesn't exist"),
        ),
      );
  }
}
