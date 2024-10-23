import 'package:flutter/material.dart';

import '../../../utility/config/AssetConfig.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;

  const Navbar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Assetconfig.walletIcon, 0),
          _buildNavItem(Assetconfig.graphIcon, 1),
          _buildNavItem(Assetconfig.transactionIcon, 2),
          _buildNavItem(Assetconfig.menuIcon, 3),
          _buildNavItem(Assetconfig.settingIcon, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(String assetPath, int index) {
    bool isSelected = selectedIndex == index;

    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.grey[800]
            : Colors.transparent, // Background for selected icon
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: IconButton(
        icon: ImageIcon(
          AssetImage(assetPath),
          color: isSelected
              ? Colors.white
              : Colors.grey, // Change color for selected icon
          size: 25,
        ),
        onPressed: () {
          // Handle onPressed logic
        },
      ),
    );
  }
}
