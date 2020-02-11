import 'package:bill_tracker/model/transaction.dart';
import 'package:bill_tracker/widgets/new_transaction.dart';
import 'package:bill_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bill Tracker",
      home: BillPage(),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  List<Transaction> _userTransaction = [
    Transaction(title: "Groceries", amount: 50.00, date: DateTime.now()),
    Transaction(title: "Watch", amount: 100.00, date: DateTime.now()),
    Transaction(title: "Shoes", amount: 120.00, date: DateTime.now()),
  ];

  String title;
  double amount;

  void _addTransaction(String txTitle, double txAmount) {
    final newTx =
        Transaction(title: txTitle, amount: txAmount, date: DateTime.now());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _showAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track your bills!"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Chart"),
              ),
            ),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransaction(
            context), // function is required something as it's parameter
      ),
    );
  }
}
