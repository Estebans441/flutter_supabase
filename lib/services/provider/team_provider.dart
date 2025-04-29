import 'package:flutter/cupertino.dart';

class TeamService with ChangeNotifier {
  String? _currentTeam;
  String? _currentUser;

  String? get currentTeam => _currentTeam;
  String? get currentUser => _currentUser;

  set currentTeam(String? value) {
    _currentTeam = value;
    notifyListeners();
  }

  set currentUser(String? value) {
    _currentUser = value;
    notifyListeners();
  }

  void clear() {
    _currentTeam = null;
    _currentUser = null;
    notifyListeners();
  }
}
