import 'package:bill_tracker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    "No transactions has been added",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontFamily: "font1"),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Image.asset(
                    "assets/images/box.png",
                    height: constraints.maxHeight * 0.8,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundColor: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "\$${transactions[index].amount.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      //DateFormat.yMMMEd().format(tx.date), // for only date
                      DateFormat.yMMMEd()
                          .add_jms()
                          .format(transactions[index].date),
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.deepOrange,
                        size: 32,
                      ),
                      onPressed: () {
                        deleteTx(transactions[index].id);
                      },
                    ),
                  ));
            },
            itemCount: transactions.length,
          );
  }
}

//child: Row(
//children: <Widget>[
//Container(

//decoration: BoxDecoration(
//border: Border.all(
//color: Theme.of(context).accentColor,
//width: 2,
//),
//borderRadius: BorderRadius.circular(5)),
//margin: EdgeInsets.all(5),
//padding: EdgeInsets.all(5),
//),
//SizedBox(
//width: 20,
//),
//Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//
//Text(
////DateFormat.yMMMEd().format(tx.date), // for only date
//DateFormat.yMMMEd()
//.add_jms()
//    .format(transactions[index].date),
//style: Theme.of(context).textTheme.title.copyWith(
//color: Colors.grey,
//fontWeight: FontWeight.normal),
//),
//],
//),
//],
//),
