import 'package:iwish_flutter/models/base_response_model.dart';

class ChatFileUploadResponseModel extends BaseResponseModel {
  Data? data;

  ChatFileUploadResponseModel(
      {super.status, super.statusCode, super.message, this.data, super.error});

  ChatFileUploadResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  List<Files>? files;

  Data({this.files});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? fieldname;
  String? originalname;
  String? encoding;
  String? mimetype;
  int? size;
  String? bucket;
  String? key;
  String? acl;
  String? contentType;
  Null contentDisposition;
  Null contentEncoding;
  String? storageClass;
  Null serverSideEncryption;
  Null metadata;
  String? location;
  String? etag;

  Files(
      {this.fieldname,
      this.originalname,
      this.encoding,
      this.mimetype,
      this.size,
      this.bucket,
      this.key,
      this.acl,
      this.contentType,
      this.contentDisposition,
      this.contentEncoding,
      this.storageClass,
      this.serverSideEncryption,
      this.metadata,
      this.location,
      this.etag});

  Files.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    size = json['size'];
    bucket = json['bucket'];
    key = json['key'];
    acl = json['acl'];
    contentType = json['contentType'];
    contentDisposition = json['contentDisposition'];
    contentEncoding = json['contentEncoding'];
    storageClass = json['storageClass'];
    serverSideEncryption = json['serverSideEncryption'];
    metadata = json['metadata'];
    location = json['location'];
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldname'] = fieldname;
    data['originalname'] = originalname;
    data['encoding'] = encoding;
    data['mimetype'] = mimetype;
    data['size'] = size;
    data['bucket'] = bucket;
    data['key'] = key;
    data['acl'] = acl;
    data['contentType'] = contentType;
    data['contentDisposition'] = contentDisposition;
    data['contentEncoding'] = contentEncoding;
    data['storageClass'] = storageClass;
    data['serverSideEncryption'] = serverSideEncryption;
    data['metadata'] = metadata;
    data['location'] = location;
    data['etag'] = etag;
    return data;
  }
}
