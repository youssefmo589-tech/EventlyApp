class UserModel {
  final String name;

  final String uid;

  final String email;

  final String? image;

  static const String collectionname = "UserCollection";

  const UserModel({
    required this.name,
    required this.uid,
    required this.email,
    this.image,
  });

  factory UserModel.fromfireStore(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      uid: json['uid'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> tofirestore() {
    return {"name": name, "uid": uid, "email": email, "image": image};
  }
}
