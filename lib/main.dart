import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_heatmap/presentation/Bloc/transaction_bloc.dart';
import 'package:transaction_heatmap/repositories/transaction_repository.dart';
import 'package:transaction_heatmap/presentation/view/transaction_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionBloc(TransactionRepository()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFE480F),
        ),
      ),
      home: const TransactionScreen(),
    );
  }
}
