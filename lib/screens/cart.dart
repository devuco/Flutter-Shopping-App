import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/models/Cart.dart' as model;
import 'package:my_app/screens/productDetails.dart';
import 'package:my_app/service/apiManager.dart';
import 'package:my_app/utils/Constants.dart';
import 'package:my_app/utils/Utils.dart';
import 'package:my_app/widgets/loader.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isLoading = true;
  model.Cart cart = model.Cart();

  @override
  void initState() {
    callApi();
    super.initState();
  }

  void callApi() async {
    try {
      model.Cart res = await ApiManager().getCart();
      setState(() => cart = res);
    } catch (e) {
      print(e);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back),
              color: Colors.black,
            ),
            const Text(
              "Cart",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: isLoading
          ? Loader(
              isLoading: isLoading,
              color: Colors.orange,
            )
          : ListView.builder(
              itemCount: cart.data?.products?.length ?? 0,
              itemBuilder: (context, index) {
                final item = cart.data?.products?[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          decoration: (BoxDecoration(
                              color: Utils.getColor(item?.product?.color),
                              borderRadius: BorderRadius.circular(8))),
                          height: 100,
                          width: 100,
                          child: Image.network(
                              '${Constants.baseUrl}/${item?.product?.image}'),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item?.product?.name ?? '',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '₹${item?.product?.discountedPrice.toString() ?? ''}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      '₹${item?.product?.price.toString() ?? ''}',
                                      style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '${item?.product?.discount.toString() ?? ''}%off',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                onTap: () => Get.to(const ProductDetails(),
                                    arguments: {
                                      "image": item?.product?.image,
                                      "id": item?.product?.sId,
                                      "color": item?.product?.color
                                    },
                                    curve: Curves.linear,
                                    transition: Transition.fadeIn,
                                    duration:
                                        const Duration(milliseconds: 300)),
                                child: const Text(
                                  'View Product',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.orange,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
