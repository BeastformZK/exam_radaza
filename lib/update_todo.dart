import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;

  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController useridController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: useridController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a something';
                }
                return null;
              },
              decoration: (const InputDecoration(hintText: 'User ID')),
              keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: titleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: (const InputDecoration(hintText: 'Title')),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(updateData());
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final userId = useridController;
    const iD = '_id';
    final title = titleController;
    final body = {'User ID': userId, 'ID': iD, 'Title': title};
    const url = 'https://jsonplaceholder.typicode.com/posts/$iD';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode == 204) {
      showSuccessMessage('Update Successful');
    } else {
      showErrorMessage('Update Failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
