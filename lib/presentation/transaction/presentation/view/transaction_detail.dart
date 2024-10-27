import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_heatmap/models/transaction_model.dart';
import 'package:transaction_heatmap/presentation/annual_transaction_screen.dart';
import 'package:transaction_heatmap/presentation/transaction/presentation/widgets/monthly_spent_widget.dart';
import 'package:transaction_heatmap/presentation/transaction/presentation/widgets/tab_bar_widgets.dart';
import 'package:transaction_heatmap/presentation/utility/reusable_widgets/back_button_with_text.dart';
import 'package:transaction_heatmap/presentation/Bloc/transaction_bloc.dart';
import 'package:transaction_heatmap/repositories/transaction_repository.dart';

class TransactionDetailsPage extends StatefulWidget {
  final Transaction transaction;

  TransactionDetailsPage({
    required this.transaction,
  });

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  int selectedIndex = 2; // Default to 'Month'

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TransactionBloc(TransactionRepository())..add(FetchTransactions()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              BackButtonWithText(),
              const SizedBox(height: 40),

              // Conditionally render the CircularSegmentWidget or AnnualTransactionScreen
              if (selectedIndex == 0 ||
                  selectedIndex == 1 ||
                  selectedIndex == 2)
                CircularSegmentWidget(
                  totalAmount: 19000,
                  categorySpending: {
                    'Food': 4000,
                    'Shopping': 3000,
                    'Travel': 3000,
                    'Entertainment': 2000,
                    'Health': 2000,
                    'Rent': 5000,
                  },
                )
              else if (selectedIndex == 3)
                Expanded(
                  child: AnnualTransactionWidget(),
                ),

              const SizedBox(height: 20),

              CustomTabBar(
                onTabChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
