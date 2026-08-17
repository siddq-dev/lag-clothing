import 'package:cloud_firestore/cloud_firestore.dart';

class SessionAnalyticsModel {
  final String sessionId;
  final String userId;

  final Timestamp startedAt;
  final Timestamp? endedAt;

  final String firstPage;
  final String lastPage;

  final int pageCount;

  final bool active;

  const SessionAnalyticsModel({
    required this.sessionId,
    required this.userId,
    required this.startedAt,
    this.endedAt,
    required this.firstPage,
    required this.lastPage,
    required this.pageCount,
    required this.active,
  });

  factory SessionAnalyticsModel.fromMap(Map<String, dynamic> map) {
    return SessionAnalyticsModel(
      sessionId: map["sessionId"] ?? "",
      userId: map["userId"] ?? "",
      startedAt: map["startedAt"],
      endedAt: map["endedAt"],
      firstPage: map["firstPage"] ?? "",
      lastPage: map["lastPage"] ?? "",
      pageCount: map["pageCount"] ?? 0,
      active: map["active"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sessionId": sessionId,
      "userId": userId,
      "startedAt": startedAt,
      "endedAt": endedAt,
      "firstPage": firstPage,
      "lastPage": lastPage,
      "pageCount": pageCount,
      "active": active,
    };
  }
}
