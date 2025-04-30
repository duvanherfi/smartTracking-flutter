// coverage:ignore-file

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_tracking/utils/extensions/string_extensions.dart';
import 'package:chopper/chopper.dart';

class RequestJsonConverter implements Converter {
  final Map<Type, Function>? typeToJsonFactoryMap;

  RequestJsonConverter(this.typeToJsonFactoryMap);

  @override
  FutureOr<Request> convertRequest(Request request) {
    if (request.multipart) {
      return request;
    }
    Request req =
        applyHeader(request, contentTypeKey, jsonHeaders, override: false);
    return _encodeJson(req);
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response<dynamic> response,
  ) =>
      response.copyWith(
        body: fromJsonData<BodyType, InnerType>(
          response.body.toString(),
          typeToJsonFactoryMap?[InnerType],
        ),
      );

  T? fromJsonData<T, InnerType>(String jsonData, Function? jsonParser) {
    if (jsonData.isJson()) {
      dynamic jsonMap = json.decode(jsonData);
      if (jsonMap is List) {
        if (jsonMap.isNotEmpty && jsonMap.first is String) {
          return jsonMap.cast<String>() as T;
        } else {
          return jsonMap.map((item) {
            if (jsonParser != null) {
              return jsonParser(item as Map<String, dynamic>) as InnerType;
            } else {
              return (item as Map<String, dynamic>) as InnerType;
            }
          }).toList() as T;
        }
      }
      if (jsonParser != null) {
        return jsonParser(jsonMap) as T;
      }
    }
    return null;
  }

  Request _encodeJson(Request request) {
    String? contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }
}
