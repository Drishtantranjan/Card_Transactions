import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:transaction_heatmap/presentation/utility/AppColors.dart';

class IconWithTextContainer extends StatelessWidget {
  final double height;
  final double width;
  final String iconPath;
  final String title;
  const IconWithTextContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.iconPath,
      required this.title});

  @override
  Widget build(BuildContext context) {
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
                  AssetImage(iconPath),
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                translate(title),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
