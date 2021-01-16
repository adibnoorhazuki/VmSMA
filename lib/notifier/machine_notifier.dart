import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:vendingapps/models/machine.dart';

class MachineNotifier with ChangeNotifier {
  List<Machine> _machineList = [];
  Machine _currentMachine;

  UnmodifiableListView<Machine> get machineList => UnmodifiableListView(_machineList);

  Machine get currentMachine => _currentMachine;

  set machineList(List<Machine> machineList) {
    _machineList = machineList;
    notifyListeners();
  }

  set currentMachine(Machine machine) {
    _currentMachine = machine;
    notifyListeners();
  }

  addMachine(Machine machine) {
    _machineList.insert(0, machine);
    notifyListeners();
  }

  deleteMachine(Machine machine) {
    _machineList.removeWhere((_machine) => _machine.machineId == machine.machineId);
    notifyListeners();
  }
}