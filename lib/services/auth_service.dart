import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://mobile.vodafone.com.eg';
  static const String _authPath = '/checkSeamless/realms/vf-realm/protocol/openid-connect/auth';
  static const String _tokenPath = '/auth/realms/vf-realm/protocol/openid-connect/token';

  static const String _clientId = 'cash-app';
  static const String _clientSecret = 'b86e30a8-ae29-467a-a71f-65c73f2ff5e3';

  static const Map<String, String> _baseHeaders = {
    'User-Agent': 'okhttp/4.12.0',
    'Connection': 'Keep-Alive',
    'Accept-Encoding': 'gzip',
    'x-agent-operatingsystem': '13',
    'clientId': 'AnaVodafoneAndroid',
    'Accept-Language': 'ar',
    'x-agent-device': 'Xiaomi 21061119AG',
    'x-agent-version': '2025.10.3',
    'x-agent-build': '1050',
    'digitalId': '28RI9U7ISU8SW',
    'device-id': '1df4efae59648ac3',
  };

  Future<Map<String, String?>> authenticate() async {
    try {
      // Step 1: Get seamless token and MSISDN
      final authUri = Uri.parse('$_baseUrl$_authPath').replace(queryParameters: {
        'client_id': _clientId,
      });

      final authResponse = await http.get(authUri, headers: _baseHeaders);

      if (authResponse.statusCode != 200) {
        throw Exception('فشل في المصادقة الأولى: ${authResponse.statusCode}');
      }

      final authData = json.decode(authResponse.body);
      final nuber = authData['msisdn']?.toString() ?? '';
      final number = '0$nuber';
      final seamlessToken = authData['seamlessToken']?.toString() ?? '';

      if (seamlessToken.isEmpty) {
        throw Exception('لم يتم استلام seamlessToken');
      }

      // Step 2: Get access token
      final tokenUri = Uri.parse('$_baseUrl$_tokenPath');

      final tokenHeaders = Map<String, String>.from(_baseHeaders);
      tokenHeaders.addAll({
        'Accept': 'application/json, text/plain, */*',
        'silentLogin': 'true',
        'CRP': 'false',
        'seamlessToken': seamlessToken,
        'firstTimeLogin': 'true',
        'digitalId': '',
      });

      final tokenResponse = await http.post(
        tokenUri,
        headers: tokenHeaders,
        body: {
          'grant_type': 'password',
          'client_secret': _clientSecret,
          'client_id': _clientId,
        },
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception('فشل في استخراج التوكن: ${tokenResponse.statusCode}');
      }

      final tokenData = json.decode(tokenResponse.body);
      final accessToken = tokenData['access_token']?.toString() ?? '';

      if (accessToken.isEmpty) {
        throw Exception('لم يتم استلام access_token');
      }

      return {
        'token': accessToken,
        'msisdn': number,
        'success': 'true',
      };
    } catch (e) {
      return {
        'token': null,
        'msisdn': null,
        'success': 'false',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, String?>> refreshToken(String oldToken) async {
    try {
      // Re-authenticate to get a fresh token
      return await authenticate();
    } catch (e) {
      return {
        'token': null,
        'msisdn': null,
        'success': 'false',
        'error': e.toString(),
      };
    }
  }
}
