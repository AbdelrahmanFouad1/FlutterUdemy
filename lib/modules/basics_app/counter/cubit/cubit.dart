import 'package:bloc/bloc.dart';
import 'package:first_flutter_app/modules/basics_app/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit() : super(CounterInitialState());

  CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void min(){
    counter -- ;
    emit(CounterMinState(counter));
  }
  void plus(){
    counter ++ ;
    emit(CounterPlusState(counter));
  }
}