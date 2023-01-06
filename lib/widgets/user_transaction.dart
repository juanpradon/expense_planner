import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_list.dart';
import './new_transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  Widget build(BuildContext context) {
    return Text('prueba');
  }
}
