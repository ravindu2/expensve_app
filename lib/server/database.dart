import 'package:advance_app/models/expensce.dart';
import 'package:hive/hive.dart';

class Database {
  //create a database reference
  final _myBox = Hive.box("expensvebox");

  List<ExpenceModel> expenceList = [];

  void createInitialDatabase() {
    expenceList = [
      ExpenceModel(
          amount: 22.21,
          title: "Football",
          date: DateTime.now(),
          category: Category.leasure),
      ExpenceModel(
          amount: 12.24,
          title: "burger",
          date: DateTime.now(),
          category: Category.food),
      ExpenceModel(
          amount: 20,
          title: "Bsg",
          date: DateTime.now(),
          category: Category.travel),
    ];
  }

  //load the data

  void loadData() {
    final dynamic data = _myBox.get("EXP_DATA");

    if (data != null && data is List<dynamic>) {
      expenceList = data.cast<ExpenceModel>().toList();
    }
  }

  //update the data

  Future<void> updateData() async {
    await _myBox.put("EXP_DATA", expenceList);
  }
}
