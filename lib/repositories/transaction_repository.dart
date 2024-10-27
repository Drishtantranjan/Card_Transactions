import 'package:transaction_heatmap/models/transaction_model.dart';

class TransactionRepository {
  Future<List<DailyTransactions>> getTransactions() async {
    return generateMockData();
  }
}
