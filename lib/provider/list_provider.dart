import 'package:flutter/material.dart';
import 'package:reqress_app/api/api_service.dart';
import 'package:reqress_app/model/list_model.dart';

enum ResultState { loading, noData, hasData, error }

class ListProvider extends ChangeNotifier {
  final ApiService apiService;

  ListProvider({
    required this.apiService,
  }) {
    getUserList();
  }

  late ReqresListResult _reqresListResult;
  late ResultState _state;
  String _message = '';

  ReqresListResult get reqresListResult => _reqresListResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> getUserList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final listUser = await ApiService().getUserList();
      if (listUser.data.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _reqresListResult = listUser;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'error -> $e';
    } finally {
      notifyListeners();
    }
  }
}
