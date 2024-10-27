import 'package:flutter/material.dart';
import 'package:todo_app/utils/styles.dart';
import '../helper/repositary.dart';
import '../widgets/quote_card.dart';
import '../widgets/todo_form.dart';
import 'navigation_bar.dart';
import 'package:todo_app/services/dataservice.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:intl/intl.dart';

enum Category { all, work, personal, birthday }

enum Priority { high, medium, low }

String getFormattedDate() {
  return DateFormat('MMMM d, y').format(DateTime.now());
}

String getGreetingMessage() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return "Good Morning";
  } else if (hour < 17) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> quoteList;
  const HomePage({super.key, required this.quoteList});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Category _selectedCategory = Category.all;
  Priority _priority = Priority.high;
  var repository = Repository();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final bool _isDescriptionVisible = false;
  var dataService = DataService();
  late List<TodoModel> todoList = [];

  _getAllTodos() async {
    todoList.clear();
    final List<Map<String, dynamic>> addedTodos =
        await dataService.readAllData();
    setState(() {
      if (addedTodos.isNotEmpty) {
        for (var addedTodo in addedTodos) {
          final todos = TodoModel.fromMap(addedTodo);
          todoList.add(todos);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllTodos();
  }

  @override
  void dispose() {
    // Dispose the controllers when not needed
    title.dispose();
    description.dispose();
    title.dispose();
    super.dispose();
  }

  void _saveTodo() async {
    final newTodo = TodoModel(
      title: title.text,
      description: description.text,
      priority: _priority.toString(),
      category: _selectedCategory.toString(),
      createdAt: DateTime.now(),
    );
    final isSaved = await dataService.saveTodo(newTodo);

    if (isSaved is int) {
      if (mounted) {
        setState(() {
          title.clear();
          description.clear();
          todoList.clear();
          _getAllTodos();
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todo added successfully!')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add todo. Try again!')),
        );
      }
    }
  }

  // Show the modal to add new todo
  void _showAddTodoModal() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: TodoForm(
              titleController: title,
              descriptionController: description,
              selectedCategory: _selectedCategory,
              selectedPriority: _priority,
              onCategoryChanged: (Category? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              onPriorityChanged: (Priority? newValue) {
                setState(() {
                  _priority = newValue!;
                });
              },
              onSave: _saveTodo,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(getGreetingMessage(), style: AppStyles.headerText),
              const SizedBox(height: 4),
              Text(
                getFormattedDate(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                );
              },
            ),
          ]),
      body: SafeArea(
        child: Column(
          children: [
            QuoteCard(
              quote: widget.quoteList[0]['quote'],
              author: widget.quoteList[0]['author'],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  0,
                  16.0,
                  kBottomNavigationBarHeight + 19,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: todoList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: SizedBox(
                          height: 85,
                          child: ListTile(
                            title: Row(
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                    shape: const CircleBorder(),
                                    activeColor: Colors.blue,
                                    value: todoList[index].isCompleted ==
                                        1, // Direct comparison to simplify
                                    onChanged: (bool? value) {
                                      setState(() {
                                        final int isCompleted = value! ? 1 : 0;
                                        repository.updateCompletion(
                                            todoList[index].id!.toInt(),
                                            isCompleted);
                                        _getAllTodos();
                                      });
                                    },
                                  ),
                                ),
                              const SizedBox(width: 17,),
                                Text(todoList[index].title ?? '',style: AppStyles.todoTitle,),
                              ],
                            ),
                            subtitle: todoList[index].description != null &&
                                    todoList[index].description!.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 65.0),
                                    child: Text(
                                      todoList[index].description!,
                                      style: AppStyles.subTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow
                                          .ellipsis, // Adds "..." at the end if it overflows
                                    ),
                                  )
                                : null,
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[300],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton(
          onPressed: _showAddTodoModal, // Show the Add Todo modal
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: const TodoBottomNavBar(),
    );
  }
}
