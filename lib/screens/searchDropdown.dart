import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter/material.dart';

class SearchDropdownTest extends StatefulWidget {
  @override
  _SearchDropdownTestState createState() => _SearchDropdownTestState();
}

class _SearchDropdownTestState extends State<SearchDropdownTest> {
  String selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          child: SearchableDropdown.single(
            items: <String>[
              'Android',
              'IOS',
              'Flutter',
              'Node',
              'Java',
              'Python',
              'PHP',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: selectedValue,
            hint: "Android",
            searchHint: "Android",
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}
