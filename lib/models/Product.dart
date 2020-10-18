import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  final List<Variant> variants;

  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
    this.variants,
  });
}

class Variant {
  final String color, image;
  final int imageID;

  Variant({this.color, this.image, this.imageID});
}

class ProductData {
  final String baseUrl =
      "https://halal-food-service-290609.dt.r.appspot.com/products";
  List<Product> products = [];

  Future getProductData(int numberStart) async {
    Response response =
        await get("$baseUrl?start=$numberStart&limit=5&min=0&max=800");
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      List responseData = decodedData["response"]["data"];
      for (int i = 0; i < responseData.length; i++) {
        int id = responseData[i]["id"];
        String title = responseData[i]["title"];
        String image = responseData[i]["images"][0]["src"];
        String description = responseData[i]["description"];
        int price = responseData[i]["price"];

        List variantsData = decodedData["response"]["data"][i]["images"];
        List<Variant> variants = [];

        for (int j = 0; j < variantsData.length; j++) {
          String titleColor = variantsData[j]["alt"];
          String imageVariant = variantsData[j]["src"];
          int imageID = variantsData[j]["image_id"];

          variants.add(Variant(
              color: titleColor, image: imageVariant, imageID: imageID));
        }
        Product item = Product(
          title: title,
          image: image,
          description: description,
          price: price,
          id: id,
          size: 10,
          color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          variants: variants,
        );
        products.add(item);
      }
      return products;
    }
  }
}
//
// List<Product> products = [
//   Product(
//       id: 1,
//       title: "Office Code",
//       price: 234,
//       size: 12,
//       description: dummyText,
//       image: "assets/images/bag_1.png",
//       color: Color(0xFF3D82AE)),
//   Product(
//       id: 2,
//       title: "Belt Bag",
//       price: 234,
//       size: 8,
//       description: dummyText,
//       image: "assets/images/bag_2.png",
//       color: Color(0xFFD3A984)),
//   Product(
//       id: 3,
//       title: "Hang Top",
//       price: 234,
//       size: 10,
//       description: dummyText,
//       image: "assets/images/bag_3.png",
//       color: Color(0xFF989493)),
//   Product(
//       id: 4,
//       title: "Old Fashion",
//       price: 234,
//       size: 11,
//       description: dummyText,
//       image: "assets/images/bag_4.png",
//       color: Color(0xFFE6B398)),
//   Product(
//       id: 5,
//       title: "Office Code",
//       price: 234,
//       size: 12,
//       description: dummyText,
//       image: "assets/images/bag_5.png",
//       color: Color(0xFFFB7883)),
//   Product(
//     id: 6,
//     title: "Office Code",
//     price: 234,
//     size: 12,
//     description: dummyText,
//     image: "assets/images/bag_6.png",
//     color: Color(0xFFAEAEAE),
//   ),
// ];
//
// String dummyText =
//     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
