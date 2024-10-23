import 'package:flutter/material.dart';
import 'package:transaction_heatmap/presentation/dashboard/presentation/widgets/appBar.dart';
import 'package:transaction_heatmap/presentation/dashboard/presentation/widgets/navBar.dart';
import 'package:transaction_heatmap/presentation/utility/AppColors.dart';
import 'package:transaction_heatmap/presentation/utility/reusable_widgets/icon_with_text_container.dart';
import 'package:transaction_heatmap/presentation/utility/reusable_widgets/refer_earn_container.dart';
import 'package:transaction_heatmap/presentation/utility/reusable_widgets/transaction_container.dart';
import '../../../../models/transaction_model.dart';
import '../../../utility/config/AssetConfig.dart';
import '../../../utility/reusable_widgets/card_container.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerHeight = _getContainerHeight(context);
    final double containerWidth = _getContainerWidth(context);
    final double spacing = _getSpacing(context);

    MonthlyTransactions monthlyTransactions = MonthlyTransactions(
      month: "October",
      dailyTransactions: generateMockData(),
    );

    return Scaffold(
      backgroundColor: AppColors().appBackground,
      appBar: AppBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: spacing),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditCardWidget(),
              SizedBox(height: spacing * 0.5),
              _buildInfoRow(
                  containerHeight, containerWidth, monthlyTransactions),
              _buildSecondInfoRow(containerHeight, containerWidth, spacing),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(selectedIndex: 2),
    );
  }

  static double _getContainerHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.12;
  }

  static double _getContainerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.45;
  }

  static double _getSpacing(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.02;
  }

  Widget _buildInfoRow(double containerHeight, double containerWidth,
      MonthlyTransactions monthlyTransactions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTransactionContainer(
              containerHeight, containerWidth, monthlyTransactions),
          _buildContainer(containerHeight, containerWidth, Icons.card_giftcard),
        ],
      ),
    );
  }

  Widget _buildSecondInfoRow(
      double containerHeight, double containerWidth, double spacing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: spacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildIconContainer(containerHeight * 0.5,
                      containerWidth * 0.3, Icons.qr_code_scanner),
                  SizedBox(height: spacing * 0.8),
                  _buildIconContainer(
                      containerHeight * 0.5, containerWidth * 0.3, Icons.add),
                ],
              ),
              _buildIconWithTextContainer(containerHeight * 1.09,
                  containerWidth * 0.85, Assetconfig.tipsIcon, 'tips.title'),
              _buildIconWithTextContainer(containerHeight * 1.09,
                  containerWidth * 0.8, Assetconfig.menuIC, 'tips.service'),
            ],
          ),
          SizedBox(height: spacing),
          _buildReferEarnContainer(
              containerHeight * 1.5, containerWidth, spacing),
        ],
      ),
    );
  }

  Widget _buildTransactionContainer(
      double height, double width, MonthlyTransactions monthlyTransactions) {
    Map<String, double> categorySpending =
        monthlyTransactions.calculateMonthlySpending();

    Map<String, Color> categoryColors = {
      'Food': AppColors().food,
      'Shopping': AppColors().shopping,
      'Travel': AppColors().travel,
      'Entertainment': AppColors().entertainment,
      'Health': AppColors().health,
      'Rent': AppColors().rent,
    };

    double totalSpent =
        categorySpending.values.fold(0.0, (sum, amount) => sum + amount);

    return TransactionContainer(
      height: height,
      width: width,
      monthlyTransactions: totalSpent,
      month: monthlyTransactions.month,
      categorySpending: categorySpending,
      categoryColors: categoryColors,
      totalSpent: totalSpent,
    );
  }

  Widget _buildIconContainer(double height, double width, IconData icon) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors().containerBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Icon(icon, size: 35, color: Colors.white),
    );
  }

  Widget _buildContainer(double height, double width, IconData icon) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors().containerBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Icon(icon, size: 35, color: Colors.white),
    );
  }

  Widget _buildIconWithTextContainer(
      double height, double width, String assetIcon, String localizationKey) {
    return IconWithTextContainer(
      height: height,
      width: width,
      iconPath: assetIcon,
      title: localizationKey,
    );
  }

  Widget _buildReferEarnContainer(double height, double width, double spacing) {
    return ReferEarnContainer(height: height, width: width, spacing: spacing);
  }
}
