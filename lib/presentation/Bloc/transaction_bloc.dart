import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transaction_heatmap/models/transaction_model.dart';
import 'package:transaction_heatmap/repositories/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;

  TransactionBloc(this.repository) : super(TransactionInitial()) {
    on<FetchTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await repository.getTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to fetch transactions"));
      }
    });
  }
}
