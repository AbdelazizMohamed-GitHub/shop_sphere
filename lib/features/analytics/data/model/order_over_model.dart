class OrderOverModel {
  final int count;
  final double totalCost;
  final DateTime time;

  OrderOverModel( {
    required this.time,
    required this.totalCost,
    required this.count,
  });
  @override
  String toString() {
    return 'OrderOverModel(count: $count, totalCost: $totalCost, time: $time)';
  }
}
