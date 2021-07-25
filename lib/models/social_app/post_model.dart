class PostModel {
  String name;
  String uId;
  String postId;
  String image;
  String postImage;
  String dateTime;
  String text;

  PostModel({
    this.name,
    this.uId,
    this.postId,
    this.image,
    this.postImage,
    this.dateTime,
    this.text,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    postId = json['postId'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'uId':uId,
      'postId':postId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}
