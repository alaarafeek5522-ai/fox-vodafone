import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/token_model.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  bool _isLoading = false;
  String? _errorMessage;
  TokenModel? _tokenData;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  TokenModel? get tokenData => _tokenData;
  
  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    print('🔐 Login button pressed');
    
    try {
      final result = await _apiService.login();
      
      if (result != null) {
        _tokenData = TokenModel(
          msisdn: result['msisdn']!,
          seamlessToken: result['seamlessToken']!,
          accessToken: result['accessToken']!,
        );
        _isLoading = false;
        notifyListeners();
        print('✅ Login success!');
        return true;
      } else {
        _errorMessage = 'حدث خطأ في تسجيل الدخول';
        _isLoading = false;
        notifyListeners();
        print('❌ Login failed: result is null');
        return false;
      }
    } catch (e) {
      _errorMessage = 'لا يوجد اتصال بالإنترنت';
      _isLoading = false;
      notifyListeners();
      print('❌ Exception in login: $e');
      return false;
    }
  }
  
  void resetError() {
    _errorMessage = null;
    notifyListeners();
  }
}
