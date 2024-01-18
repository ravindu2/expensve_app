import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'expensce.g.dart';

final uuid = const Uuid().v4();

enum Category { food, travel, work, leasure }

@HiveType(typeId: 1)
class ExpenceModel {
  ExpenceModel(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : id = uuid;
  @HiveField(1)
  final String id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final Category category;
}
