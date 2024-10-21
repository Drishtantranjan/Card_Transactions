import 'package:flutter/material.dart';
import 'package:transaction_heatmap/presentation/utility/AppColors.dart';
import 'package:transaction_heatmap/presentation/utility/config/AssetConfig.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: AppBar(
        backgroundColor: AppColors().appBackground,
        elevation: 0,
        leading: Center(
          // Centering the leading widget
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              foregroundImage: AssetImage(Assetconfig.avatarImage),
            ),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: AppColors().textFieldBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.search,
                  color: AppColors().textColor,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: AppColors().hintColor),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 25,
              color: AppColors().textColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
