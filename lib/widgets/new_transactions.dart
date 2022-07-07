import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitData() {
    final enteredTitle = _titleInput.text;
    final enteredAmount = double.parse(_amountInput.text);

    if (enteredTitle.isEmpty || enteredAmount.isNegative) {
      return;
    }
    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleInput,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountInput,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat.yMd().format(_selectedDate),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Center(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.purple,
                    ),
                    child: IconButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      icon: const Icon(Icons.calendar_month),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                submitData();
              },
              child: const Text('Add Transation'),
            ),
          ],
        ),
      ),
    );
  }
}
