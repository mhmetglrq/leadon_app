import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOtp(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '- - - - - -',
                hintStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.length == 6) {
                  verifyOtp(ref, context, value.trim());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
