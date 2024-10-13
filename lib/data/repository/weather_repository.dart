import 'dart:convert';
import 'package:my_app/models/weather_model.dart';
import 'package:my_app/data/data_provider/weather_data_provider.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'Yangon';
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);
      final data = jsonDecode(weatherData);
      if (data['cod'] != '200') {
        throw 'An expected error occured';
      }
      // return WeatherModel.fromJson(weatherData);
      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
