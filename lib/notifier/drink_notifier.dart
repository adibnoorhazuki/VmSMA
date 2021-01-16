import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:vendingapps/models/drink.dart';

class DrinkNotifier with ChangeNotifier {
  List<Drink> _drinkList = [];
  Drink _currentDrink;

  UnmodifiableListView<Drink> get drinkList => UnmodifiableListView(_drinkList);

  Drink get currentDrink => _currentDrink;

  set drinkList(List<Drink> drinkList) {
    _drinkList = drinkList;
    notifyListeners();
  }
  
  set currentDrink(Drink drink) {
    _currentDrink = drink;
    notifyListeners();
  }

  addDrink(Drink drink) {
    _drinkList.insert(0, drink);
    notifyListeners();
  }

  deleteDrink(Drink drink) {
    _drinkList.removeWhere((_drink) => _drink.drinkId == drink.drinkId);
    notifyListeners();
  }
}