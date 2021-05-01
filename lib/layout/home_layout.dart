import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/modules/archived/Archived_screen.dart';
import 'package:first_flutter_app/modules/done/done_screen.dart';
import 'package:first_flutter_app/modules/tasks/new_tasks_screen.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

/*to create database in sqflite
* 1. database created
* 2. table created
* 3. database opened
*
* 4. insert to database
* 5. get from database
* 6. update into database
* 7. delete from database
* */

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screen = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> title = [
    'New Task',
    'Done Task',
    'Archived Task',
  ];

  Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData defaultIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  void initState() {
    super.initState();

    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          title[currentIndex],
        ),
      ),
      body: ConditionalBuilder(
        condition: tasks.length > 0 ,
        builder: (context)=> screen[currentIndex],
        fallback: (context)=> Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState.validate()) {
              insertToDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
              ).then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  setState(() {
                    isBottomSheetShown = false;
                    defaultIcon = Icons.edit;
                    tasks = value;
                  });
                });
              });
            }
          } else {
            scaffoldKey.currentState
                .showBottomSheet(
                  (context) => Container(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultTextField(
                            label: 'Task Title',
                            controller: titleController,
                            preFix: Icons.title,
                            textInputType: TextInputType.text,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'title must not be Empty !';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultTextField(
                            label: 'Task Time',
                            controller: timeController,
                            preFix: Icons.watch_later_outlined,
                            textInputType: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) => timeController.text =
                                  value.format(context).toString());
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Time must not be Empty !';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultTextField(
                            label: 'Task Date',
                            controller: dateController,
                            preFix: Icons.date_range,
                            textInputType: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2030-01-01'),
                              ).then((value) => dateController.text =
                                  DateFormat.yMMMd().format(value));
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Date must not be Empty !';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 20.0,
                )
                .closed
                .then((value) {
              isBottomSheetShown = false;
              setState(() {
                defaultIcon = Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              defaultIcon = Icons.add;
            });
          }
        },
        child: Icon(
          defaultIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase('todo.dp', version: 1,
        onCreate: (database, version) async {
      /*
          * id int
          * title String
          * date String
          * time String
          * status String
          */
      print('Database Created');
      await database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error whe creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        setState(() {
          tasks = value;
        });
      });
      print('Database Opened');
    });
  }

  Future insertToDatabase({
    @required String title,
    @required String date,
    @required String time,
  }) async {
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then(
            (value) => print('$value Insert Successfully'),
          )
          .catchError(
            (error) => print('Error whe Insert new Row  ${error.toString()}'),
          );
      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
