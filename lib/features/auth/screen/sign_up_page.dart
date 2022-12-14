import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leadon_app/common/widgets/custom_button.dart';
import 'package:leadon_app/features/auth/screen/user_detail_page.dart';

import '../../../common/utils/utils.dart';
import '../controller/auth_controller.dart';

class SignUpPage extends ConsumerStatefulWidget {
  static const String routeName = '/sign-in-page';
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhone(context, phoneNumber,);
    } else {
      showSnackBar(context: context, content: 'Fill out of all the fiedls');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'GSM Number',
              ),
            ),
          ),
          CustomButton(text: 'Next', onPressed: sendPhoneNumber),
        ],
      ),
    );
  }
}
