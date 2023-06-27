import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/web_content_model.dart';
import '../storage/jwt_storage_landing.dart';

class getWebContentService {
  static const String _url =
      "https://test.satta.biz/api/v1/seller_point_web_content.json";

  final Dio _dio = Dio();

  Future getWebContentListData() async {
    _dio.options.responseType = ResponseType.json;
    List<WebContentModel> _list = [];

    try {
      final _jwt = await jwtStorageLandingService().getJwtData();

      var response = await _dio.get(
        _url,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw DioException(
            requestOptions: response.requestOptions,
            error: 'HTTP status error: ${response.statusCode}');
      }
      debugPrint("${response.data}");
      return response.data;
    } catch (e) {
      throw e;
    }

  }
}