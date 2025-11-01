import 'package:flutter_bloc/flutter_bloc.dart';

class RadiusCubit extends Cubit<double> {
  RadiusCubit() : super(100); // default size

  void update(double value) => emit(value);
}
