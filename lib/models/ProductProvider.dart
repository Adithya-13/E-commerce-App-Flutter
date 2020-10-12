import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<String> categories = ["Dresses", "Jewellery", "Footwear", "Hand Bag"];
  bool isWaiting = false;

  void setIsWaiting(bool isWaiting) {
    this.isWaiting = isWaiting;
    notifyListeners();
  }

  int getLength() {
    return categories.length;
  }

  String getCategories(int index) {
    return categories[index];
  }

  int selected = 0;

  int getSelectedIndex() {
    return selected;
  }

  void selectedIndex(int index) {
    selected = index;
    notifyListeners();
  }
}
