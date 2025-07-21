import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

enum WeatherStatus { loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  
  WeatherModel? _weatherData;
  WeatherStatus _status = WeatherStatus.loading;
  String _errorMessage = '';

  // Getters
  WeatherModel? get weatherData => _weatherData;
  WeatherStatus get status => _status;
  String get errorMessage => _errorMessage;

  // Constructor - fetch weather data when provider is initialized
  WeatherProvider() {
    fetchWeatherData();
  }

  // Fetch weather data from service
  Future<void> fetchWeatherData() async {
    try {
      _status = WeatherStatus.loading;
      notifyListeners();
      
      _weatherData = await _weatherService.getWeatherData();
      _status = WeatherStatus.loaded;
    } catch (e) {
      _status = WeatherStatus.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  // Refresh weather data
  Future<void> refreshWeather() async {
    await fetchWeatherData();
  }
}