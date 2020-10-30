import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/SignUp.dart';

Future<SignUp> createSignUp(String email, String password) async {
  var body = new Map<String, String>();
  body['email'] = email;
  body['password'] = password;
  print(body);

  final http.Response response =
      await http.post('$baseUrl/register', body: body);

  final jsonData = json.decode(response.body);
  var signUpResponse = SignUp.fromJson(jsonData);

  return signUpResponse;
}
