import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/weather_model.dart';
import 'package:my_app/data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherEvent>(_getCurrentWeather);
  }

  void _getCurrentWeather(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather();
      emit(
        WeatherSuccess(weatherModel: weather),
      );
    } catch (e) {
      emit(
        WeatherFailure(
          e.toString(),
        ),
      );
    }
  }
}
