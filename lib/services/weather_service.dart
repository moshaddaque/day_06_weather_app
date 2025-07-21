import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../utils/api_key.dart';

class WeatherService {
  // OpenWeatherMap API Key from ApiKey class
  static const String apiKey = ApiKey.openWeatherMapKey;
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // Get current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // Fetch weather data from OpenWeatherMap API
  Future<WeatherModel> getWeatherData() async {
    try {
      // Get current location
      final position = await getCurrentLocation();

      // Build API URL with location coordinates
      final url = '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';

      // Make API request
      final response = await http.get(Uri.parse(url));

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}