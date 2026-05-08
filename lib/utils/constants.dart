class ApiConstants {
  static const String authUrl = 'http://mobile.vodafone.com.eg/checkSeamless/realms/vf-realm/protocol/openid-connect/auth';
  static const String tokenUrl = 'https://mobile.vodafone.com.eg/auth/realms/vf-realm/protocol/openid-connect/token';
  static const String targetUrl = 'https://internet.kesug.com/index.php';
  
  static const Map<String, String> authParams = {
    'client_id': 'cash-app',
  };
  
  static const Map<String, String> authHeaders = {
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
  
  static const Map<String, String> tokenPayload = {
    'grant_type': 'password',
    'client_secret': 'b86e30a8-ae29-467a-a71f-65c73f2ff5e3',
    'client_id': 'cash-app',
  };
  
  static const Map<String, String> tokenHeaders = {
    'User-Agent': 'okhttp/4.12.0',
    'Accept': 'application/json, text/plain, */*',
    'Accept-Encoding': 'gzip',
    'silentLogin': 'true',
    'CRP': 'false',
    'firstTimeLogin': 'true',
    'x-agent-operatingsystem': '13',
    'clientId': 'AnaVodafoneAndroid',
    'Accept-Language': 'ar',
    'x-agent-device': 'Xiaomi 21061119AG',
    'x-agent-version': '2025.10.3',
    'x-agent-build': '1050',
    'digitalId': '',
    'device-id': '1df4efae59648ac3',
  };
}
