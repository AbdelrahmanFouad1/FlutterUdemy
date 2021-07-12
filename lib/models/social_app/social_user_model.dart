class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  bool isEmailVerify;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerify,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerify = json['isEmailVerify'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerify': isEmailVerify,
    };
  }
}
