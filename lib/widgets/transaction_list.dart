import 'package:bill_tracker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "\$${transactions[index].amount.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      //DateFormat.yMMMEd().format(tx.date), // for only date
                      DateFormat.yMMMEd()
                          .add_jms()
                          .format(transactions[index].date),
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
