import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:plannerapp/addpage.dart';
import 'package:plannerapp/homepage.dart';
import 'package:plannerapp/notes.dart';
import 'package:plannerapp/profilepage.dart';

class SecondPage extends StatefulWidget {
  final String email;

  SecondPage({required this.email});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _selectedIndex = 2;
  List<dynamic> _tasks = [];
  List<dynamic> _filteredTasks = [];
  List<dynamic> _completedTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      var response = await Dio().get('https://sheetdb.io/api/v1/2at9cnjmppcu6');
      if (response.statusCode == 200) {
        setState(() {
          _tasks = response.data;
          _filterTasks();
        });
      } else {
        print("API Hatası: ${response.statusCode}");
      }
    } catch (e) {
      print("Veri çekme hatası: $e");
    }
  }

  void _filterTasks() {
    DateTime selectedDate = DateTime.now().add(Duration(days: _selectedIndex - 2));
    setState(() {
      _filteredTasks = _tasks.where((task) {
        DateTime? startDate;
        try {
          startDate = DateFormat('dd/MM/yyyy').parse(task['startdate']);
        } catch (e) {
          print("Tarih parse hatası: $e, Gelen tarih: ${task['startdate']}");
          return false;
        }
        return task['email'] == widget.email &&
            startDate.year == selectedDate.year &&
            startDate.month == selectedDate.month &&
            startDate.day == selectedDate.day &&
            task['projectname'] != null; 
      }).toList();
    });
  }

  void _toggleTaskCompletion(dynamic task) {
    setState(() {
      if (_completedTasks.contains(task)) {
        _completedTasks.remove(task);
        _filteredTasks.add(task);
      } else {
        _filteredTasks.remove(task);
        _completedTasks.add(task);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Today's Tasks",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.purple[200],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                DateTime date = DateTime.now().add(Duration(days: index - 2));
                bool isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      _filterTasks(); 
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.purple[800] : Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: isSelected
                          ? [BoxShadow(color: Colors.purple[600]!, blurRadius: 10, spreadRadius: 2)]
                          : [],
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('MMMM').format(date),
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "${date.day}",
                          style: TextStyle(
                            fontSize: 20,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        Text(
                          _getWeekdayName(date.weekday),
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                var task = _filteredTasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.task, color: Colors.purple[800]),
                    title: Text(
                      task['taskgroup'] ?? 'No Task Group',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Project: ${task['projectname'] ?? 'No Project Name'}"),
                        Text("Description: ${task['description'] ?? 'No Description'}"),
                        Text("End Date: ${task['enddate'] ?? 'No End Date'}"),
                      ],
                    ),
                    trailing: Checkbox(
                      value: _completedTasks.contains(task),
                      onChanged: (bool? value) {
                        _toggleTaskCompletion(task);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Completed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _completedTasks.length,
              itemBuilder: (context, index) {
                var task = _completedTasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.task, color: Colors.purple[800]),
                    title: Text(
                      task['taskgroup'] ?? 'No Task Group',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Project: ${task['projectname'] ?? 'No Project Name'}"),
                        Text("Description: ${task['description'] ?? 'No Description'}"),
                        Text("End Date: ${task['enddate'] ?? 'No End Date'}"),
                      ],
                    ),
                    trailing: Checkbox(
                      value: true, 
                      onChanged: (bool? value) {
                        _toggleTaskCompletion(task);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
        backgroundColor: Colors.purple[800],
        child: Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.purple[800]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(email: widget.email)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.purple[800]),
                onPressed: () {
                },
              ),
              SizedBox(width: 40),
              IconButton(
                icon: Icon(Icons.notes, color: Colors.purple[800]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotePage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.purple[800]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage(email: widget.email)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Pazartesi";
      case DateTime.tuesday:
        return "Salı";
      case DateTime.wednesday:
        return "Çarşamba";
      case DateTime.thursday:
        return "Perşembe";
      case DateTime.friday:
        return "Cuma";
      case DateTime.saturday:
        return "Cumartesi";
      case DateTime.sunday:
        return "Pazar";
      default:
        return "";
    }
  }
}

void main() => runApp(MaterialApp(home: SecondPage(email: 'test@example.com')));
