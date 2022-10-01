import 'package:notes/data_layer/models/interest_model.dart';
import 'package:notes/data_layer/models/user_model.dart';
import 'package:notes/data_layer/repositories/users_repo/local_users_repository.dart';
import 'package:notes/data_layer/repositories/users_repo/users_base_repository.dart';
import 'package:notes/data_layer/web_services/users_web_service.dart';

class RemoteUsersRepo extends UsersBaseRepository {
  final UsersWebService usersWebService;

  RemoteUsersRepo(this.usersWebService);
  LocalUsersRepo localUsersRepo=LocalUsersRepo();
  @override
  Future<List<InterestModel>> getAllInterests() async {

    final allInterests = await usersWebService.getAllInterests();

    final  interests=allInterests
        .map((allInterests) => InterestModel.fromJson(allInterests))
        .toList();
    localUsersRepo.saveInterestsLocally(interests: interests);
    return interests;

  }


  @override
  Future<String> addNewUser({
    required String userName,
    required String userPassword,
    required String userEmail,
    required String imageFile,
    required String interestId,
  }) async {
    final responseMessage = await usersWebService.addNewUser(
        userName: userName,
        userPassword: userPassword,
        userEmail: userEmail,
        imageFile: imageFile,
        interestId: interestId);
    return responseMessage;
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final allUsers = await usersWebService.getAllUsers();
    final users= allUsers.map((allUsers) => UserModel.fromJson(allUsers)).toList();
    localUsersRepo.saveUsersLocally(users: users);
    return users;
  }
}
