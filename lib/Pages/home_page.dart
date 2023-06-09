import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Registered Successfully',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}