import 'dart:convert';
import 'package:chatbot/Resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveObject(String key, value) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  } catch (e) {
    rethrow;
  }
}

getSavedObject(String key) async {
  final prefs = await SharedPreferences.getInstance();
  var data = prefs.getString(key);
  return data != null ? json.decode(data) : null;
}

void showSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: colorPrimary,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(40),
    duration: const Duration(seconds: 3),
  );
}
