import 'package:api_practice/core/api_requests.dart';
import 'package:api_practice/model/product_details.dart';
import 'package:api_practice/widgets/custom_card.dart';
import 'package:api_practice/widgets/home_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<ProductDetails> allProducts = [];

  Future<void> fetchProduct() async {
    final response = await http.get(Uri.parse(ApiRequests.allProducts));
    allProducts = productDetailsFromJson(response.body);
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: allProducts.isEmpty
            ? ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => HomeShimmer(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return CustomCard(
                    productDetails: allProducts[index],
                  );
                },
                itemCount: allProducts.length,
              ),
      ),
    );
  }
}
