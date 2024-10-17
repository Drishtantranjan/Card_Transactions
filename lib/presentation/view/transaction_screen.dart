import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transaction_heatmap/presentation/Bloc/transaction_bloc.dart';
import 'package:transaction_heatmap/models/transaction_model.dart';
import 'package:transaction_heatmap/presentation/widgets/MonthHeaderWidget.dart';
import 'package:transaction_heatmap/presentation/widgets/TransactionBottomSheet.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TransactionBloc>().add(FetchTransactions());

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is TransactionLoaded) {
          return TransactionWidget(transactions: state.transactions);
        }
        return const SizedBox();
      },
    );
  }
}

class TransactionWidget extends StatelessWidget {
  final List<DailyTransactions> transactions;

  const TransactionWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final reversedTransactions = transactions.reversed.toList();
    int rows = 7;
    int columns = (reversedTransactions.length / rows).ceil();

    List<String> monthHeaders =
        _generateMonthHeaders(reversedTransactions, rows, columns);

    double maxSpending = transactions
        .map((t) => t.totalAmountSpent)
        .reduce((a, b) => a > b ? a : b);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transaction Heatmap',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
          ),
          backgroundColor: const Color.fromARGB(255, 14, 17, 23),
        ),
        backgroundColor: const Color.fromARGB(255, 14, 17, 23),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 1000,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 10),
                        Text("Mon", style: TextStyle(color: Colors.white)),
                        Text("Wed", style: TextStyle(color: Colors.white)),
                        Text("Fri", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MonthHeaderWidget(monthHeaders: monthHeaders),
                        const SizedBox(height: 5),
                        Expanded(
                          child: TransactionGrid(
                            rows: rows,
                            columns: columns,
                            reversedTransactions: reversedTransactions,
                            maxSpending: maxSpending,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> _generateMonthHeaders(
      List<DailyTransactions> transactions, int rows, int columns) {
    List<String> monthHeaders = [];
    for (int i = 0; i < columns; i++) {
      int actualIndex = i * rows;
      if (actualIndex < transactions.length) {
        String month = DateFormat.MMM().format(transactions[actualIndex].date);
        if (monthHeaders.isEmpty || monthHeaders.last != month) {
          monthHeaders.add(month);
        }
      }
    }
    return monthHeaders;
  }
}

class TransactionGrid extends StatelessWidget {
  const TransactionGrid({
    super.key,
    required this.rows,
    required this.columns,
    required this.maxSpending,
    required this.reversedTransactions,
  });

  final int rows;
  final int columns;
  final double maxSpending;
  final List<DailyTransactions> reversedTransactions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemCount: reversedTransactions.length,
      itemBuilder: (context, index) {
        int column = index % columns;
        int row = index ~/ columns;
        int actualIndex = row + column * rows;

        if (actualIndex >= reversedTransactions.length) {
          return Container();
        }

        Color color = _getColorForSpending(
            reversedTransactions[actualIndex].totalAmountSpent, maxSpending);

        return GestureDetector(
          onTap: () {
            if (reversedTransactions[actualIndex].transactions.isNotEmpty) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return TransactionBottomSheet(
                      transactions:
                          reversedTransactions[actualIndex].transactions,
                      date: reversedTransactions[actualIndex].date);
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("No transaction available at the moment"),
              ));
            }
          },
          child: Container(
            color: color,
            margin: const EdgeInsets.all(2.0),
          ),
        );
      },
    );
  }

  Color _getColorForSpending(double spending, double maxSpending) {
    double normalizedSpending = spending / maxSpending;
    double brightness = normalizedSpending.clamp(0, 1);
    return HSVColor.fromAHSV(1.0, 120, 1.0, brightness).toColor();
  }
}
