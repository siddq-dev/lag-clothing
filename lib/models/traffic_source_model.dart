class TrafficSourceModel {
  final String source;

  final int visitors;

  const TrafficSourceModel({required this.source, required this.visitors});

  factory TrafficSourceModel.fromMap(Map<String, dynamic> map) {
    return TrafficSourceModel(
      source: map['source'] ?? '',
      visitors: map['visitors'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'source': source, 'visitors': visitors};
  }
}
