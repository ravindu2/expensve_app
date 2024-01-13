import 'package:advance_app/models/expensce.dart';
import 'package:advance_app/widget/expence_tile.dart';
import 'package:flutter/material.dart';

class ExpendList extends StatelessWidget {
  final List<ExpenceModel> expenceList;
  final void Function(ExpenceModel expence) onDeleteExpense;
  const ExpendList(
      {super.key, required this.expenceList, required this.onDeleteExpense});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenceList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(expenceList[index]),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              onDeleteExpense(expenceList[index]);
            },
            child: ExpenceTile(
              expence: expenceList[index],
            ),
          );
        },
      ),
    );
  }
}
