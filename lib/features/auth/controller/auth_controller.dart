import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';
import '../repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP,String routeName) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void updateUser(
      String name, File profilePic, String birthday, BuildContext context) {
    authRepository.updateUser(
        name: name,
        profilePic: profilePic,
        birthday: birthday,
        ref: ref,
        context: context);
  }

  Stream<UserModel> userDataById() {
    return authRepository.userData();
  }

  void deleteUserData() {
    return authRepository.deleteUserData();
  }

  void signOut(BuildContext context) {
    return authRepository.signOut(context);
  }

  void saveUserDataToFirebase(
    BuildContext context,
    String name,
    File? profilePic,
    String birthday,
  ) {
    authRepository.saveUserDataToFirebase(
        name: name,
        profilePic: profilePic,
        ref: ref,
        context: context,
        birthday: birthday);
  }
}
