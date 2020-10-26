class SignIn {
  SignIn({this.code, this.message, this.token});

  String code;
  String message;
  String token;

  factory SignIn.fromJson(Map<String, dynamic> json) => SignIn(
        code: json["message"]["code"],
        message: json["message"]["message"],
        token: json["response"]["token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "token": token,
      };
}
