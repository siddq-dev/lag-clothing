import 'analytics_session_service.dart';
import 'analytics_tracking_service.dart';

class AnalyticsService {
  AnalyticsService._();

  static bool _sessionStarted = false;

  //----------------------------------------------------------
  // Track Page
  //----------------------------------------------------------

  static Future<void> track(
    String page,
  ) async {
    if (!_sessionStarted) {
      await AnalyticsSessionService.startSession(
        firstPage: page,
      );

      _sessionStarted = true;
    } else {
      await AnalyticsSessionService.updateSession(
        currentPage: page,
      );
    }

    await AnalyticsTrackingService.trackPage(
      page,
    );
  }

  //----------------------------------------------------------
  // End Session
  //----------------------------------------------------------

  static Future<void> endSession() async {
    await AnalyticsSessionService.endSession();

    _sessionStarted = false;
  }
}