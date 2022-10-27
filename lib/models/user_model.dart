class UserModel {
  String name;
  String uid;
  String birthday;
  String phoneNumber;
  String profilePic;
  UserModel({
    required this.name,
    required this.uid,
    required this.birthday,
    required this.phoneNumber,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      birthday: map['birthday'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePic: map['profilePic'] as String,
    );
  }
}
