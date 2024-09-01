class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final DateTime sunrise;
  final DateTime sunset;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.humidity,
      required this.sunrise,
      required this.sunset,
      required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        feelsLike: json['main']['feels_like'].toDouble(),
        tempMin: json['main']['temp_min'].toDouble(),
        tempMax: json['main']['temp_max'].toDouble(),
        humidity: json['main']['humidity'],
        sunrise:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
        sunset:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
        mainCondition: json['weather'][0]['main']);
  }
}
