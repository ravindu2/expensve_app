import 'package:advance_app/models/expensce.dart';
import 'package:advance_app/server/database.dart';
import 'package:advance_app/widget/add_new_expensce.dart';
import 'package:advance_app/widget/expence_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class Expensve extends StatefulWidget {
  const Expensve({super.key});

  @override
  State<Expensve> createState() => _ExpensveState();
}

class _ExpensveState extends State<Expensve> {
  final _myBox = Hive.box("expensvebox");

  Database db = Database();

  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Work": 0,
    "Leasure": 0,
  };

  void onnewAddExpence(ExpenceModel expence) {
    setState(() {
      db.expenceList.add(expence);
    });
    db.updateData();
  }

  void _openAddExpencesverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewExpencse(
          onAddExpence: onnewAddExpence,
        );
      },
    );
  }

  double foodvalue = 0;
  double travelvalue = 0;
  double workvalue = 0;
  double lesiurevalue = 0;

  void calculatevalue() {
    double foodcal = 0;
    double travelcal = 0;
    double workcal = 0;
    double lesiurecal = 0;

    for (final expence in db.expenceList) {
      if (expence.category == Category.food) {
        foodcal += expence.amount;
      }
      if (expence.category == Category.travel) {
        travelcal += expence.amount;
      }
      if (expence.category == Category.leasure) {
        lesiurecal += expence.amount;
      }
      if (expence.category == Category.work) {
        workcal += expence.amount;
      }

      setState(() {
        foodvalue = foodcal;
        travelvalue = travelcal;
        lesiurevalue = lesiurecal;
        workvalue = workcal;
      });

      dataMap = {
        "Food": foodvalue,
        "Travel": travelvalue,
        "Work": lesiurevalue,
        "Leasure": workvalue,
      };
    }
  }

  @override
  void initState() {
    super.initState();
    if (_myBox.get("EXP_DATA") == null) {
      db.createInitialDatabase();
      calculatevalue();
    } else {
      db.loadData();
      calculatevalue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expence master"),
        backgroundColor: const Color.fromARGB(255, 77, 4, 195),
        elevation: 0,
        actions: [
          Container(
            color: Colors.yellow,
            child: IconButton(
              onPressed: _openAddExpencesverlay,
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          PieChart(dataMap: dataMap),
          ExpendList(
            expenceList: db.expenceList,
            onDeleteExpense: (expence) {
              ExpenceModel deletingExpence = expence;
              final int removingIndex = db.expenceList.indexOf(expence);
              setState(() {
                db.expenceList.remove(expence);
              });

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Delete Sucessfully"),
                action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      setState(() {
                        db.expenceList.insert(removingIndex, deletingExpence);
                      });
                    }),
              ));
            },
          ),
        ],
      ),
    );
  }
}
