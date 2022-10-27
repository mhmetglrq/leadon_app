import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/utils.dart';
import '../controller/auth_controller.dart';

class UserDetailPage extends ConsumerStatefulWidget {
  static const String routeName = '/user-detail-page';
  const UserDetailPage({super.key});

  @override
  ConsumerState<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends ConsumerState<UserDetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    birthdayController.dispose();
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
          .saveUserDataToFirebase(context, name, image, birthday);
    }
  }

  void openDatePicker() async {
    datePickerWidget(controller: birthdayController, context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: storeUserData,
        child: const Icon(Icons.done),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                        ),
                        radius: 64,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 64,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
            ),
            Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration:
                    const InputDecoration(hintText: 'Select your birthday'),
                controller: birthdayController,
                readOnly: true,
                showCursor: false,
                onTap: () => openDatePicker(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
