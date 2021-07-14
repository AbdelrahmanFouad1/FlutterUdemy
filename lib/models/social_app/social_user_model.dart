class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  String image;
  String cover;
  String bio;
  bool isEmailVerify;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerify,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerify = json['isEmailVerify'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerify': isEmailVerify,
    };
  }
}
