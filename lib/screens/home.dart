import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/models/HomeProducts.dart';
import 'package:my_app/screens/cart.dart';
import 'package:my_app/screens/productDetails.dart';
import 'package:my_app/service/apiManager.dart';
import 'package:my_app/utils/Constants.dart';
import 'package:my_app/utils/Utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeProducts homeProducts = HomeProducts();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    callApi();
    super.initState();
  }

  void callApi() async {
    try {
      HomeProducts res = await ApiManager().getProducts();
      setState(() => homeProducts = res);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 16,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      hintText: "Search",
                      border: InputBorder.none),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.orange[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Picks For You",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18)),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 266,
                    crossAxisSpacing: 8),
                itemCount: homeProducts.data?.length ?? 0,
                itemBuilder: (renderCard),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => Get.to(const Cart(),
            transition: Transition.native,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500)),
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }

  GestureDetector renderCard(BuildContext contex, int index) {
    final product = homeProducts.data?[index];
    return GestureDetector(
      onTap: () => Get.to(const ProductDetails(),
          arguments: {
            "image": product?.image,
            "id": product?.sId,
            "color": product?.color
          },
          curve: Curves.linear,
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Utils.getColor(product?.color),
          boxShadow: [
            BoxShadow(
              color: Colors.orange[200] ?? Colors.orange,
              offset: const Offset(
                1.0,
                1.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            if (product?.discount != 0)
              Positioned(
                top: 10,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    '${product?.discount}% OFF',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: product?.image ?? '',
                    child: Image.network(
                      '${Constants.baseUrl}/${product?.image ?? ''}',
                      height: 160,
                      width: 120,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product?.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '₹${product?.price.toString() ?? ''}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                '₹${product?.discountedPrice.toString() ?? ''}',
                                style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
