import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:notes/core/network/remote/api_end_points.dart';
import 'package:notes/core/network/remote/dio_helper.dart';

class NotesWebService {
  Future<List<dynamic>> getAllNotes() async {
    try {
      Response response = await DioHelper.getData(
        url: ApiEndPoints.allNotesEndPoint,
      );
      //log('getAllNotes web success ${response.data.toString()}');
      return response.data;
    } on DioError catch (error) {
      log('getAllNotes web error ${error.toString()}');
      throw 'deleteAllNotes web error';
    }
  }

  Future<dynamic> addNewNote(
      {required String userId, required String noteText}) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'Text': noteText,
          'UserId': userId,
          'PlaceDateTime': DateTime.now().toIso8601String(),
        },
        url: ApiEndPoints.addNoteEndPoint,
      );
      //log('addNewNote web success ${response.data.toString()}');
      return response.data;
    } on DioError catch (error) {
      log('addNewNote web error ${error.response!.data}');
    }
  }

  Future<dynamic> deleteAllNotes() async {
    try {
      Response response = await DioHelper.postData(
        data: {

        },
        url: ApiEndPoints.clearNoteEndPoint,
      );
      //log('deleteAllNotes web success ${response.data.toString()}');
      return response.data;
    } on DioError catch (error) {
      log('deleteAllNotes web error ${error.response!.data}');
    }
  }

  Future<dynamic> updateNote(
      {required String noteId,
      required String userId,
      required String noteText}) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'Id': noteId,
          'Text': noteText,
          'UserId': userId,
          'PlaceDateTime': DateTime.now().toIso8601String(),
        },
        url: ApiEndPoints.updateNoteEndPoint,
      );
      //log('updateNote web success ${response.data.toString()}');
      return response.data;
    } on DioError catch (error) {
      log('updateNote web error ${error.response!.data}');
    }
  }
}
