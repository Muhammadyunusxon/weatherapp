
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: AssetImage(
          'assets/image/container.png'
        ))
      ),
    );
  }
}