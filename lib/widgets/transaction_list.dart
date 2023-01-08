import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList({required this.transactions, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text(
                      DateFormat('dd-MM-yyyy').format(transactions[index].date),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
