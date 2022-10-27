import 'package:flutter/material.dart';
import 'package:leadon_app/common/widgets/custom_button.dart';
import 'package:leadon_app/features/auth/screen/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landing-page';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Demo app'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text('Demo App'),
            ),
            CustomButton(
              text: 'Sign In Page',
              onPressed: () =>
                  Navigator.pushNamed(context, SignInPage.routeName),
            ),
            CustomButton(text: 'Sign Up Page', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
