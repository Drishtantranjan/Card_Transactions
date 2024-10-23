import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_heatmap/models/transaction_model.dart';

class TransactionBottomSheet extends StatefulWidget {
  final List<Transaction> transactions;
  final DateTime date;

  const TransactionBottomSheet({
    super.key,
    required this.transactions,
    required this.date,
  });

  @override
  _TransactionBottomSheetState createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '${localizations.transactionsOn} ${DateFormat.yMMMMd().format(widget.date)}',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: localizations.viewList),
              Tab(text: localizations.viewGraph),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionList(),
                _buildTransactionGraph(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      itemCount: widget.transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = widget.transactions[index];
        return ListTile(
          title: Text(transaction.category),
          subtitle: Row(
            children: [
              Text(
                transaction.isCredit ? "+" : "-",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: transaction.isCredit ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                transaction.amount.toStringAsFixed(2),
                style: TextStyle(
                  color: transaction.isCredit ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionGraph() {
    List<BarChartGroupData> barGroups = [];
    Map<String, double> categoryTotals = {};

    for (var transaction in widget.transactions) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) +
              (transaction.isCredit ? transaction.amount : -transaction.amount);
    }

    categoryTotals.forEach((category, total) {
      barGroups.add(
        BarChartGroupData(
          x: category.hashCode,
          barRods: [
            BarChartRodData(
              toY: total,
              color: total >= 0 ? Colors.green : Colors.red,
              width: 20,
            ),
          ],
        ),
      );
    });

    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                String category = categoryTotals.keys.firstWhere(
                    (key) => key.hashCode == value.toInt(),
                    orElse: () => '');
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: SizedBox(
                    width: 50,
                    child: Text(
                      category,
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: barGroups,
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

// Added localisation for the Bottom sheet

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return AppLocalizations();
  }

  String get transactionsOn => 'Transactions on';
  String get viewList => 'View List';
  String get viewGraph => 'View Graph';
}
