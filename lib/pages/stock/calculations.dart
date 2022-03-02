import 'package:ldgr/services/preprocessor.dart';

class StockCalculations {
  sumOfAddedItems(List? eventLogs) {
    if (eventLogs == null) {
      return 0;
    } else if (eventLogs.isEmpty) {
      return 0;
    } else {
      num _added = 0;
      for (var i in eventLogs) {
        if (i['event_name'] == 'added_to_stock') {
          String _handleComma =
              InputHandler().commaToPeriod(i['event_quantity']);
          num _quantityInLog = num.tryParse(_handleComma) ?? 0;
          _added += _quantityInLog;
        }
      }
      return _added;
    }
  }

  sumOfRemovedItems(List? eventLogs) {
    if (eventLogs == null) {
      return 0;
    } else if (eventLogs.isEmpty) {
      return 0;
    } else {
      num _removed = 0;
      for (var i in eventLogs) {
        if (i['event_name'] == 'removed_from_stock') {
          String _handleComma =
              InputHandler().commaToPeriod(i['event_quantity']);
          num _quantityInLog = num.tryParse(_handleComma) ?? 0;
          _removed += _quantityInLog;
        }
      }
      return _removed;
    }
  }

  computeRemainingItems(String initialQty, num totalAdded, num totalRemoved) {
    String _handleComma =
              InputHandler().commaToPeriod(initialQty);
    num _parsedInitialQty = num.tryParse(_handleComma) ?? 0;
    num _remainingQty = (_parsedInitialQty + totalAdded) - totalRemoved;
    return _remainingQty;
  }
}
