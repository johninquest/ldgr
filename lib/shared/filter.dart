import 'package:flutter/material.dart';
import 'package:ldgr/shared/lists.dart';

class FilterByDateForm extends StatefulWidget {
  const FilterByDateForm({Key? key}) : super(key: key);

  @override
  _FilterByDateFormState createState() => _FilterByDateFormState();
}

class _FilterByDateFormState extends State<FilterByDateForm> {
  final _filterFormKey = GlobalKey<FormState>();
  // TextEditingController _businessName = TextEditingController();
  int? _day;
  int? _month;
  int? _year;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _filterFormKey,
      child: Form(child: Row(children: [
        Container(child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Cost area'),
                  items: MyItemList().costAreaList,
                  validator: (val) =>
                      val == null ? 'Day?' : null,
                  onChanged: (val) => setState(() {
                    _day = val as int?;
                  }),
                ),), 
        Container(), 
        Container()
      ],)),
    );
  }
}
