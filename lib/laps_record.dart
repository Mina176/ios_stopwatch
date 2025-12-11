import 'package:flutter/material.dart';

class LapsRecord extends StatelessWidget {
  const LapsRecord({super.key, required this.elapsed});
  final Duration elapsed;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade800),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lap ${index + 1}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                '00:0${index + 1}.00',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
