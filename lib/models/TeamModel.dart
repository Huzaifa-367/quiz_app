import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

class team extends GetxController {
  int id;
  String teamName;
  String teamType;
  int? scores;
  int? totalmembers;
  int? buzzerRound;
  int? mcqRound;
  int? rapidRound;
  RxString status = 'Pending'.obs;
  Socket? socket;
  int? buzzerWrong;
  team({
    required this.id,
    required this.teamName,
    required this.teamType,
    this.scores,
    this.totalmembers,
    this.buzzerRound,
    this.mcqRound,
    this.rapidRound,
    this.buzzerWrong,
  });

  team copyWith({
    int? id,
    String? teamName,
    String? teamType,
    int? scores,
    int? totalmembers,
    int? buzzerRound,
    int? mcqRound,
    int? rapidRound,
    int? buzzerWrong,
  }) {
    return team(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      teamType: teamType ?? this.teamType,
      scores: scores ?? this.scores,
      totalmembers: totalmembers ?? this.totalmembers,
      buzzerRound: buzzerRound ?? this.buzzerRound,
      mcqRound: mcqRound ?? this.mcqRound,
      rapidRound: rapidRound ?? this.rapidRound,
      buzzerWrong: buzzerWrong ?? this.buzzerWrong,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'teamName': teamName});
    result.addAll({'teamType': teamType});
    if (scores != null) {
      result.addAll({'scores': scores});
    }
    if (totalmembers != null) {
      result.addAll({'totalmembers': totalmembers});
    }
    if (buzzerRound != null) {
      result.addAll({'buzzerRound': buzzerRound});
    }
    if (mcqRound != null) {
      result.addAll({'mcqRound': mcqRound});
    }
    if (rapidRound != null) {
      result.addAll({'rapidRound': rapidRound});
    }
    if (buzzerWrong != null) {
      result.addAll({'buzzerWrong': buzzerWrong});
    }

    return result;
  }

  factory team.fromMap(Map<String, dynamic> map) {
    return team(
      id: map['id']?.toInt() ?? 0,
      teamName: map['teamName'] ?? '',
      teamType: map['teamType'] ?? '',
      scores: map['scores']?.toInt(),
      totalmembers: map['totalmembers']?.toInt(),
      buzzerRound: map['buzzerRound']?.toInt(),
      mcqRound: map['mcqRound']?.toInt(),
      rapidRound: map['rapidRound']?.toInt(),
      buzzerWrong: map['buzzerWrong']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory team.fromJson(String source) => team.fromMap(json.decode(source));

  @override
  String toString() {
    return 'team(id: $id, teamName: $teamName, teamType: $teamType, scores: $scores, totalmembers: $totalmembers, buzzerRound: $buzzerRound, mcqRound: $mcqRound, rapidRound: $rapidRound, buzzerWrong: $buzzerWrong)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is team &&
        other.id == id &&
        other.teamName == teamName &&
        other.teamType == teamType &&
        other.scores == scores &&
        other.totalmembers == totalmembers &&
        other.buzzerRound == buzzerRound &&
        other.mcqRound == mcqRound &&
        other.rapidRound == rapidRound &&
        other.buzzerWrong == buzzerWrong;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        teamName.hashCode ^
        teamType.hashCode ^
        scores.hashCode ^
        totalmembers.hashCode ^
        buzzerRound.hashCode ^
        mcqRound.hashCode ^
        rapidRound.hashCode ^
        buzzerWrong.hashCode;
  }
}
