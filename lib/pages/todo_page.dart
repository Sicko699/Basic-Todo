import 'package:flutter/material.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class ToDo{
  String title;
  String description;
  bool isDone = false;

  ToDo({
    required this.title,
    required this.description,
    this.isDone = false,
  });
}

class _ToDoAppState extends State<ToDoApp> {

  // Creo una lista di ToDo
  List<ToDo> todos = [];

  // Metodo per aggiungere un ToDo
  void addTodo(String title, String description) {
  String title = '';
  String description = '';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.yellow[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Nuovo ToDo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Titolo'),
              onChanged: (value) => title = value,
              autofocus: true,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Descrizione'),
              onChanged: (value) => description = value,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Aggiungi ToDo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    todos.add(ToDo(title: title, description: description));
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}


  // Metodo per rimuovere un ToDo
  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleToDo(int index) {
  setState(() {
    todos[index].isDone = !todos[index].isDone;
  });
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.yellow[50],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      todos[index].title,
                      style: TextStyle(
                        decoration: todos[index].isDone
                            ? TextDecoration.lineThrough    // Se completato: sbarrato
                            : TextDecoration.none,          // Se non completato: normale
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(todos[index].description),
                    leading: IconButton(
                      icon: Icon(
                        todos[index].isDone
                          ? Icons.check_box   // checked
                          : Icons.check_box_outline_blank, // unchecked
                        color: Colors.amber,
                      ),
                      onPressed: () => toggleToDo(index),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.amber, width: 1),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeTodo(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16), // Distanzia il bottone dal bordo inferiore
          height: 90,
          width: double.infinity,
          color: Colors.yellow[200],
          child: SizedBox(
            width: 160,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Aggiungi ToDo"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                elevation: 5,
              ),
              onPressed: () => addTodo('', ''),
            ),
          ),
        ),
        ],
      ),
      backgroundColor: Colors.yellow[200],
    );
  }
}