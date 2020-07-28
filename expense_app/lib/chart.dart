import 'package:expense_app/txn.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'chart_bar.dart';
class Chart extends StatelessWidget {
  final List<Txn> recentTxns;
  Chart(this.recentTxns);
  List<Map<String, Object>> get groupedtransactionvalues {
    return List.generate(7, (index) {
      final weekDay= DateTime.now().subtract(Duration(days: index),);
      var totalSum=0.0;
      for( int i=0; i<recentTxns.length; i++){
        if(recentTxns[i].date.day==weekDay.day && 
        recentTxns[i].date.month==weekDay.month && 
        recentTxns[i].date.year==weekDay.year){
          totalSum+=recentTxns[i].amount;
        }
      }
      return { 'day':DateFormat.E().format(weekDay).substring(0,1), 
      'amount':totalSum };
    });
  }
  double get maxSpending{
    return groupedtransactionvalues.fold(0.0, (sum, item) {
      return sum+item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: groupedtransactionvalues.map((data){
        return Flexible(
          fit: FlexFit.tight,
          child: ChartBar(data['day'],
          data['amount'],
          maxSpending==0.0 ?0.0: (data['amount']as double)/maxSpending,),
        );
        }).toList(),
        ),
      ),
      
    );
  }
}