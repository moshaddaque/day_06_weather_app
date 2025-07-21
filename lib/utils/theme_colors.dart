import 'package:flutter/material.dart';

class ThemeColors {
  // Primary theme colors
  static const Color primaryLight = Color(0xFF4ECDC4);
  static const Color primaryDark = Color(0xFF1A535C);
  
  // Text colors
  static const Color textLight = Color(0xFFF7FFF7);
  static const Color textDark = Color(0xFF2B2D42);
  static const Color textMuted = Color(0xFF8D99AE);
  
  // Card colors
  static const Color cardLight = Color(0xCCFFFFFF); // More opaque white for glassmorphism
  static const Color cardDark = Color(0xCC2B2D42); // More opaque dark for glassmorphism
  
  // Weather condition specific gradients
  static List<Color> getSunnyGradient() {
    return [const Color(0xFFFF9F1C), const Color(0xFFFFBF69)];
  }
  
  static List<Color> getRainyGradient() {
    return [const Color(0xFF3D5A80), const Color(0xFF98C1D9)];
  }
  
  static List<Color> getCloudyGradient() {
    return [const Color(0xFF5C6784), const Color(0xFF7D8597)];
  }
  
  static List<Color> getThunderstormGradient() {
    return [const Color(0xFF2B2D42), const Color(0xFF5C6784)];
  }
  
  static List<Color> getSnowGradient() {
    return [const Color(0xFFE0FBFC), const Color(0xFFA5DEF1)];
  }
  
  // Get gradient based on weather condition
  static List<Color> getGradientByCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return getSunnyGradient();
      case 'rain':
      case 'drizzle':
        return getRainyGradient();
      case 'clouds':
        return getCloudyGradient();
      case 'thunderstorm':
        return getThunderstormGradient();
      case 'snow':
        return getSnowGradient();
      default:
        return getCloudyGradient();
    }
  }
  
  // Get text color based on background brightness
  static Color getTextColor(List<Color> backgroundColors) {
    // Calculate the average brightness of the gradient
    final averageBrightness = backgroundColors.fold<double>(
      0,
      (sum, color) => sum + color.computeLuminance(),
    ) / backgroundColors.length;
    
    // Return white text for dark backgrounds, black text for light backgrounds
    return averageBrightness > 0.5 ? textDark : textLight;
  }
  
  // Get card color based on background brightness
  static Color getCardColor(List<Color> backgroundColors) {
    // Calculate the average brightness of the gradient
    final averageBrightness = backgroundColors.fold<double>(
      0,
      (sum, color) => sum + color.computeLuminance(),
    ) / backgroundColors.length;
    
    // Return dark card for light backgrounds, light card for dark backgrounds
    return averageBrightness > 0.5 ? cardDark : cardLight;
  }
}