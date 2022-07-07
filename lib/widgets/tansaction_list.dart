import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/sleep.png',
                  width: 100,
                  height: 100,
                ),
                Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: ((context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                            child: Text('₹${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMEd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );

                //   Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 100,
                //         alignment: Alignment.centerLeft,
                //         margin: const EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Theme.of(context).primaryColor,
                //             width: 2,
                //           ),
                //         ),
                //         padding: const EdgeInsets.all(10),
                //         child: Text(
                //           '₹ ${transactions[index].amount.toStringAsFixed(2)}',
                //           style: Theme.of(context).textTheme.titleMedium,
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context).textTheme.titleMedium,
                //           ),
                //           Text(DateFormat().format(transactions[index].date),
                //               style: const TextStyle(color: Colors.black38)),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              }),
            ),
    );
  }
}
