import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/model/todomodel.dart';

class APIs {
  static final apiKey = '';

  // Fetch the data in API in locations 
  static Future<Map<String, dynamic>?> getAPIs(double lat, double longs) async {
    // List<Map<String, dynamic>> presedata = [];
    final respose = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$lat,$longs'));
    final jsondata = json.decode(respose.body);

    // log('respose: ${jsondata}');
    if (jsondata.containsKey('location')) {
      Map<String, dynamic> locations = jsondata['location'];
      // final Map<String, dynamic> _current = jsondata['current'];
      // presedata.add(locations);
      // log("location: ${locations}");
      // log(locations['name']);

      // log("loctaio : ${presedata}");
      return locations;
    } else {
      log("JSON response does not contain 'location' data");
      return null;
    }
  }
// Fetch the API in current Temperature
  static Future<Map<String, dynamic>?> getCurrent(
      double lat, double longs) async {
    final respose = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$lat,$longs'));
    final jsonrespose = json.decode(respose.body);
    if (jsonrespose.containsKey('current')) {
      Map<String, dynamic> currentdata = jsonrespose['current'];
      // log('current :${currentdata}');
      return currentdata;
    } else {
      log("JSON response does not contain 'location' data");
      return null;
    }
  }

  // Fetch the data in firebase;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> createToDo(String title, String disc) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final user = ToDo(Title: title, description: disc, date: time, Id: time);
    return await firestore.collection('Todo').doc(time).set(user.toJson());
  }
// delete the data in firebase
  static Future<bool> deleteToDo(String id) async {
    await firestore.collection('Todo').doc(id).delete();
    return true;
  }
// update the data in firebase
  static Future<void> updateToDO(String id, String text, String des) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    await firestore.collection('Todo').doc(id).update({
      'Title': text,
      'description': des,
      'Date': time,
    });
  }
}
