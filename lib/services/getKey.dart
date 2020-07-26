
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<String> getKey() async {
  String configContent = await rootBundle.loadString('config/config.json');
  final apiKey = json.decode(configContent)['api_key'];
  return apiKey;
}