import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/modules/archived/Archived_screen.dart';
import 'package:first_flutter_app/modules/done/done_screen.dart';
import 'package:first_flutter_app/modules/tasks/new_tasks_screen.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/components/constants.dart';
import 'package:first_flutter_app/shared/cubit/cubit.dart';
import 'package:first_flutter_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

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

class HomeLayout extends StatelessWidget
{



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDatabaseLoadingState  ,
            builder: (context)=> cubit.screens[cubit.currentIndex],
            fallback: (context)=> Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print(cubit.newTasks);
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState.validate()) {
                  cubit.insertToDatabase(title: titleController.text, date: dateController.text, time: timeController.text);
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
                ).closed
                    .then((value) {
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
              }
            },
            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index) ;
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
        ); },

      ),
    );
  }


}




