import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/animated_background.dart';
import '../widgets/weather_card.dart';
import '../utils/theme_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<WeatherProvider>(
            context,
            listen: false,
          ).refreshWeather();
        },
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            switch (weatherProvider.status) {
              case WeatherStatus.loading:
                return _buildLoadingState();
              case WeatherStatus.loaded:
                return _buildLoadedState(context, weatherProvider);
              case WeatherStatus.error:
                return _buildErrorState(context, weatherProvider);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: ThemeColors.getCloudyGradient(),
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          // decoration: BoxDecoration(
          //   color: Colors.white.withOpacity(0.15),
          //   borderRadius: BorderRadius.circular(28.0),
          //   border: Border.all(
          //     color: Colors.white.withOpacity(0.2),
          //     width: 1.5,
          //   ),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.1),
          //       blurRadius: 30.0,
          //       spreadRadius: 5.0,
          //     ),
          //   ],
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitPulse(color: Colors.white, size: 80.0),
              const SizedBox(height: 30.0),
              Text(
                'Fetching Weather Data...',
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    WeatherProvider weatherProvider,
  ) {
    final weather = weatherProvider.weatherData!;
    final textColor = ThemeColors.getTextColor(
      ThemeColors.getGradientByCondition(weather.weatherCondition),
    );

    return AnimatedBackground(
      weather: weather,
      child: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 40.0),
            // App Title and Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(opacity: value, child: child);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weather',
                          style: GoogleFonts.montserrat(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: textColor.withOpacity(0.7),
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              weather.cityName,
                              style: GoogleFonts.montserrat(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(scale: value, child: child),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: textColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.refresh_rounded, color: textColor),
                        onPressed: () => weatherProvider.refreshWeather(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            // Weather Card
            WeatherCard(
              weather: weather,
              onRefresh: () => weatherProvider.refreshWeather(),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    WeatherProvider weatherProvider,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFFE53935), const Color(0xFFB71C1C)],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(28.0),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                    size: 60.0,
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Oops! Something went wrong',
                  style: GoogleFonts.montserrat(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12.0),
                Text(
                  weatherProvider.errorMessage,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                ElevatedButton.icon(
                  onPressed: () => weatherProvider.refreshWeather(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(
                    'Try Again',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFB71C1C),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 15.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
