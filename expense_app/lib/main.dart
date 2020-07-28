import 'package:expense_app/new_txns.dart';
import 'package:expense_app/txn_list.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'package:expense_app/txn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,

          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
            // ignore: deprecated_member_use
            title: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      // ignore: deprecated_member_use
                      title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Txn> _userTxn = [
    // Txn(
    //   id: 't1',
    //   title: 'Laptop',
    //   date: DateTime.now(),
    //   amount: 59999.99,
    // ),
    // Txn(
    //   id: 't2',
    //   title: 'Bag',
    //   date: DateTime.now(),
    //   amount: 599,
    // ),
  ];
  List<Txn> get _recentTxns{
    return _userTxn.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList(); 
  }
  void _addNewtxn(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Txn(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTxn.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactions(_addNewtxn),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
  void deleter(String id) {
    setState(() {
      _userTxn.removeWhere((tx) {
        return  tx.id==id;
      });
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses App',
          
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     child: Text("Chart",
            //     // ignore: deprecated_member_use
            //     style: Theme.of(context).textTheme.title,),
            //   ),
            // ),
            Chart(_recentTxns ),
            TransactionList(_userTxn,deleter),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
