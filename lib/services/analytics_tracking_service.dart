import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AnalyticsTrackingService {
  AnalyticsTrackingService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //----------------------------------------------------------
  // Track Page Visit
  //----------------------------------------------------------

  static Future<void> trackPage(String page) async {
    try {
      final uid = _auth.currentUser?.uid ?? "guest";

      await _firestore.collection("page_visits").add({
        "page": page,

        "userId": uid,

        "device": _device(),

        "platform": _platform(),

        "browser": _browser(),

        "source": "Direct",

        "region": "Unknown",

        "timestamp": Timestamp.now(),
      });
    } catch (e) {
      debugPrint("Analytics Error : $e");
    }
  }

  //----------------------------------------------------------
  // Device
  //----------------------------------------------------------

  static String _device() {
    if (kIsWeb) {
      return "Desktop";
    }

    if (Platform.isAndroid) {
      return "Android";
    }

    if (Platform.isIOS) {
      return "iPhone";
    }

    if (Platform.isMacOS) {
      return "Mac";
    }

    if (Platform.isWindows) {
      return "Windows";
    }

    if (Platform.isLinux) {
      return "Linux";
    }

    return "Unknown";
  }

  //----------------------------------------------------------
  // Platform
  //----------------------------------------------------------

  static String _platform() {
    if (kIsWeb) {
      return "Web";
    }

    return Platform.operatingSystem;
  }

  //----------------------------------------------------------
  // Browser
  //----------------------------------------------------------

  static String _browser() {
    if (!kIsWeb) {
      return "";
    }

    return "Web Browser";
  }
}
