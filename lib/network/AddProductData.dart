import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/AddProduct.dart';

Future<AddProduct> addProduct(
    {String title, File image, String description}) async {
  var body = new Map<String, String>();
  body['alt[]'] = title;
  body['images[]'] = image != null
      ? 'data:image/png;base64,' + base64Encode(image.readAsBytesSync())
      : '';
  body['alt[]'] = description;

  final http.Response response =
      await http.post('$baseUrl/product', body: body);

  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  var addProductResponse = AddProduct.fromJson(map);

  if (response.statusCode == 200) {
    return addProductResponse;
  } else {
    throw Exception("Failed to Add Product");
  }
}
