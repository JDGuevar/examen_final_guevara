import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:examen_final_guevara/models/tren_model.dart';

class TrenProvider extends ChangeNotifier {
  final String _baseUrl = 'https://cabe6cf79c7c674a4774.free.beeceptor.com/api/trenes/';
  List<Map<String, dynamic>> trenList = [];

  TrenProvider() {
    print('TrenProvider');
  }

  Future<List<Map<String, dynamic>>> getall() async {
    List<Map<String, dynamic>> trenes = [];

    try {
      var url = Uri.https(_baseUrl, '');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        trenes = TrenModel.fromMap(body) as List<Map<String, dynamic>>;
      } else {
        throw Exception('Failed to load drinks');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load drinks');
    }

    return trenes;
  }

  Future<Map<String, dynamic>> getById(id) async {
    Map<String, dynamic> tren = {};

    try {
      var url = Uri.https(_baseUrl, '/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        tren = TrenModel.fromMap(body) as Map<String, dynamic> ;
      } else {
        throw Exception('Failed to load drink');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load drink');
    }

    return tren;
  }
}
