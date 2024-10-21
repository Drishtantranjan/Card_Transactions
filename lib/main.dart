import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:transaction_heatmap/presentation/Bloc/transaction_bloc.dart';
import 'package:transaction_heatmap/repositories/transaction_repository.dart';
import 'package:transaction_heatmap/presentation/dashboard/presentation/views/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en'],
    basePath: 'assets/json/',
  );

  runApp(
    LocalizedApp(delegate, const MainApp()), // Wrap with LocalizedApp
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the localization delegate from LocalizedApp
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionBloc(TransactionRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFE480F),
          ),
        ),
        home: DashboardPage(),
        // Localization configuration
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate, // Correctly use localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
      ),
    );
  }
}
