class AppTransaction {
  final int? id;
  final int customerId;
  final String itemName;
  final int quantity;
  final double price;
  final double total;
  final int status; // 0 = UNPAID, 1 = PAID
  final DateTime date;

  AppTransaction({
    this.id,
    required this.customerId,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.total,
    this.status = 0,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'item_name': itemName,
      'quantity': quantity,
      'price': price,
      'total': total,
      'status': status,
      'date': date.toIso8601String(),
    };
  }

  factory AppTransaction.fromMap(Map<String, dynamic> map) {
    return AppTransaction(
      id: map['id'],
      customerId: map['customer_id'],
      itemName: map['item_name'],
      quantity: map['quantity'],
      price: map['price'],
      total: map['total'],
      status: map['status'],
      date: DateTime.parse(map['date']),
    );
  }
}
