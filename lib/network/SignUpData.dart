import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/SignUp.dart';

Future<SignUp> createSignUp(
    String email, String password, String name, File image) async {
  var body = new Map<String, String>();
  body['email'] = email;
  body['password'] = password;
  body['name'] = name;
  body['image'] = image != null
      ? 'data:image/png;base64,' + base64Encode(image.readAsBytesSync())
      : '';

  print(body);

  final http.Response response =
      await http.post('$baseUrl/register', body: body);

  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  var signUpResponse = SignUp.fromJson(map);

  if (response.statusCode == 200) {
    return signUpResponse;
  } else {
    throw Exception("Failed to Sign Up");
  }
}
