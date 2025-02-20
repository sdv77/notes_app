import 'package:flutter/material.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заметки',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Контроллер для управления текстовым полем
  TextEditingController _textController = TextEditingController();

  // Список для хранения заметок
  List<String> notes = [];

  // Метод для добавления заметки
  void _addNote() {
    setState(() {
      // Добавляем текст из текстового поля в список заметок
      notes.add(_textController.text);
      // Очищаем текстовое поле после добавления
      _textController.clear();
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
            // Поле для ввода текста
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Введите заметку',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Кнопка для добавления заметки
            ElevatedButton(
              onPressed: _addNote,
              child: Text('Сохранить'),
            ),
            SizedBox(height: 16.0),
            // Список заметок
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}