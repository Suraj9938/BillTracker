import 'dart:io';

import 'package:bill_tracker/model/transaction.dart';
import 'package:bill_tracker/widgets/chart.dart';
import 'package:bill_tracker/widgets/new_transaction.dart';
import 'package:bill_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // This method is used to ensure for use of portrait mode

//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
//    runApp(MyApp());
//  });
  runApp(MyApp());
}

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
  bool _showChart = false;

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
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: txDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
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
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Track your bills!"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
                  onTap: () => _showAddTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
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
          );

    final txListWidget = Container(
        height: (mediaQuery.size.height * 0.7) -
            appBar.preferredSize.height -
            mediaQuery.padding.top,
        child: TransactionList(_userTransaction, _deleteTransaction));

    final pageBody = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart"),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height * 0.3) -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top,
                child: Chart(_recentTransactions)),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height * 0.7) -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top,
                    child: Chart(_recentTransactions))
                : txListWidget,
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddTransaction(
                        context), // function is required something as it's parameter
                  ),
          );
  }
}
