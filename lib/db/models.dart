// Basic record data model
class Record {
  final int id;
  final String category;
  final String source;
  final num amount;
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
  final num amount;
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

// Basic record data model
/* class Entry {
  final String account;
  final String costArea;
  final String itemCategory;
  final String itemName;
  final String itemPrice ;
  final String itemQty; 
  final String itemUnit; 
  final String paymentMethod;
  final String createdDateTime; 
  final String lastUpdateDateTime;

  Entry(
      {required this.account,
      required this.costArea,
      required this.itemCategory,
      required this.itemName,
      required this.itemPrice, 
      required this.itemQty, 
      required this.itemUnit, 
      required this.paymentMethod,
      required this.createdDateTime, 
      required this.lastUpdateDateTime 
      });

  Entry.fromMap(Map<String, dynamic> res)
      : account = res['account'],
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
 */