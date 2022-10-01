import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String userName;
  final String userPassword;
  final String userEmail;
  final String userInterestId;
  final dynamic userImage;

  const UserModel({
    required this.userId,
    required this.userName,
    required this.userPassword,
    required this.userEmail,
    required this.userInterestId,
    this.userImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'].toString(),
      userName: json['username'],
      userPassword: json['password'],
      userEmail: json['email'],
      userInterestId: json['intrestId'],
      userImage: json['imageAsBase64'] ?? '',
    );
  }

  @override
  List<Object> get props =>
      [userId, userName, userPassword, userEmail, userInterestId,];
}
