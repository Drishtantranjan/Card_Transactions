import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(221, 241, 47, 47),
            Color.fromARGB(133, 160, 159, 159)
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            '\$12,640.54',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Account ** 3498',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    '**** 9432',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  // Mastercard Icon
                  Icon(
                    Icons.credit_card,
                    color: Colors.orangeAccent,
                    size: 30.0,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
