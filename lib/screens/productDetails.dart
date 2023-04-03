import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/models/Product.dart';
import 'package:my_app/screens/cart.dart';
import 'package:my_app/service/apiManager.dart';
import 'package:my_app/utils/Constants.dart';
import 'package:my_app/utils/Utils.dart';
import 'package:my_app/widgets/arc.dart';
import 'package:my_app/widgets/customButton.dart';
import 'package:my_app/widgets/loader.dart';
import 'package:my_app/widgets/ratingBar.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLoading = true;
  Product data = Product();
  bool isButtonLoading = false;

  @override
  void initState() {
    callApi();
    super.initState();
  }

  void callApi() async {
    String productId = Get.arguments["id"];
    try {
      Product res = await ApiManager().getProductDetails(productId);
      if (!mounted) return;
      setState(() => data = res);
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = data.data;

    void addToCart() async {
      setState(() => isButtonLoading = true);
      try {
        await ApiManager().addToCart(product?.sId);
        if (mounted) {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            builder: (context) => SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Item Added",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, top: 18),
                      child: CustomButton(
                        onPress: () {
                          Navigator.pop(context);
                          Future.delayed(
                              Duration(milliseconds: 300),
                              () => Get.to(const Cart(),
                                  transition: Transition.downToUp,
                                  duration: const Duration(milliseconds: 500)));
                        },
                        title: "Go to Cart",
                        color: Utils.getColor(product?.color),
                      ),
                    ),
                    CustomButton(
                        onPress: () => Navigator.pop(context),
                        title: "Continue Shopping",
                        color: Utils.getColor(product?.color))
                  ],
                ),
              ),
            ),
          ).whenComplete(() => setState(() => isButtonLoading = false));
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Platform.isIOS
                      ? Icons.arrow_back_ios_new
                      : Icons.arrow_back),
                ),
                backgroundColor: Utils.getColor(Get.arguments["color"]),
                toolbarHeight: kToolbarHeight + 1,
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 28,
                    ),
                  )
                ],
                elevation: 0,
                automaticallyImplyLeading: false,
                expandedHeight: 50,
                floating: true,
                snap: true,
              )
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Arc(
                          color: Get.arguments["color"],
                          child: Container(
                              height: Get.height / 3,
                              width: Get.width - 150,
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: Get.arguments["image"] ?? '',
                                child: Image.network(
                                  '${Constants.baseUrl}/${Get.arguments["image"]}',
                                ),
                              )),
                        ),
                        isLoading
                            ? Loader(
                                isLoading: isLoading,
                                color: Colors.orange,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: RatingBar(
                                            initialIndex:
                                                (product?.avgRating ?? 0) - 1,
                                            enabled: false,
                                          ),
                                        ),
                                        Text(
                                          ' ${product?.totalRatings.toString() ?? ''} Review(s)',
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18),
                                      child: Text(
                                        product?.name ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18),
                                      child: Text(
                                        product?.description ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800]),
                                      ),
                                    )
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomButton(
                  isLoading: isButtonLoading,
                  onPress: isButtonLoading ? null : addToCart,
                  title: "Add to Cart",
                  color: Utils.getColor(product?.color),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
