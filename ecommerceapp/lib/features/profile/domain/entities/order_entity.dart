class OrderEntity {
  const OrderEntity({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });

  final String id;
  final DateTime date;
  final double total;
  final String status;
}

