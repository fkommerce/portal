import '../../config/get_platform.dart';
import '../../db/init.dart';
import '../frogbase.dart';

late Frogbase fb;

String get httpProtocol => appSettings.useSecureProtocol ? 'https' : 'http';
String get baseUrl => '$httpProtocol://${appSettings.baseUrl}';
String get apiBaseUrl => '$baseUrl/api/v1';

const globalBaseUrl = 'fkommerce.algoramming.xyz';
const devBaseUrl = '103.113.227.236:9000';
final localBaseUrl = pt.isNotMobile ? '127.0.0.1:9000' : '10.0.2.2:9000';

const Map<String, String> kHeaders = {'Content-Type': 'application/json'};
