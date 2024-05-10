import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.network(
          product.image,
          height: 90,
        ),
        Text(
          product.itemName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '₹ ${product.price}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red),
          ),
          child: InkWell(
            onTap: (){
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'ADD',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
