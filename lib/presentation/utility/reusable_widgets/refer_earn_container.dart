import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:transaction_heatmap/presentation/utility/AppColors.dart';
import 'package:transaction_heatmap/presentation/utility/config/AssetConfig.dart';

class ReferEarnContainer extends StatelessWidget {
  final double height;
  final double width;
  final double spacing;
  const ReferEarnContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.spacing});

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing * 0.6),
                Text(
                  translate('refer.description'),
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
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
                          color: AppColors().textColor),
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
