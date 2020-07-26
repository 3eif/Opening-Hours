import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'getKey.dart';
import './getLocation.dart';
import '../structures/Business.dart';

Future<List<Business>> getBusinesses(String q) async {
  String apiKey = await getKey();
  Position pos = await getLocation();
  String query = q.replaceAll(new RegExp(r"\s+"), "%");
  http.Response res = await http.get(
    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${pos.latitude},${pos.longitude}&radius=7500&type=restaurant&keyword=$query&key=$apiKey',
    headers: {HttpHeaders.authorizationHeader: apiKey},
  );
  dynamic data = json.decode(res.body)["results"];

  List<Business> businesses = [];
  for (int i = 0; i < data.length; i++) {
    http.Response finalRes = await http.get(
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&fields=name,formatted_phone_number,type,formatted_address,rating,opening_hours/open_now,opening_hours/weekday_text&key=$apiKey',
      headers: {HttpHeaders.authorizationHeader: apiKey},
    );
    Business business = Business.fromJson(json.decode(finalRes.body)["result"]);
    if (business.openingHours != null) businesses.add(business);
  }
  return businesses;
}
