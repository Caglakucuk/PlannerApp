import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  final String email;

  HomePage({required this.email});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _projects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      var response = await Dio().get('https://sheetdb.io/api/v1/2at9cnjmppcu6');
      if (response.statusCode == 200) {
        setState(() {
          _projects = response.data.where((project) => 
            project['email'] == widget.email && 
            project['projectname'] != null && 
            project['projectname'].toString().trim().isNotEmpty
          ).toList();
        });
      } else {
        print("API Hatası: ${response.statusCode}");
      }
    } catch (e) {
      print("Veri çekme hatası: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' All Projects'),
        backgroundColor: Colors.purple[200],
      ),
      body: _projects.isEmpty
        ? Center(child: Text('No projects available', style: TextStyle(fontSize: 18, color: Colors.grey)))
        : ListView.builder(
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              var project = _projects[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(
                    project['projectname'] ?? 'No Project Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        "Task Group: ${project['taskgroup'] ?? 'No Task Group'}",
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                      Text(
                        "Description: ${project['description'] ?? 'No Description'}",
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                      Text(
                        "Start Date: ${project['startdate'] ?? 'No Start Date'}",
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                      Text(
                        "End Date: ${project['enddate'] ?? 'No End Date'}",
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  onTap: () {
                  },
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Colors.purple[800],
        child: Icon(Icons.add, color: Colors.white),
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
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.purple[800]),
                onPressed: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
