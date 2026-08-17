class DeviceAnalyticsModel {
  final String device;

  final int visitors;

  final double percentage;

  const DeviceAnalyticsModel({
    required this.device,
    required this.visitors,
    required this.percentage,
  });

  factory DeviceAnalyticsModel.fromMap(Map<String, dynamic> map) {
    return DeviceAnalyticsModel(
      device: map['device'] ?? '',
      visitors: map['visitors'] ?? 0,
      percentage: (map['percentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'device': device, 'visitors': visitors, 'percentage': percentage};
  }
}
