class Customer {
  final int? id;
  final String name;
  final String? note;
  final DateTime? deadline;
  final DateTime createdAt;

  Customer({
    this.id,
    required this.name,
    this.note,
    this.deadline,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'deadline': deadline?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      note: map['note'],
      deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
