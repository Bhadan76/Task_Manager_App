class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String? photo;

  String get fullName {
    return '$firstName $lastName';
  }

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.photo,
  });

  //Api thake asa json data ke user object e convert
  factory UserModel.formJson(Map<String, dynamic> jsonData) {
    return UserModel(
      email: jsonData['email'] ?? '',
      firstName: jsonData['firstName'] ?? '',
      lastName: jsonData['lastName'] ?? '',
      mobile: jsonData['mobile'] ?? '',
      photo: jsonData['photo'],
    );
  }
  Map<String,dynamic> toJson(){
     return {
       'email' : email,
       'firstName' : firstName,
       'lastName' : lastName,
       'mobile' : mobile,
       'photo' : photo,
     };
  }
}
