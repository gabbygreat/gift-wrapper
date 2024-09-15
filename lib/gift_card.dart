import 'dart:math';

import 'package:flutter/material.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({super.key});

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  late int amount;

  @override
  void initState() {
    super.initState();
    amount = Random().nextInt(100000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        right: 5,
        left: 5,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/confetti.png',
          ),
          Align(
            child: Image.asset('assets/trophy.png'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'YOU WON ₦$amount',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
