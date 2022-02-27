
import 'package:flutter/cupertino.dart';

class Error extends ChangeNotifier{
  String _error = "";

  String get error => _error;

  void setError(String error){
    _error = error;
    notifyListeners();
  }
}