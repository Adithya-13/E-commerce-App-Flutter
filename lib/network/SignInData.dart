import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/SignIn.dart';

Future<SignIn> createSignIn(String email, String password) async {
  var body = new Map<String, String>();
  body['email'] = email;
  body['password'] = password;

  print(body);

  final http.Response response = await http.post('$baseUrl/login', body: body);

  final jsonData = json.decode(response.body);
  var map = Map<String, dynamic>.from(jsonData);
  var signInResponse = SignIn.fromJson(map);

  if (response.statusCode == 200) {
    return signInResponse;
  } else {
    throw Exception("Failed to Sign In");
  }
}
