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
          num _quantityInLog = num.tryParse(i['event_quantity']) ?? 0;
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
          num _quantityInLog = num.tryParse(i['event_quantity']) ?? 0;
          _removed += _quantityInLog;
        }
      }
      return _removed;
    }
  }

  computeRemainingItems(String initialQty, num totalAdded, num totalRemoved) {
    num _parsedInitialQty = num.tryParse(initialQty) ?? 0;
    num _remainingQty = (_parsedInitialQty + totalAdded) - totalRemoved;
    return _remainingQty;
  }
}
