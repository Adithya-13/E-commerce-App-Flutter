class SignUp {
  SignUp({
    this.code,
    this.message,
  });

  String code;
  String message;

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        code: json["message"]["code"],
        message: json["message"]["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
