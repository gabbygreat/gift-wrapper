import 'package:demo/gift_card.dart';
import 'package:demo/wrapper.dart';
import 'package:flutter/material.dart';

class GiftContent extends StatelessWidget {
  const GiftContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned.fill(
          child: GiftCard(),
        ),
        Positioned.fill(
          child: Wrapper(),
        ),
      ],
    );
  }
}
