import 'package:flutter/material.dart';

class SliderIndex extends StatelessWidget {
  const SliderIndex({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
        (index) => Container(
          margin: EdgeInsets.all(6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index ? Colors.white : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}