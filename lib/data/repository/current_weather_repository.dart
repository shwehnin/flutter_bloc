import 'dart:convert';
import 'package:my_app/models/current_weather_model.dart';
import 'package:my_app/data/data_provider/current_weather_data_provider.dart';

class CurrentWeatherRepository {
  final CurrentWeatherDataProvider currentWeatherDataProvider;
  CurrentWeatherRepository(this.currentWeatherDataProvider);

  Future<CurrentWeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'Yangon';
      final currentWeatherData =
          await currentWeatherDataProvider.getCurrentWeatherData(cityName);
      final data = jsonDecode(currentWeatherData);
      print("Current weather data: $data");
      if (data['cod'] != 200) {
        throw 'An expected error occured';
      }
      return CurrentWeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
