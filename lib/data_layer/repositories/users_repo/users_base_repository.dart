import 'package:notes/data_layer/models/interest_model.dart';
import 'package:notes/data_layer/models/user_model.dart';

abstract class UsersBaseRepository {
  Future<List<InterestModel>> getAllInterests();

  Future<String> addNewUser({
    required String userName,
    required String userPassword,
    required String userEmail,
    required String imageFile,
    required String interestId,
  });

  Future<List<UserModel>> getAllUsers();
}
