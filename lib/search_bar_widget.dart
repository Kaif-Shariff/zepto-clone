import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: const Row(
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.search,
            color: Colors.black45,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
