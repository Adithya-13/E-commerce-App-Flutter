import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

class ProductData {
  List<Product> products = [];

  Future getProductData(int numberStart) async {
    Response response =
        await get("$baseUrl/products?start=$numberStart&limit=5&min=0&max=800");

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
