import 'package:flutter/material.dart';

class CircularProfileImageWidget extends StatelessWidget {
  const CircularProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/profile_image.png'), 
      radius: 15,
    );
  }
}
