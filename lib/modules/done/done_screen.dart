import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/cubit/cubit.dart';
import 'package:first_flutter_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return tasksBuilder(
            tasks: tasks
        );
      },

    );
  }
}

