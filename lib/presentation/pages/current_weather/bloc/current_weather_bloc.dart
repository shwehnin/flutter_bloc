import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/current_weather_model.dart';
import 'package:my_app/data/repository/current_weather_repository.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final CurrentWeatherRepository currentWeatherRepository;
  CurrentWeatherBloc(this.currentWeatherRepository)
      : super(CurrentWeatherInitial()) {
    on<CurrentWeatherFetched>(_getCurrentWeather);
  }

  void _getCurrentWeather(
      CurrentWeatherFetched event, Emitter<CurrentWeatherState> emit) async {
    emit(CurrentWeatherLoading());
    try {
      final currentWeather = await currentWeatherRepository.getCurrentWeather();
      print("Current Weather $currentWeather");
      emit(CurrentWeatherSuccess(currentWeatherModel: currentWeather));
    } catch (e) {
      emit(CurrentWeatherFailure(e.toString()));
    }
  }
}
