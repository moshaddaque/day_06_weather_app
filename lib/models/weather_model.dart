import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final String weatherIcon;
  final DateTime dateTime;
  final double windSpeed;
  final int humidity;
  final double feelsLike;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
    required this.weatherIcon,
    required this.dateTime,
    required this.windSpeed,
    required this.humidity,
    required this.feelsLike,
  });

  // Factory constructor to create a WeatherModel from JSON
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      weatherCondition: json['weather'][0]['main'] ?? 'Unknown',
      weatherIcon: json['weather'][0]['icon'] ?? '01d',
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
    );
  }

  // Get formatted date
  String get formattedDate {
    return DateFormat('EEEE, d MMMM').format(dateTime);
  }

  // Get formatted time
  String get formattedTime {
    return DateFormat('h:mm a').format(dateTime);
  }

  // Get weather animation asset based on condition
  String get weatherAnimation {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return 'assets/animations/sunny.json';
      case 'rain':
      case 'drizzle':
        return 'assets/animations/rainy.json';
      case 'clouds':
        return 'assets/animations/cloudy.json';
      case 'thunderstorm':
        return 'assets/animations/thunder.json';
      case 'snow':
        return 'assets/animations/snow.json';
      default:
        return 'assets/animations/cloudy.json';
    }
  }

  // Get background gradient colors based on weather condition
  List<Color> get backgroundColors {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return [const Color(0xFFFFD700), const Color(0xFFFFA500)];
      case 'rain':
      case 'drizzle':
        return [const Color(0xFF1A237E), const Color(0xFF0D47A1)];
      case 'clouds':
        return [const Color(0xFF90A4AE), const Color(0xFF607D8B)];
      case 'thunderstorm':
        return [const Color(0xFF4A148C), const Color(0xFF311B92)];
      case 'snow':
        return [const Color(0xFFE3F2FD), const Color(0xFFBBDEFB)];
      default:
        return [const Color(0xFF90A4AE), const Color(0xFF607D8B)];
    }
  }
}