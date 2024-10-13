import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/widgets/additional_info_item.dart';
import 'package:my_app/presentation/pages/current_weather/bloc/current_weather_bloc.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({super.key});

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CurrentWeatherBloc>().add(CurrentWeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Current Weather",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          builder: (context, state) {
            if (state is! CurrentWeatherSuccess) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CurrentWeatherFailure) {
              return const Text("Data is not available");
            }

            final data = state.currentWeatherModel;
            final currentTemp = data.currentTemp;
            final currentSky = data.currentSky;
            final currentPressure = data.currentPressure;
            final currentWindSpeed = data.currentWindSpeed;
            final currentHumidity = data.currentHumidity;

            return Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          currentTemp.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Icon(
                          Icons.cloud,
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentSky.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Hourly Rate",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: currentHumidity.toString()),
                    AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Pressure',
                        value: currentPressure.toString()),
                    AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Wind Speed',
                        value: currentWindSpeed.toString()),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
