import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<dynamic> todoList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTodoList().then((data) {
      setState(() {
        todoList = data;
      });
    }).catchError((error) {
      // Handle error here
      print('Error: $error');
    });
  }

  Future<List<dynamic>> fetchTodoList() async {
    try {
      final response =
          await http.get(Uri.https('jsonplaceholder.typicode.com', '/todos'));

      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON response
        final List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        // If there is an error, throw an exception
        throw Exception('Failed to fetch todo list');
      }
    } catch (error) {
      throw Exception('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Todo List',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: todoList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Give it another try',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        fetchTodoList().then((data) {
                          setState(() {
                            todoList = data;
                            isLoading = false;
                          });
                        }).catchError((error) {
                          // Handle error here
                          print('Error: $error');
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: const Text('RELOAD',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  final todo = todoList[
                      index]; // Replace 'todoList' with your actual list of todos

                  return Card(
                    child: ListTile(
                      title: Text(todo['title']),
                      subtitle: Text(
                          todo['completed'] ? 'Completed' : 'Not Completed'),
                    ),
                  );
                },
              ),
      );
    }
  }
}
