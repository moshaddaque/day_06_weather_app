import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_model.dart';
import '../utils/theme_colors.dart';

class AnimatedBackground extends StatelessWidget {
  final WeatherModel weather;
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.weather,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: ThemeColors.getGradientByCondition(
                weather.weatherCondition,
              ),
            ),
          ),
        ),

        // Pattern Overlay
        Positioned.fill(
          child: Opacity(
            opacity: 0.05,
            child: Image.network(
              'https://www.transparenttextures.com/patterns/cubes.png',
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),

        // Weather Animation
        Positioned.fill(
          child: Opacity(
            opacity: 0.6, // Semi-transparent animation
            child: _buildWeatherAnimation(),
          ),
        ),

        // Content
        child,
      ],
    );
  }

  Widget _buildWeatherAnimation() {
    switch (weather.weatherCondition.toLowerCase()) {
      case 'clear':
        return _buildSunnyAnimation();
      case 'rain':
      case 'drizzle':
        return _buildRainyAnimation();
      case 'clouds':
        return _buildCloudyAnimation();
      case 'thunderstorm':
        return _buildThunderstormAnimation();
      case 'snow':
        return _buildSnowAnimation();
      default:
        return _buildCloudyAnimation();
    }
  }

  Widget _buildSunnyAnimation() {
    return Lottie.asset('assets/animations/sunny.json', fit: BoxFit.cover);
  }

  Widget _buildRainyAnimation() {
    return Lottie.asset('assets/animations/rainy.json', fit: BoxFit.cover);
  }

  Widget _buildCloudyAnimation() {
    return Lottie.asset('assets/animations/cloudy.json', fit: BoxFit.cover);
  }

  Widget _buildThunderstormAnimation() {
    return Lottie.asset('assets/animations/thunder.json', fit: BoxFit.cover);
  }

  Widget _buildSnowAnimation() {
    return Lottie.asset('assets/animations/snow.json', fit: BoxFit.cover);
  }
}
