import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leadon_app/features/auth/screen/user_detail_page.dart';
import 'package:leadon_app/features/home/screen/home_page.dart';
import 'package:leadon_app/features/landing/landing_screen.dart';

import '../../../common/repository/common_firebase_storage_repository.dart';
import '../../../common/utils/utils.dart';
import '../../../models/user_model.dart';
import '../screen/verify_otp.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: ((phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          }),
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: (((verificationId, forceResendingToken) async {
            Navigator.pushNamed(context, OTPScreen.routeName,
                arguments: verificationId);
          })),
          codeAutoRetrievalTimeout: ((verificationId) {}));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      auth.signInWithCredential(phoneAuthCredential).then((value) {
        firestore
            .collection('users')
            .where('uid', isEqualTo: auth.currentUser!.uid)
            .get()
            .then((value) {
          print('Length ----------');
          print(value.docs.length.toString());
          if (value.docs.isNotEmpty) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.routeName, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, UserDetailPage.routeName, (route) => false);
          }
        }).onError((error, stackTrace) {
          print('hata oldu 1');
        });
      }).onError((error, stackTrace) {
        print('hata oldu 2');
      });

      // UserModel? userModel;

      var documentSnapshot =
          firestore.collection('users').doc(auth.currentUser?.uid).get();
      // documentSnapshot.then((value) {
      //   userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);

      // Navigator.pushNamedAndRemoveUntil(
      //     context, UserDetailPage.routeName, (route) => false);

      // if (userModel!.name.isEmpty) {

      // } else {

      // }
      // });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required String birthday,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        birthday: birthday,
        phoneNumber: auth.currentUser!.phoneNumber!,
      );

      firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void updateUser({
    required String name,
    required File? profilePic,
    required String birthday,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        birthday: birthday,
        phoneNumber: auth.currentUser!.phoneNumber!,
      );

      firestore.collection('users').doc(uid).update(user.toMap());
      // Navigator.pushNamedAndRemoveUntil(
      //     context, HomePage.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Stream<UserModel> userData() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void deleteUserData() {
    firestore.collection('users').doc(auth.currentUser!.uid).delete();
  }

  void signOut(BuildContext context) {
    auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LandingPage.routeName, (route) => false);
  }
}
