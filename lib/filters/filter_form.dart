import 'package:flutter/material.dart';
import 'package:ldgr/filters/filter_data.dart';
import 'package:ldgr/shared/lists.dart';

class FilterByDateForm extends StatefulWidget {
  const FilterByDateForm({Key? key}) : super(key: key);

  @override
  _FilterByDateFormState createState() => _FilterByDateFormState();
}

class _FilterByDateFormState extends State<FilterByDateForm> {
  final _filterFormKey = GlobalKey<FormState>();
  // TextEditingController _businessName = TextEditingController();
  String? _day;
  String? _month;
  String? _year;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      child: Form(
        key: _filterFormKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'DD'),
                  items: FilterData().dayList(),
                  validator: (val) =>
                      val == null ? 'DD?' : null,
                  onChanged: (val) => setState(() {
                    _day = val as String?;
                  }),
                ),), 
        Container(
          width: MediaQuery.of(context).size.width * 0.20, 
          child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'MM'),
                  items: FilterData().monthList(),
                  validator: (val) =>
                      val == null ? 'MM?' : null,
                  onChanged: (val) => setState(() {
                    _month = val as String?;
                  }),
                ),), 
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'YYYY'),
                  items: FilterData().yearList(),
                  validator: (val) =>
                      val == null ? 'YYYY?' : null,
                  onChanged: (val) => setState(() {
                    _year = val as String?;
                  }),
                ),), 
      ],)),
    );
  }
}
