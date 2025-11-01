import 'package:flutter_bloc/flutter_bloc.dart';

class SumCubit extends Cubit<double> {
  SumCubit() : super(0);

  void add(double a, double b) {
    emit(a + b);
  }
}
