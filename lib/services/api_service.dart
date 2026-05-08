import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  Future<Map<String, dynamic>?> getSeamlessToken() async {
    try {
      final uri = Uri.parse(ApiConstants.authUrl).replace(queryParameters: ApiConstants.authParams);
      print('📡 Calling: $uri');
      
      final response = await http.get(uri, headers: ApiConstants.authHeaders).timeout(
        const Duration(seconds: 30),
      );
      
      print('📡 Status code: ${response.statusCode}');
      print('📡 Response: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      }
      return null;
    } catch (e) {
      print('❌ Error in getSeamlessToken: $e');
      return null;
    }
  }

  Future<String?> getAccessToken(String seamlessToken) async {
    try {
      final headers = Map<String, String>.from(ApiConstants.tokenHeaders);
      headers['seamlessToken'] = seamlessToken;
      
      final response = await http.post(
        Uri.parse(ApiConstants.tokenUrl),
        body: ApiConstants.tokenPayload,
        headers: headers,
      ).timeout(const Duration(seconds: 30));
      
      print('📡 Token status: ${response.statusCode}');
      print('📡 Token response: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['access_token'];
      }
      return null;
    } catch (e) {
      print('❌ Error in getAccessToken: $e');
      return null;
    }
  }

  Future<bool> sendToTarget(String token, String msisdn) async {
    try {
      final url = Uri.parse('${ApiConstants.targetUrl}?token=$token&msisdn=$msisdn');
      print('📡 Sending to: $url');
      
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      print('📡 Target status: ${response.statusCode}');
      
      return response.statusCode == 200;
    } catch (e) {
      print('❌ Error in sendToTarget: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> login() async {
    print('🚀 Starting login process...');
    
    final seamlessData = await getSeamlessToken();
    if (seamlessData == null) {
      print('❌ Failed to get seamless token');
      return null;
    }
    
    print('✅ Got seamless data: $seamlessData');
    
    final msisdn = seamlessData['msisdn'];
    final seamlessToken = seamlessData['seamlessToken'];
    
    if (msisdn == null || seamlessToken == null) {
      print('❌ Missing msisdn or seamlessToken');
      return null;
    }
    
    final accessToken = await getAccessToken(seamlessToken);
    if (accessToken == null) {
      print('❌ Failed to get access token');
      return null;
    }
    
    print('✅ Got access token: ${accessToken.substring(0, accessToken.length > 20 ? 20 : accessToken.length)}...');
    
    final formattedNumber = '0$msisdn';
    print('📱 Formatted number: $formattedNumber');
    
    final sent = await sendToTarget(accessToken, formattedNumber);
    if (!sent) {
      print('❌ Failed to send to target');
      return null;
    }
    
    print('✅ All steps completed!');
    
    return {
      'msisdn': formattedNumber,
      'seamlessToken': seamlessToken,
      'accessToken': accessToken,
    };
  }
}
