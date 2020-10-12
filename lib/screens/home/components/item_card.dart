import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;

  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.all(kDefaultPaddin),
                margin: EdgeInsets.only(left: kDefaultPaddin, top: 10),
                // For  demo we use fixed height  and width
                // Now we dont need them
                height: 180,
                width: 160,
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Hero(
                  tag: "${product.id}",
                  child: Image.network(product.image),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: kDefaultPaddin),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
              child: Text(
                // products is out demo list
                product.title,
                style: TextStyle(color: kTextLightColor),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: kDefaultPaddin, bottom: 5),
            child: Text(
              "\$${product.price}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
