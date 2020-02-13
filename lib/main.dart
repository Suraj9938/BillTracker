import 'package:bill_tracker/model/transaction.dart';
import 'package:bill_tracker/widgets/chart.dart';
import 'package:bill_tracker/widgets/new_transaction.dart';
import 'package:bill_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bill Tracker",
      home: BillPage(),
      theme: ThemeData(
          primaryColor: Colors.orangeAccent,
          accentColor: Colors.amber,
          fontFamily: "font2",
          textTheme: TextTheme(
            title: TextStyle(
                fontFamily: "font2", fontSize: 18, fontWeight: FontWeight.bold),
          ),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              title: TextStyle(
                  fontFamily: "font1",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  List<Transaction> _userTransaction = [
//    Transaction(title: "Groceries", amount: 50.00, date: DateTime.now()),
//    Transaction(title: "Watch", amount: 100.00, date: DateTime.now()),
//    Transaction(title: "Shoes", amount: 120.00, date: DateTime.now()),
  ];

  String title;
  double amount;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(title: txTitle, amount: txAmount, date: txDate);

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _showAddTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
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
