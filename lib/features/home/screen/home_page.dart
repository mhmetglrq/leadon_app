import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leadon_app/common/widgets/custom_button.dart';
import 'package:leadon_app/common/widgets/loader.dart';
import 'package:leadon_app/features/auth/controller/auth_controller.dart';
import 'package:leadon_app/models/user_model.dart';

import '../../../common/utils/utils.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  File? image;

  void openDatePicker() {
    datePickerWidget(controller: birthdayController, context: context);
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    String birthday = birthdayController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .updateUser(name, image!, birthday, context);
    }
  }

  void signOut() {
    ref.read(authControllerProvider).signOut(context);
  }


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    birthdayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<UserModel?>(
            stream: ref.read(authControllerProvider).userDataById(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(snapshot.data!.name),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Name Update',
                          ),
                        ),
                      ),
                      Center(
                        child: Text(snapshot.data!.birthday),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: TextField(
                          readOnly: true,
                          showCursor: false,
                          controller: birthdayController,
                          decoration: const InputDecoration(
                            hintText: 'Birthday Update',
                          ),
                          onTap: openDatePicker,
                        ),
                      ),
                      SizedBox(
                          width: size.width * 0.2,
                          height: size.height * 0.2,
                          child: Image.network(snapshot.data!.profilePic)),
                      CustomButton(
                          text: 'Open gallery', onPressed: selectImage),
                      CustomButton(
                        text: 'Update user data',
                        onPressed: storeUserData,
                      ),
                      CustomButton(
                        text: 'Sign out',
                        onPressed: signOut,
                      )
                    ],
                  ),
                );
              }
              return const Loader();
            }),
      ),
    );
  }
}
