// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class ChatViewModel {
  String? content;
  String? mediaType;
  Rx<String?> mediaPath;
  int? toId;
  String? fromId;
  String? duration;
  ChatViewModel({
    this.content,
    this.mediaType,
    required this.mediaPath,
    this.toId,
    this.fromId,
    this.duration,
  });
}
