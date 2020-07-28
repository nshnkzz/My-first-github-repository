import 'package:flutter/material.dart';


import 'package:intl/intl.dart';

import 'txn.dart';

class TransactionList extends StatelessWidget {
final List<Txn> txns; 
final Function deleteTx;
TransactionList(this.txns, this.deleteTx);
  @override
  Widget build(BuildContext context){
     return  Container(
            height: 515,
            child: txns.isEmpty ? Column(
              children: <Widget>[
                Text('Transaction space empty',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title,),
                SizedBox(height: 20
                ,),
                Container(
                  height: 300,
                  child: Image.asset('assets/image/waiting.png', fit: BoxFit.cover,
                  ),
                ),
              ],
            ) : ListView(
                    children: txns.map((tx) {
                  return Card(
                      child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColorLight,
                                 width: 2,
                                 
                                 ),
                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                 ),
                        padding: EdgeInsets.all(10),
                        child: Text('₹ ${tx.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            // ignore: deprecated_member_use
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat.yMMMd().format(tx.date),
                            style: TextStyle( 
                              color: Colors.black26,
                            ),
                          )
                        ],
                      ),
                      IconButton(icon: Icon(Icons.delete),
                      color: Colors.red,
                       onPressed:()=> deleteTx(tx.id),)
                    ],
                  ));
                }).toList()),
       
     );
          
  }
}