import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String secili = 'Work';
  DateTime? _startDate;
  DateTime? _endDate;
  final Dio _dio = Dio();
  final String _apiUrl = 'https://sheetdb.io/api/v1/2at9cnjmppcu6';
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); 

  IconData _getIcon(String value) {
    switch (value) {
      case 'Work':
        return Icons.work;
      case 'Personal':
        return Icons.person;
      case 'Daily':
        return Icons.calendar_today;
      case 'Other':
        return Icons.category;
      default:
        return Icons.task;
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _submitData() async {
    try {
      await _dio.post(_apiUrl, data: {
        'taskgroup': secili,
        'projectname': _projectNameController.text,
        'description': _descriptionController.text,
        'startdate': _startDate != null
            ? "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}"
            : '',
        'enddate': _endDate != null
            ? "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}"
            : '',
        'email': _emailController.text, 
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Project added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add project')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Project",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: secili,
                  onChanged: (String? yeniSecim) {
                    setState(() {
                      secili = yeniSecim!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Work',
                      child: Row(
                        children: [
                          Icon(Icons.work, color: Colors.purple[800]),
                          SizedBox(width: 8),
                          Text('Work'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Personal',
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.purple[800]),
                          SizedBox(width: 8),
                          Text('Personal'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Daily',
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.purple[800]),
                          SizedBox(width: 8),
                          Text('Daily'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Row(
                        children: [
                          Icon(Icons.category, color: Colors.purple[800]),
                          SizedBox(width: 8),
                          Text('Other'),
                        ],
                      ),
                    ),
                  ],
                  icon: Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
                  isExpanded: true,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return [
                      'Work',
                      'Personal',
                      'Daily',
                      'Other'
                    ].map((String value) {
                      return Row(
                        children: [
                          Icon(_getIcon(value), color: Colors.purple[800]),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Task Group",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(value),
                            ],
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _projectNameController,
              decoration: InputDecoration(
                labelText: 'Project Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple[800]!),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.purple[800]!),
                    ),
                    suffixIcon: Icon(Icons.calendar_today, color: Colors.purple[800]),
                  ),
                  controller: TextEditingController(
                    text: _startDate != null
                        ? "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}"
                        : '',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context, false),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.purple[800]!),
                    ),
                    suffixIcon: Icon(Icons.calendar_today, color: Colors.purple[800]),
                  ),
                  controller: TextEditingController(
                    text: _endDate != null
                        ? "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}"
                        : '',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  "Add Project",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: AddPage(),
  theme: ThemeData(
    primarySwatch: Colors.purple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple[800],
      ),
    ),
  ),
));
