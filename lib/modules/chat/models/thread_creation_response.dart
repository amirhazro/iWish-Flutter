class CreateThreadResponse {
  int? id;
  String? threadId;
  int? userId1;
  int? userId2;
  String? isActive;

  CreateThreadResponse(
      {this.id, this.threadId, this.userId1, this.userId2, this.isActive});

  CreateThreadResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    threadId = json['thread_id'];
    userId1 = json['user_id1'];
    userId2 = json['user_id2'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thread_id'] = threadId;
    data['user_id1'] = userId1;
    data['user_id2'] = userId2;
    data['is_active'] = isActive;
    return data;
  }
}
