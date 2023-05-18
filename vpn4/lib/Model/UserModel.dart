class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  toString() => 'is client new: $data';
}

class Data {
  String? id;
  String? name;
  String? email;
  String? password;
  String? isActive;
  String? level;
  String? verificationCode;
  String? isVerified;

  Data(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.isActive,
      this.level,
      this.verificationCode,
      this.isVerified});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    isActive = json['isActive'];
    level = json['level'];
    verificationCode = json['verification_code'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['isActive'] = this.isActive;
    data['level'] = this.level;
    data['verification_code'] = this.verificationCode;
    data['is_verified'] = this.isVerified;
    return data;
  }

  @override
  toString() => 'is client new: $email, $password';
}
