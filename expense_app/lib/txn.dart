import 'package:flutter/foundation.dart';
class Txn{
  @required final String id;
  @required final String title;
  @required final DateTime date;
  @required final double amount;
  Txn({this.amount,this.date,this.id,this.title});

}