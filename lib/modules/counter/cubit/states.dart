abstract class CounterStates{}
class CounterInitialState extends CounterStates {
}
class CounterPlusState extends CounterStates {
  final counter;

  CounterPlusState(this.counter);

}
class CounterMinState extends CounterStates {
  final counter;

  CounterMinState(this.counter);
}