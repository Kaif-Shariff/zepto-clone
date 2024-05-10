import 'package:clone/widget/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clone/get_pass_widget.dart';
import 'package:clone/demo.dart';
import 'package:clone/circular_profile_image_widget.dart';
import 'package:clone/search_bar_widget.dart';

import 'model/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    getProducts().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  Future<List<Product>> getProducts() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    return snapshot.docs
        .map((doc) => Product(
              doc['image'],
              doc['item_name'],
              doc['price'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircularProfileImageWidget(),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Delivery in ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: '7',
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: ' Mins ',
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      'Dadar-Dadar East,Dadar,Mumb...',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Icon(Icons.expand_more),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 22,
            ),
            const GetPassWidget(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/horizontal_image.jpg',
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Trending in ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: 'Dadar ',
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // List of products
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 70,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: products
                    .map((product) => ProductCard(product: product))
                    .toList(),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Zepto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DemoPage()),
            );
          }
        },
      ),
    );
  }
}
