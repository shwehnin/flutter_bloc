import 'package:http/http.dart' as http;
import 'package:my_app/utils/helper.dart';

class WeatherDataProvider {
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final res = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$openWeatherAPIKey"),
      );
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
