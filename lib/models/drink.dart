
class Drink {
  String drinkId;
  String drinkName;
  String drinkQty;
  String machineId;
  String userId;

  Drink();

  Drink.fromMap(Map<String, dynamic> data) {
    drinkId = data['drinkId'];
    drinkName = data['drinkName'];
    drinkQty = data['drinkQty'];
    machineId = data['machineId'];
    userId = data['userId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'drinkId': drinkId,
      'drinkName': drinkName,
      'drinkQty': drinkQty,
      'machineId': machineId,
      'userId' : userId,
    };
  }
}