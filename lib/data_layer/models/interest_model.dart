import 'package:equatable/equatable.dart';

class InterestModel extends Equatable {
  final String interestId;
  final String interestName;

  const InterestModel({
    required this.interestId,
    required this.interestName,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      interestId: json['id'].toString(),
      interestName: json['intrestText'],
    );
  }

  @override
  String toString() {
    return 'id: $interestId interestName: $interestName';
  }

  @override
  List<Object> get props => [interestId, interestName];
}
