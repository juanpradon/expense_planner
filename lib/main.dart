import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
            .copyWith(secondary: Colors.amber),
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              labelSmall: TextStyle(
                color: Colors.white,
                fontFamily: 'AnekTamil',
                fontSize: 14,
              ),
              labelMedium: TextStyle(
                color: Colors.white,
                fontFamily: 'AnekTamil',
                fontSize: 16,
              ),
              labelLarge: TextStyle(
                color: Colors.white,
                fontFamily: 'AnekTamil',
                fontSize: 18,
              ),
              titleSmall: TextStyle(
                fontFamily: 'AnekTamil',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              titleMedium: TextStyle(
                fontFamily: 'AnekTamil',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              titleLarge: TextStyle(
                fontFamily: 'AnekTamil',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleSmall: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                titleMedium: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.98,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Pants',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    final nexTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(nexTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  //late String titleInput;
  void _startAddNewTransaction(BuildContext context) {
    //showCupertinoModalPopup(
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Intl.defaultLocale = 'pt_BR';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            //UserTransaction(),
            TransactionList(
              transactions: _userTransactions,
              deleteTx: _deleteTransaction,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
