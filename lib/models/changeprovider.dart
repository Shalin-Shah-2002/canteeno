import 'package:flutter/material.dart';
import 'package:canteeno/models/ItemsModel.dart';
import 'package:canteeno/services/myfitnesspalAPI.dart';

class CaloriesProvider with ChangeNotifier {
  List<Itemsmodel>? _items; 
  bool _isLoading = false; 
  String? _errorMessage;

  List<Itemsmodel>? get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchData(String search, int page) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await apifuntion(search, page);
      _items = data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
}
