import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_model.dart';
import '../utils/theme_colors.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final VoidCallback onRefresh;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = ThemeColors.getTextColor(
      ThemeColors.getGradientByCondition(weather.weatherCondition),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        // color: ThemeColors.getCardColor(
        //   ThemeColors.getGradientByCondition(weather.weatherCondition),
        // ),
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30.0,
            spreadRadius: 5.0,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.0),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // City Name with Animation
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: Opacity(opacity: value, child: child),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      weather.cityName,
                      style: GoogleFonts.poppins(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh, color: textColor),
                      onPressed: onRefresh,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8.0),

              // Date and Time
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                child: Text(
                  '${weather.formattedDate} | ${weather.formattedTime}',
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
              ),

              const SizedBox(height: 32.0),

              // Temperature and Weather Condition with Animation
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weather.temperature.round()}',
                              style: GoogleFonts.montserrat(
                                fontSize: 80.0,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                                height: 0.9,
                              ),
                            ),
                            Text(
                              '°C',
                              style: GoogleFonts.montserrat(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w600,
                                color: textColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        // Weather Condition with Animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(opacity: value, child: child);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: textColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              weather.weatherCondition,
                              style: GoogleFonts.montserrat(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Weather Icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: textColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: _buildWeatherIcon(
                        weather.weatherCondition,
                        textColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32.0),

              const SizedBox(height: 40.0),

              // Divider
              Container(
                height: 1.5,
                width: double.infinity,
                color: textColor.withOpacity(0.1),
              ),
              const SizedBox(height: 24.0),

              // Additional Weather Details
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDetailItem(
                      Icons.thermostat_outlined,
                      'Feels Like',
                      '${weather.feelsLike.round()}°C',
                      textColor,
                    ),
                    Container(
                      height: 50,
                      width: 1.5,
                      color: textColor.withOpacity(0.1),
                    ),
                    _buildDetailItem(
                      Icons.water_drop_outlined,
                      'Humidity',
                      '${weather.humidity}%',
                      textColor,
                    ),
                    Container(
                      height: 50,
                      width: 1.5,
                      color: textColor.withOpacity(0.1),
                    ),
                    _buildDetailItem(
                      Icons.air_outlined,
                      'Wind',
                      '${weather.windSpeed} m/s',
                      textColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value,
    Color textColor,
  ) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Icon(icon, color: textColor, size: 24.0),
        ),
        const SizedBox(height: 10.0),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: textColor.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherIcon(String condition, Color color) {
    IconData iconData;

    switch (condition.toLowerCase()) {
      case 'clear':
        iconData = Icons.wb_sunny_rounded;
        break;
      case 'rain':
      case 'drizzle':
        iconData = Icons.grain_rounded;
        break;
      case 'clouds':
        iconData = Icons.cloud_rounded;
        break;
      case 'thunderstorm':
        iconData = Icons.flash_on_rounded;
        break;
      case 'snow':
        iconData = Icons.ac_unit_rounded;
        break;
      default:
        iconData = Icons.cloud_rounded;
    }

    return Center(child: Icon(iconData, color: color, size: 60.0));
  }
}
