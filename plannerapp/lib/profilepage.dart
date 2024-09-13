import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    setState(() {
      _filteredTasks = _tasks.where((task) {
        return task['email'] == widget.email &&
            task['taskgroup'] != null && task['taskgroup'].isNotEmpty; 
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
    Map<String, List<dynamic>> taskGroups = {};

    for (var task in _filteredTasks) {
      final groupName = task['taskgroup'] ?? 'Unknown';
      if (!taskGroups.containsKey(groupName)) {
        taskGroups[groupName] = [];
      }
      taskGroups[groupName]!.add(task);
    }

    List<String> sortedGroupNames = taskGroups.keys.toList();
    sortedGroupNames.sort(); 
    if (sortedGroupNames.length > 4) {
      sortedGroupNames = sortedGroupNames.sublist(0, 4);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.only(bottom: 16.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Hoşgeldiniz ${widget.email}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('Task Groups', style: TextStyle(color: Colors.purple, fontStyle: FontStyle.italic, fontSize: 20 ),),
            Expanded(
              child: ListView(
                children: sortedGroupNames.map((groupName) {
                  List<dynamic> tasks = taskGroups[groupName] ?? [];

                  return ExpansionTile(
                    leading: Icon(Icons.category, color: Colors.purple[800]),
                    title: Text(
                      '$groupName (${tasks.length} tasks)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    children: tasks.map((task) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12.0),
                          title: Text(
                            task['projectname'] ?? 'No Project Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
