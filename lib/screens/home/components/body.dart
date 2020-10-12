import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/ProductProvider.dart';
import 'package:shop_app/screens/home/components/grid_view_list.dart';

import 'categorries.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> products = [];
  bool isWaiting = false;
  int position = 1;

  void getListProducts(int page) async {
    isWaiting = true;
    try {
      List<Product> listProduct = await ProductData().getProductData(page);
      isWaiting = false;
      setState(() {
        products = listProduct;
      });
    } catch (e) {
      isWaiting = false;
      print(e);
    }
  }

  Future getMoreProducts(int page) async {
    isWaiting = true;
    try {
      List<Product> listProduct = await ProductData().getProductData(page);
      isWaiting = false;
      setState(() {
        products.addAll(listProduct);
      });
    } catch (e) {
      isWaiting = false;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getListProducts(position);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _container = [
      NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (!isWaiting &&
              notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
            setState(() {
              isWaiting = true;
            });
            getMoreProducts(position++);
          }
          return true;
        },
        child: GridViewList(products: products),
      ),
      GridViewList(products: products),
      GridViewList(products: products),
      GridViewList(products: products),
    ];

    return ModalProgressHUD(
      inAsyncCall: isWaiting,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
            child: Text(
              "Women",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Categories(),
          _container[Provider.of<ProductProvider>(context).getSelectedIndex()],
        ],
      ),
    );
  }
}
