import 'package:demo/gift_content.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift App'),
      ),
      body: const Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: GiftContent(),
        ),
      ),
    );
  }
}
