class Invoice {
  final int id;
  final double total;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Invoice({
    required this.id,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  /// Factory method to create an Invoice instance from JSON
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as int,
      total: (json['total'] as num).toDouble(),
      status: json['status'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
    );
  }

  /// Method to convert an Invoice instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
