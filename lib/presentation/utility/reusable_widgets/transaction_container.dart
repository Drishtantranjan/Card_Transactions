import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:transaction_heatmap/models/transaction_model.dart';
import 'package:transaction_heatmap/presentation/transaction/presentation/view/transaction_detail.dart';
import 'package:transaction_heatmap/presentation/utility/AppColors.dart';

class TransactionContainer extends StatelessWidget {
  final double height;
  final double width;
  final double monthlyTransactions;
  final String month; // Added month parameter
  final Map<String, double> categorySpending; // Map for category spending
  final Map<String, Color> categoryColors; // Map for category colors
  final double totalSpent; // Total spent amount

  const TransactionContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.monthlyTransactions,
    required this.month, // Added month to the constructor
    required this.categorySpending,
    required this.categoryColors,
    required this.totalSpent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Create a dummy transaction to pass to TransactionDetailsPage
        final transaction = Transaction(
          category: 'Shopping', // Example category, change as needed
          amount: monthlyTransactions,
          isCredit: false, // Example credit/debit, change as needed
        );

        // Navigate to the TransactionDetailsPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TransactionDetailsPage(transaction: transaction),
          ),
        );
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors().containerBackground,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate('firstRow.transaction'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                translate('Spent in $month'), // Changed to use month parameter
                style: TextStyle(fontSize: 12, color: Colors.grey[300]),
              ),
              const SizedBox(height: 15),
              Row(
                children: categorySpending.keys.map((category) {
                  double proportion = categorySpending[category]! / totalSpent;
                  return Expanded(
                    flex: (proportion * 100).round(),
                    child: Container(
                      height: 15,
                      decoration: BoxDecoration(
                        color: categoryColors[category] ?? Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(right: 4),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
