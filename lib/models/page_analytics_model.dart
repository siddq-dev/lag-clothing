class PageAnalyticsModel {
  final String page;

  final int views;

  final int uniqueVisitors;

  final double averageTime;

  const PageAnalyticsModel({
    required this.page,
    required this.views,
    required this.uniqueVisitors,
    required this.averageTime,
  });

  factory PageAnalyticsModel.fromMap(Map<String, dynamic> map) {
    return PageAnalyticsModel(
      page: map['page'] ?? '',
      views: map['views'] ?? 0,
      uniqueVisitors: map['uniqueVisitors'] ?? 0,
      averageTime: (map['averageTime'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'views': views,
      'uniqueVisitors': uniqueVisitors,
      'averageTime': averageTime,
    };
  }
}
