import 'dart:developer' as developer;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:iwish_flutter/utils/http_exception.dart';
import 'package:http_parser/http_parser.dart';

class APIClient {
  final _client = http.Client();
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': '@!w!\$h'
  };

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    if (headers == null) {
      this.headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    } else {
      headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    }
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      var response = await _client
          .get(
            Uri.parse(url),
            headers: headers ?? this.headers,
          )
          .timeout(const Duration(seconds: 30));
      developer.log(response.toString(), name: 'Response');
      if (response.statusCode >= 500) {
        throw HttpException('Something went wrong. Please try again latter');
      }
      return response;
    } else {
      throw HttpException('100');
    }
  }

  Future<http.Response> getWithBodyParams(String url, String body,
      {Map<String, String>? headers}) async {
    if (headers == null) {
      this.headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    } else {
      headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    }
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      var request = http.Request('GET', Uri.parse(url));
      request.body = body;
      request.headers.addAll(headers ?? this.headers);

      http.StreamedResponse streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode >= 500) {
        throw HttpException('Something went wrong. Please try again latter');
      }
      return response;
    } else {
      throw HttpException('100');
    }
  }

  Future<http.Response> post(String url,
      {dynamic body, Map<String, String>? headers}) async {
    if (headers == null) {
      this.headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    } else {
      headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    }
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      var response = await _client
          .post(
            Uri.parse(url),
            headers: headers ?? this.headers,
            body: body,
          )
          .timeout(const Duration(seconds: 30));
      developer.log(response.toString(), name: 'Response');
      if (response.statusCode >= 500) {
        throw HttpException('Something went wrong. Please try again latter');
      }
      return response;
    } else {
      throw HttpException('100');
    }
  }

  Future<http.Response> postUploadImage(
      String url, Map<String, String> headers, File imageFile) async {
    headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode >= 500) {
        throw HttpException('Something went wrong. Please try again latter');
      }
      return response;
    } else {
      throw HttpException('100');
    }
  }

  Future<http.Response> uploadImageFile(String url,
      {Map<String, String>? headers, dynamic body}) async {
    if (headers == null) {
      this.headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    } else {
      headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");
    }
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      var response = await _client
          .delete(
            Uri.parse(url),
            headers: headers ?? this.headers,
            body: body,
          )
          .timeout(
            const Duration(seconds: 30),
          );
      developer.log(response.toString(), name: 'Response');
      if (response.statusCode >= 500) {
        throw HttpException('Something went wrong. Please try again latter');
      }
      return response;
    } else {
      throw HttpException('100');
    }
  }

  Future<http.Response> postMultipartRequest(
      String url,
      Map<String, String> headers,
      Map<String, String> bodyParams,
      File imageFileOne,
      File imageFileTwo,
      File imageFileThree) async {
    headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      request.fields.addAll(bodyParams);

      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          imageFileOne.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          imageFileTwo.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          imageFileThree.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode >= 500) {
        throw HttpException('Something went wrong. Please try again latter');
      }
      return response;
    } else {
      throw HttpException('100');
    }
  }

  Future<http.Response> postMultipartFile(String url,
      Map<String, String> headers, http.MultipartFile multipartFile) async {
    headers.putIfAbsent("Keep-Alive", () => "timeout=5, max=1");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.files.add(multipartFile);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode >= 500) {
        throw HttpException('Something went wrong. Please try again latter');
      }
      return response;
    } else {
      throw HttpException('100');
    }
  }

  closeClient() {
    _client.close();
  }
}
