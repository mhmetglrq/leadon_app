import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void datePickerWidget(
    {required TextEditingController controller,
    required BuildContext context}) {
  showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960, 1),
      lastDate: DateTime(2022, 12),
      builder: (context, picker) {
        return Theme(
          data: ThemeData.dark(),
          child: picker!,
        );
      }).then(
    (selectedDate) {
      if (selectedDate != null) {
        controller.text = selectedDate.toString().split(" ").first;
      }
    },
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}
