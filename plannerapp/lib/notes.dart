import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<String> notes = [];  
  TextEditingController _noteController = TextEditingController();

  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Write your note here'),
          content: TextField(
            controller: _noteController,
            decoration: InputDecoration(hintText: "Enter your note"),
          ),
          actions: [
            TextButton(
              onPressed: () {
               
                if (_noteController.text.isNotEmpty) {
                  setState(() {
                    notes.add(_noteController.text);
                  });
                }
                _noteController.clear(); 
                Navigator.of(context).pop(); 
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        title: Text('Notes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add your notes in this page',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            Container(
              width: double.infinity,
              child: Card(
                color: Color.fromARGB(255, 249, 220, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alışveriş Listesi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '- Süt\n- Ekmek\n- Yumurta\n- Kahve',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color.fromARGB(255, 249, 220, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        notes[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,  
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.purple[800],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: NotePage()));
