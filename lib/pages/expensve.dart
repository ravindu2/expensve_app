import 'package:advance_app/models/expensce.dart';
import 'package:advance_app/widget/add_new_expensce.dart';
import 'package:advance_app/widget/expence_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Expensve extends StatefulWidget {
  const Expensve({super.key});

  @override
  State<Expensve> createState() => _ExpensveState();
}

class _ExpensveState extends State<Expensve> {
  final List<ExpenceModel> _expensceList = [
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
        category: Category.travel)
  ];

  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Work": 0,
    "Leasure": 0,
  };

  void onnewAddExpence(ExpenceModel expence) {
    setState(() {
      _expensceList.add(expence);
    });
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

    for (final expence in _expensceList) {
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
    calculatevalue();
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
            expenceList: _expensceList,
            onDeleteExpense: (expence) {
              ExpenceModel deletingExpence = expence;
              final int removingIndex = _expensceList.indexOf(expence);
              setState(() {
                _expensceList.remove(expence);
              });

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Delete Sucessfully"),
                action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      setState(() {
                        _expensceList.insert(removingIndex, deletingExpence);
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
