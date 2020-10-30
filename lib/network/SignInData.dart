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
  SignIn signInResponse = SignIn.fromJson(jsonData);
  print(signInResponse.message.code);

  return signInResponse;
}
