import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/ProductProvider.dart';

import '../../../constants.dart';

// We need satefull widget for our categories

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // By default our first item will be selected

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Provider.of<ProductProvider>(context).getLength(),
          itemBuilder: (context, index) => buildCategory(index, context),
        ),
      ),
    );
  }

  Widget buildCategory(int index, BuildContext context) {
    int selectedIndex =
        Provider.of<ProductProvider>(context).getSelectedIndex();
    return GestureDetector(
      onTap: () {
        Provider.of<ProductProvider>(context, listen: false)
            .selectedIndex(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Provider.of<ProductProvider>(context).getCategories(index),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
