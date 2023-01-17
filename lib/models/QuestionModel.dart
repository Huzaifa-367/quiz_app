import 'dart:convert';

class Question {
  int id;
  String ques;
  String opt1;
  String opt2;
  String opt3;
  String opt4;
  String type;
  String answer;
  int? eventId;
  Question({
    required this.id,
    required this.ques,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
    required this.type,
    required this.answer,
    this.eventId,
  });

  Question copyWith({
    int? id,
    String? ques,
    String? opt1,
    String? opt2,
    String? opt3,
    String? opt4,
    String? type,
    String? answer,
    int? eventId,
  }) {
    return Question(
      id: id ?? this.id,
      ques: ques ?? this.ques,
      opt1: opt1 ?? this.opt1,
      opt2: opt2 ?? this.opt2,
      opt3: opt3 ?? this.opt3,
      opt4: opt4 ?? this.opt4,
      type: type ?? this.type,
      answer: answer ?? this.answer,
      eventId: eventId ?? this.eventId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'ques': ques});
    result.addAll({'opt1': opt1});
    result.addAll({'opt2': opt2});
    result.addAll({'opt3': opt3});
    result.addAll({'opt4': opt4});
    result.addAll({'type': type});
    result.addAll({'answer': answer});
    if (eventId != null) {
      result.addAll({'eventId': eventId});
    }

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id']?.toInt() ?? 0,
      ques: map['ques'] ?? '',
      opt1: map['opt1'] ?? '',
      opt2: map['opt2'] ?? '',
      opt3: map['opt3'] ?? '',
      opt4: map['opt4'] ?? '',
      type: map['type'] ?? '',
      answer: map['answer'] ?? '',
      eventId: map['eventId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, ques: $ques, opt1: $opt1, opt2: $opt2, opt3: $opt3, opt4: $opt4, type: $type, answer: $answer, eventId: $eventId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.id == id &&
        other.ques == ques &&
        other.opt1 == opt1 &&
        other.opt2 == opt2 &&
        other.opt3 == opt3 &&
        other.opt4 == opt4 &&
        other.type == type &&
        other.answer == answer &&
        other.eventId == eventId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ques.hashCode ^
        opt1.hashCode ^
        opt2.hashCode ^
        opt3.hashCode ^
        opt4.hashCode ^
        type.hashCode ^
        answer.hashCode ^
        eventId.hashCode;
  }
}
