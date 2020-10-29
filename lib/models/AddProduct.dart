class AddProduct {
  AddProduct({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory AddProduct.fromJson(Map<String, dynamic> json) => AddProduct(
        code: json["meta"]["code"],
        message: json["meta"]["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
