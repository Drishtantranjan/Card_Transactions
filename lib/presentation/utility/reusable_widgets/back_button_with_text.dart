import 'package:flutter/material.dart';

class BackButtonWithText extends StatelessWidget {
  const BackButtonWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Go back to the previous screen
      },
      child: Align(
        alignment: Alignment.centerLeft, // Align it vertically centered
        child: Row(
          mainAxisSize:
              MainAxisSize.min, // Prevents Row from expanding unnecessarily
          children: [
            const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20.0,
            ),
            const SizedBox(width: 5.0),
            const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
