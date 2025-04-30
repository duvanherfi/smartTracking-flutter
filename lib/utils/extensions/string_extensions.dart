// ignore_for_file: no_duplicate_case_values

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
RegExp firstLineregex = RegExp(
    r"([A|C|I][A-Z0-9<]{1})([A-Z]{3})([A-Z0-9<]{9})([0-9]{1})([A-Z0-9<]{15})");

extension StringExtension on String {


  static const _defaultServerDateFormat = "yyyy-MM-dd'T'HH:mm:ss.S";


  bool isJson() {
    try {
      json.decode(this);
    } catch (e) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toJson() {
    return json.decode(trim());
  }


  String capitalizeFirstLetter() =>
      replaceFirst(this[0], this[0].toUpperCase());

  String lastChars(int n) => substring(length - n);


  bool get isNullOrEmpty => trim().isEmpty == true;


  static String makeAwsUserPath({
    required String bucket,
    required String userId,
    String? extraPath,
  }) =>
      '$bucket/$userId${extraPath != null ? '/$extraPath' : ''}';

  bool toBoolean() {
    String str = this;
    return str != '0' && str != 'false' && str != '';
  }
}
