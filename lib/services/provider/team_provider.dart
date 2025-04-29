import 'package:flutter/cupertino.dart';

class TeamService with ChangeNotifier {
  String? _currentTeam;

  String? get currentTeam => _currentTeam;

  set currentTeam(String? value) {
    _currentTeam = value;
    notifyListeners();
  }

  void clear() {
    _currentTeam = null;
    notifyListeners();
  }
}
