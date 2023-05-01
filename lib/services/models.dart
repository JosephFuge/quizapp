import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Topic {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.img = '',
      this.quizzes = const []});

  factory Topic.fromJson(Map<String, dynamic> json) => $_TopicFromJson(json);
  Map<String, dynamic> toJson() => $_TopicToJson(this);
}

@JsonSerializable()
class Quiz {
  final String id;
  final String title;
  final String description;
  final String topic;
  final String video;
  final List<Question> questions;

  Quiz(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.topic = '',
      this.video = '',
      this.questions = const []});

  factory Quiz.fromJson(Map<String, dynamic> json) => $_QuizFromJson(json);
  Map<String, dynamic> toJson() => $_QuizToJson(this);
}

@JsonSerializable()
class Report {
  String uid;
  int total;
  Map topics;

  Report({this.uid = '', this.topics = const {}, this.total = 0});
  factory Report.fromJson(Map<String, dynamic> json) => $_ReportFromJson(json);
  Map<String, dynamic> toJson() => $_ReportToJson(this);
}

@JsonSerializable()
class Question {
  String text;
  List<Option> options;

  Question({this.text = '', this.options = const []});
  factory Question.fromJson(Map<String, dynamic> json) => $_QuestionFromJson(json);
  Map<String, dynamic> toJson() => $_QuestionToJson(this);
}

@JsonSerializable()
class Option {
  String value;
  String detail;
  bool correct;
  Option({this.value = '', this.detail = '', this.correct = false});
  factory Option.fromJson(Map<String, dynamic> json) => $_OptionFromJson(json);
  Map<String, dynamic> toJson() => $_OptionToJson(this);
}
