import 'dart:convert';
import 'package:api_practice/core/api_requests.dart';
import 'package:api_practice/model/product_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class BasketProductCard extends StatefulWidget {
  final int productId;
  final int quantity;

  const BasketProductCard({
    required this.productId,
    required this.quantity,
  });

  @override
  State<BasketProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<BasketProductCard> {
  late ProductDetails? currentProductDetails;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProductDetails(productId: widget.productId.toString());
  }

  Future<void> fetchProductDetails({required String productId}) async {
    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse('${ApiRequests.allProducts}/$productId'));
    currentProductDetails = ProductDetails.fromJson(jsonDecode(response.body));
    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: isLoading
            ? SizedBox(
                width: double.infinity,
                height: 200.0,
                child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: const Duration(seconds: 2),
                  enabled: true,
                  loop: 2,
                  baseColor: const Color.fromARGB(255, 228, 228, 228),
                  highlightColor: Colors.white,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID : ${currentProductDetails?.id}'),
                    Text('Title : ${currentProductDetails?.title}'),
                    if (currentProductDetails?.image != null)
                      Image.network(
                        currentProductDetails!.image,
                        height: 100,
                        width: 100,
                      ),
                    Text('Price : \$${currentProductDetails?.price ?? 'N/A'}'),
                    Text('Quantity : ${widget.quantity}'),
                    Text('Product Id : ${widget.productId}'),
                  ],
                ),
              ));
  }
}
