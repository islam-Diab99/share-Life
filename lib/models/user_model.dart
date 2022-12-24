




class UserModel {
  String? name;
  String ?email;
  String ?phone;
  String ?uId;
  bool ?isEmailVerified;
  String? image;
  String? cover;
  String? bio;


  UserModel({
    this.email,
    required this.name,
    required this.phone,
    this.uId,
    this.isEmailVerified,
    required this.image,
    required this.cover,
    required this.bio

  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'cover':cover,
      'bio':bio
    };
  }
}