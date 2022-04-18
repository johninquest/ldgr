class AnalysisDataOrganizer {
  getSum(List resList) {
    num additioner = 0;
    resList.forEach((i) {
      num val = num.tryParse(i['price']) ?? 0;
      additioner += val;
    });
    // return additioner.toString();
    return additioner.round();
  }

  getSumByPaidStatus(List resList, String ps) {
    num addn = 0;
    resList.forEach((i) {
      if (i['payment_status'] == ps) {
        num val = num.tryParse(i['price']) ?? 0;
        addn += val;
      }
    });
    return addn.round();
  }

  getSumByPaidStatusAndCostArea(List resList, String ps, String ca) {
    num addn = 0;
    resList.forEach((i) {
      if (i['payment_status'] == ps && i['cost_area'] == ca) {
        num val = num.tryParse(i['price']) ?? 0;
        addn += val;
      }
    });
    return addn.round();
  }
}
