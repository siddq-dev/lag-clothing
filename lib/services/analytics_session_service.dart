import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AnalyticsSessionService {
  AnalyticsSessionService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final Uuid _uuid = const Uuid();

  static String? _sessionId;

  //----------------------------------------------------------
  // Start Session
  //----------------------------------------------------------

  static Future<void> startSession({required String firstPage}) async {
    if (_sessionId != null) return;

    _sessionId = _uuid.v4();

    final uid = _auth.currentUser?.uid ?? "guest";

    await _firestore.collection("sessions").doc(_sessionId).set({
      "sessionId": _sessionId,
      "userId": uid,

      "startedAt": Timestamp.now(),
      "endedAt": null,

      "firstPage": firstPage,
      "lastPage": firstPage,

      "pageCount": 1,

      "active": true,
    });
  }

  //----------------------------------------------------------
  // Update Session
  //----------------------------------------------------------

  static Future<void> updateSession({required String currentPage}) async {
    if (_sessionId == null) return;

    final ref = _firestore.collection("sessions").doc(_sessionId);

    final snapshot = await ref.get();

    if (!snapshot.exists) return;

    final data = snapshot.data()!;

    final pageCount = (data["pageCount"] ?? 0) + 1;

    await ref.update({"lastPage": currentPage, "pageCount": pageCount});
  }

  //----------------------------------------------------------
  // End Session
  //----------------------------------------------------------

  static Future<void> endSession() async {
    if (_sessionId == null) return;

    await _firestore.collection("sessions").doc(_sessionId).update({
      "endedAt": Timestamp.now(),
      "active": false,
    });

    _sessionId = null;
  }

  //----------------------------------------------------------
  // Current Session Id
  //----------------------------------------------------------

  static String? get sessionId => _sessionId;
}
