class Record {
  final int id;
  final String category;
  final String source;
  final num amount;
  final String createdAt;
  final String lastUpdateAt;

  Record(
      {
      required this.id,
      required this.category,
      required this.source,
      required this.amount,
      required this.createdAt,
      required this.lastUpdateAt
      });

  Map<String, dynamic> toMap() {
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
