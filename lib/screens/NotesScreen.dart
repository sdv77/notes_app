import 'package:flutter/material.dart';
import 'EditNoteScreen.dart';
import 'NoteDetailScreen.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController _textController = TextEditingController();

  List<String> notes = [];

  void _addNote() {
    setState(() {
      notes.add(_textController.text);
      _textController.clear();
    });
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _navigateToEditScreen(int index) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: notes[index]),
      ),
    );

    if (updatedNote != null) {
      setState(() {
        notes[index] = updatedNote;
      });
    }
  }

  void _navigateToDetailScreen(int index) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(Duration(seconds: 1));

    Navigator.pop(context);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailScreen(note: notes[index]),
      ),
    );
  }

  void _reorderNotes(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final note = notes.removeAt(oldIndex);
      notes.insert(newIndex, note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои заметки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Введите заметку',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addNote,
              child: Text('Сохранить'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    key: Key('$index'),
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text(notes[index]),
                      onTap: () => _navigateToDetailScreen(index),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _navigateToEditScreen(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteNote(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                onReorder: _reorderNotes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}