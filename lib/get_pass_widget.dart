import 'package:flutter/material.dart';

class GetPassWidget extends StatelessWidget {
  const GetPassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Image.asset(
        'assets/images/getpass.jpg',
        // width: 60,
        // height: 44,
        width: 60,
        height: 30,
        fit: BoxFit.cover,
      ),
    );
  }
}
