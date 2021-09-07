import 'package:flutter/material.dart';
import 'package:untitled7/Instuments/data_.dart';
import 'package:untitled7/models/task.dart';
import 'package:untitled7/models/todo.dart';
import 'package:untitled7/Instuments/widgets.dart';

class TaskView extends StatefulWidget {
  final Task task;

  TaskView({@required this.task});

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> with SingleTickerProviderStateMixin {
  DatabaseUsage _dbHelper = DatabaseUsage();
  FocusNode _focusNode = FocusNode();

  bool _fromHome = false;
  int _color = 0;
  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisible = false;
  bool changed = false;

  @override
  void initState() {
    if (widget.task != null) {
      // проверка на существование таска, а так же здесь прилажка понимает, что это вход с хоума
      _contentVisible = true;
      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
      _fromHome = true;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mya() {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: Center(
                child: Text('Задача обновлена'),
              ),
            );
          });
    }

    checkMya() {
      if (changed == true) {
        _mya();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: new InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Container(
            color: Color(0xFFFFFFFF),
            child: ScrollConfiguration(
              behavior: NoGlowBehaviour(),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          checkMya();
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Visibility(
                                visible: _contentVisible == false || _fromHome == true,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 64.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Color(0xFF7F807F), Color(0xFF27783D)],
                                          begin: Alignment(0.0, -1.0),
                                          end: Alignment(0.0, 1000.0)),
                                      borderRadius: BorderRadius.circular(90.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(130, 153, 153, 153),
                                        )
                                      ]),
                                  child: Center(
                                    child: Text(
                                      "Вернуться назад",
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _contentVisible == true && _fromHome != true,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 64.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Color(0xFF4ABD70), Color(0xFF27783D)],
                                          begin: Alignment(0.0, -1.0),
                                          end: Alignment(0.0, 1000.0)),
                                      borderRadius: BorderRadius.circular(90.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(130, 116, 239, 157),
                                        )
                                      ]),
                                  child: Center(
                                    child: Text(
                                      "Готово!",
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ])),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                        ),
                        height: MediaQuery.of(context).size.height / 14,
                        width: MediaQuery.of(context).size.width,
                        child: new TextField(
                          focusNode: _titleFocus,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                          ),
                          onSubmitted: (value) async {
                            // Check if the field is not empty
                            if (value != "") {
                              // Check if the task is null
                              if (_taskTitle == "") {
                                Task _newTask = Task(title: value);
                                _taskId = await _dbHelper.insertTask(_newTask);
                                setState(() {
                                  _contentVisible = true;
                                  _taskTitle = value;
                                });
                              } else {
                                await _dbHelper.updateTaskTitle(_taskId, value);
                                print("Задача обновлена!");
                                if (_fromHome == true) {
                                  changed = true;
                                }
                                _taskTitle = value;
                              }
                              //_descriptionFocus.requestFocus();
                            }
                          },
                          controller: TextEditingController()..text = _taskTitle,
                          decoration: InputDecoration(
                            fillColor: Color(0xFFFFEEDA),
                            filled: true,
                            hintText: "Создайте новую задачу...",
                            hintStyle: TextStyle(
                              color: Color(0x57866E4C),
                              fontSize: 20.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x57866E4C),
                              ),
                              borderRadius: BorderRadius.circular(29.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF000000),
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _contentVisible,
                        child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFF393939),
                                ),
                                focusNode: _descriptionFocus,
                                onChanged: (value) async {
                                  if (value != "") {
                                    if (_taskId != 0) {
                                      await _dbHelper.updateTaskDescription(_taskId, value);
                                      _taskDescription = value;
                                      if (_fromHome == true) {
                                        changed = true;
                                      }
                                    }
                                  }
                                  //_todoFocus.requestFocus();
                                },
                                controller: TextEditingController()..text = _taskDescription,
                                decoration: InputDecoration(
                                  hintText: "Добавьте описание...",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                ),
                              ),
                            ])),
                      ),
                      FutureBuilder(
                        initialData: [],
                        future: _dbHelper.getTodo(_taskId),
                        builder: (context, snapshot) {
                          return Container(
                            child: new Container(
                              height: MediaQuery.of(context).size.height / 2.41,
                              width: MediaQuery.of(context).size.width / 1.01,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color(0xFFFFFDFA),
                              ),
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (snapshot.data[index].isDone == 0) {
                                        await _dbHelper.updateTodoDone(snapshot.data[index].id, 1);
                                      } else {
                                        await _dbHelper.updateTodoDone(snapshot.data[index].id, 0);
                                      }
                                      setState(() {});
                                    },
                                    child: CheckWidget(
                                      text: snapshot.data[index].title,
                                      isDone: snapshot.data[index].isDone == 0 ? false : true,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: TextField(
                                    focusNode: _focusNode,
                                    controller: TextEditingController()..text = "",
                                    onSubmitted: (value) async {
                                      // Check if the field is not empty
                                      if (value != "") {
                                        if (_taskId != 0) {
                                          DatabaseUsage _dbHelper = DatabaseUsage();
                                          Check _newTodo = Check(
                                            title: value,
                                            isDone: 0,
                                            taskId: _taskId,
                                          );
                                          await _dbHelper.insertTodo(_newTodo);
                                          setState(() {});
                                          if (_fromHome == true) {
                                            changed = true;
                                          }
                                          //_todoFocus.requestFocus();
                                        } else {
                                          print("Задача не существует");
                                        }
                                      }
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Color(0xFFFAF6EF),
                                      filled: true,
                                      hintText: "Добавьте пункт...",
                                      hintStyle: TextStyle(
                                        color: Color(0x57866E4C),
                                        fontSize: 20.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x57866E4C),
                                        ),
                                        borderRadius: BorderRadius.circular(29.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF000000),
                                        ),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      isDense: true,
                                    ),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000000),
                                    )),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Visibility(
                                  visible: _fromHome == false,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF9C9C9C)),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    height: 60,
                                    width: MediaQuery.of(context).size.width / 1.058,
                                    child: Center(
                                      child: Text(
                                        "В разработке :О",
                                        style: TextStyle(
                                          color: Color(0xFF9C9C9C),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )),
                              Visibility(
                                visible: _fromHome == true,
                                child: SizedBox(
                                  height: 64,
                                  child: Image(
                                    image: AssetImage('assets/images/logo.png'), // ядро приложения
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).viewInsets.bottom,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: _contentVisible && _fromHome == false,
                      child: Column(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              if (_taskId != 0) {
                                await _dbHelper.deleteTask(_taskId);
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.058,
                              height: 64.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFC94545),
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Удалить задачу",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
                  Visibility(
                      visible: _contentVisible && _fromHome == true,
                      child: Column(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              if (_taskId != 0) {
                                await _dbHelper.deleteTask(_taskId);
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.058,
                              height: 64.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF4ABD70),
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Завершить задачу",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          //Buttons
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
