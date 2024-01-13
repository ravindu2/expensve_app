import 'package:advance_app/models/expensce.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenceTile extends StatelessWidget {
  const ExpenceTile({super.key, required this.expence});

  final ExpenceModel expence;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 219, 222, 220),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expence.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  expence.amount.toStringAsFixed(2),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      DateFormat.MMMMEEEEd().format(expence.date),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
