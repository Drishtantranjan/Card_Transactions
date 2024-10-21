import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transaction_heatmap/presentation/dashboard/presentation/widgets/appBar.dart';
import 'package:transaction_heatmap/presentation/utility/AppColors.dart';
import 'package:transaction_heatmap/presentation/utility/config/AssetConfig.dart';
import 'package:transaction_heatmap/presentation/utility/reusable_widgets/card_container.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final containerHeight = screenHeight * 0.12;
    final containerWidth = screenWidth * 0.45;
    final spacing = screenHeight * 0.02;

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
              SizedBox(height: spacing),
              _buildInfoRow(containerHeight, containerWidth),
              _buildSecondInfoRow(containerHeight, containerWidth, spacing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(double containerHeight, double containerWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildContainer(containerHeight, containerWidth, Icons.wallet),
          _buildContainer(containerHeight, containerWidth, Icons.card_giftcard),
        ],
      ),
    );
  }

  Widget _buildSecondInfoRow(
      double containerHeight, double containerWidth, double spacing) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: spacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildContainer(containerHeight * 0.5, containerWidth * 0.3,
                      Icons.qr_code_scanner),
                  SizedBox(height: spacing * 0.8),
                  _buildContainer(
                      containerHeight * 0.5, containerWidth * 0.3, Icons.add),
                ],
              ),
              _buildTipsTrainingContainer(containerHeight, containerWidth),
              _buildAllServiceContainer(containerHeight, containerWidth),
            ],
          ),
          SizedBox(height: spacing),
          _buildReferEarnContainer(
              containerHeight * 1.5, containerWidth, spacing),
        ],
      ),
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

  Widget _buildTipsTrainingContainer(
      double containerHeight, double containerWidth) {
    return _buildIconWithTextContainer(
      containerHeight * 1.09,
      containerWidth * 0.85,
      Assetconfig.tipsIcon,
      'tips.title',
    );
  }

  Widget _buildAllServiceContainer(
      double containerHeight, double containerWidth) {
    return _buildIconWithTextContainer(
      containerHeight * 1.09,
      containerWidth * 0.8,
      Assetconfig.menuIC,
      'tips.service',
    );
  }

  Widget _buildIconWithTextContainer(
      double height, double width, String assetIcon, String localizationKey) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors().containerBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.4,
              width: width * 0.3,
              decoration: BoxDecoration(
                color: AppColors().containerColor2,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(assetIcon),
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                translate(localizationKey),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReferEarnContainer(double height, double width, double spacing) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors().containerBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              Assetconfig.referNEarn,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate('refer.title'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing),
                Text(
                  translate('refer.description'),
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing),
                Container(
                  height: height * 0.2,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    color: AppColors().containerColor2,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      translate('refer.button'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors().hintColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
