import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final _weatherService = WeatherService('0a46a3c3967794796dcd1cbc5bd7ae8b');
  WeatherCondition? _weather;

  // Fetch weather
  _fetchWeather() async {
    try {
      // Get current city
      String cityName = await _weatherService.getCurrentCity();

      // Get weather for the city
      final weatherCondition = await _weatherService.getWeatherCondition(cityName);

      setState(() {
        _weather = weatherCondition;
      });
    } catch (e) {
      print(e);
    }
  }

  // Weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Asunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Acloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Arainny.json';
      case 'thunderstorm':
        return 'assets/Astorm.json';
      default:
        return 'assets/Asunny.json';
    }
  }

  // Init state
  @override
  void initState() {
    super.initState();
    // Fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return WeatherWidget(weatherCondition: _weather);
  }
}

class WeatherCondition {
  final String cityName;
  final double temperature;
  final String mainCondition;

  WeatherCondition({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  // Factory method to create WeatherCondition from JSON
  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  // Fetch weather condition for a specific city
  Future<WeatherCondition> getWeatherCondition(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return WeatherCondition.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Get the current city based on the device's location
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;
    return city ?? "";
  }
}

class WeatherWidget extends StatelessWidget {
  final WeatherCondition? weatherCondition;

  const WeatherWidget({Key? key, this.weatherCondition}) : super(key: key);

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Asunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Acloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Arainny.json';
      case 'thunderstorm':
        return 'assets/Astorm.json';
      default:
        return 'assets/Asunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Weather animation
          SizedBox(
            width: 100,
            child: Lottie.asset(getWeatherAnimation(weatherCondition?.mainCondition)),
          ),
          // City name
          Text(weatherCondition?.cityName ?? "Loading.."),
          // Temperature
          Text('${weatherCondition?.temperature.round()}°C'),
        ],
      ),
    );
  }
}
