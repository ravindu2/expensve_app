import 'package:flutter/material.dart';
import 'package:advance_app/models/expensce.dart';
import 'package:intl/intl.dart';

class AddNewExpencse extends StatefulWidget {
  final void Function(ExpenceModel expence) onAddExpence;
  const AddNewExpencse({super.key, required this.onAddExpence});

  @override
  State<AddNewExpencse> createState() => _AddNewExpencseState();
}

class _AddNewExpencseState extends State<AddNewExpencse> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category _selectcategory = Category.leasure;

  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 5, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 5, DateTime.now().month, DateTime.now().day);

  DateTime _selecttime = DateTime.now();

  final famattaDate = DateFormat.yMd();

  Future<void> _openDateModel() async {
    try {
      final pickerDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate);

      setState(() {
        _selecttime = pickerDate!;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  // void _handleFormatsubmit() {
  //   final userAmount = double(_amountController.text.trim());
  //   if (_titleController.text.trim().isEmpty || userAmount <= 0) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text("Enter valid Data"),
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Add new expence title",
              label: Text("Tile"),
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    helperText: "Enter the Amount",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(famattaDate.format(_selecttime)),
                    IconButton(
                      onPressed: _openDateModel,
                      icon: const Icon(Icons.date_range_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectcategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectcategory = value!;
                  });
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent),
                      ),
                      child: const Text("Close"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: _handleFormatsubmit,
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.greenAccent),
                      ),
                      child: const Text("Save"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleFormatsubmit() {
    final userAmount = double.tryParse(_amountController.text.trim());

    // Check if the title is empty or the user entered an amount less than or equal to 0
    if (_titleController.text.trim().isEmpty ||
        userAmount == null ||
        userAmount <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter a valid positive number"),
            content: const Text(
                "Please enter valid data for the title and the amount here the title cant be empty and the amount cant be less than zero"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("close"))
            ],
          );
        },
      );
    } else {
      ExpenceModel newexpencse = ExpenceModel(
          amount: userAmount,
          title: _titleController.text.trim(),
          date: _selecttime,
          category: _selectcategory);
      widget.onAddExpence(newexpencse);
      Navigator.pop(context);

      // Valid input, you can proceed with using userAmount
      // ...
    }
  }
}
