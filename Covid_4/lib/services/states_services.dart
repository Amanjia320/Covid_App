// ignore: depend_on_referenced_packages, unused_import
import 'dart:convert';
import 'package:flutter_application_4/Model/world_states_model.dart';
import 'package:flutter_application_4/utility/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<worldStatesModel> fecthWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return worldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
