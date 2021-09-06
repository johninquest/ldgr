
// Basic record data model
class Record {
  final int id;
  final String category;
  final String source;
  final double amount;
  final String createdAt;
  final String? lastUpdateAt;

  Record(
      {required this.id,
      required this.category,
      required this.source,
      required this.amount,
      required this.createdAt,
      required this.lastUpdateAt});

  Record.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        category = res['category'],
        source = res['source'],
        amount = res['amount'],
        createdAt = res['created_at'],
        lastUpdateAt = res['last_update_at'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'category': category,
      'source': source,
      'amount': amount,
      'created_at': createdAt,
      'last_update_at': lastUpdateAt
    };
  }
}

// Income data model
class Income {
  final int id;
  final String source;
  final double amount;
  final String createdAt;
  Income({
    required this.id,
    required this.source,
    required this.amount,
    required this.createdAt,  
  });

  Income.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        source = res['source'],
        amount = res['amount'],
        createdAt = res['created_at'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'source': source,
      'amount': amount,
      'created_at': createdAt,
    };
  }
}
