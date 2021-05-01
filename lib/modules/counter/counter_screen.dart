import 'package:first_flutter_app/modules/counter/cubit/cubit.dart';
import 'package:first_flutter_app/modules/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (BuildContext context, state) {
          if(state is CounterMinState) print('Minus state ${state.counter}');
          if(state is CounterPlusState) print('plus state ${state.counter}');
        },
        builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Counter'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    CounterCubit().get(context).min();
                  },
                  child: Text(
                    'Min',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                  child: Text(
                    '${CounterCubit().get(context).counter}',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    CounterCubit().get(context).plus();
                  },
                  child: Text(
                    'Max',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}

