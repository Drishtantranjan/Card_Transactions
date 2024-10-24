import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:transaction_heatmap/presentation/utility/AppColors.dart';
import 'package:transaction_heatmap/presentation/utility/config/AssetConfig.dart';

class CashbackContainer extends StatelessWidget {
  final double height;
  final double width;
  const CashbackContainer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors()
            .containerBackground, // Background color for the container
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.all(16.0), // Padding inside the container
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align the text to the start
        children: [
          // Cashback Text
          Text(
            translate(
                'firstRow.cashback'), // Assuming you have a translation method
            style: TextStyle(
              color: Colors.white, // Adjust based on your theme
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12), // Space between text and images

          // Stack of Icons/Images with Overlap Effect
          Container(
            // Add a Container for proper sizing
            height: 40, // Set height to match images
            child: Stack(
              children: [
                // Amazon Image
                Positioned(
                  left: 0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                    child:
                        Image.asset(Assetconfig.amazon, height: 40, width: 40),
                  ),
                ),

                // McDonald's Image (Slightly Overlapping)
                Positioned(
                  left: 35, // Shift this image to the right slightly
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                    child: Image.asset(Assetconfig.uber, height: 40, width: 40),
                  ),
                ),

                // Adidas Image (Slightly Overlapping)
                Positioned(
                  left: 70, // Shift this image further to the right
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                    child: Image.asset(Assetconfig.lenskart,
                        height: 40, width: 40),
                  ),
                ),

                // Spotify Image (Slightly Overlapping)
                Positioned(
                  left: 105, // Further shift this image to the right
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                    child:
                        Image.asset(Assetconfig.zomato, height: 40, width: 40),
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
