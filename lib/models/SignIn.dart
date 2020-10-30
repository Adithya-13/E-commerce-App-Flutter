// To parse this JSON data, do
//
//     final signIn = signInFromJson(jsonString);

import 'dart:convert';

SignIn signInFromJson(String str) => SignIn.fromJson(json.decode(str));

String signInToJson(SignIn data) => json.encode(data.toJson());

class SignIn {
  SignIn({
    this.message,
    this.response,
  });

  Message message;
  Response response;

  factory SignIn.fromJson(Map<String, dynamic> json) => SignIn(
        message: Message.fromJson(json["message"]),
        response: json["response"] != null
            ? Response.fromJson(json["response"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "response": response.toJson(),
      };
}

class Message {
  Message({
    this.code,
    this.message,
  });

  String code;
  String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class Response {
  Response({
    this.token,
  });

  String token;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
