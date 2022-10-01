import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String noteId;
  final dynamic noteUserId;
  final String noteText;
  final String notePlaceDateTime;

  const NoteModel({
    required this.noteId,
    this.noteUserId,
    required this.noteText,
    required this.notePlaceDateTime,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteId: json['id'].toString(),
      noteUserId: json['userId'] ?? '0',
      noteText: json['text'],
      notePlaceDateTime: json['placeDateTime'],
    );
  }

  @override
  List<Object> get props => [noteId, noteText, notePlaceDateTime];
}
