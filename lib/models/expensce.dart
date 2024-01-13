import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();

enum Category { food, travel, work, leasure }

class ExpenceModel {
  ExpenceModel(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : id = uuid;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
