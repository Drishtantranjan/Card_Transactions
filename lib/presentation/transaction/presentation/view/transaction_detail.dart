import 'package:flutter/material.dart';
import 'package:transaction_heatmap/models/transaction_model.dart';

class TransactionDetailsPage extends StatelessWidget {
  final Transaction transaction;

  TransactionDetailsPage({
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    // Set amount color based on transaction type (credit or debit)
    final amountColor = transaction.isCredit ? Colors.green : Colors.red;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Transaction Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  // backgroundImage: AssetImage(transaction.iconPath),
                  backgroundColor: Colors.grey.shade900,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      // transaction.description ??
                      "No description available",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Amount',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: amountColor,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Transaction Time',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              // transaction.time ??
              'N/A',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Perform any action like sharing the transaction
              },
              child: const Center(
                child: Text(
                  'Share Transaction',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
