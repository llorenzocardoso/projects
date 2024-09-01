import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('6b5f5034bfeb059a6bb54e09bca5ada6');
  Weather? _weather;
  bool _isNight = false;
  bool _isDarkMode = false;

  _fetchWeather({String? cityName}) async {
    cityName ??= await _weatherService.getCurrentCity();

    try {
      _weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = _weather;
        _updateDayNightState();
      });
    } catch (e) {
      print(e);
    }
  }

  void _updateDayNightState() {
    if (_weather != null) {
      final now = DateTime.now();

      // Verifica se a hora atual está entre o nascer e o pôr do sol
      setState(() {
        _isNight =
            now.isBefore(_weather!.sunrise) || now.isAfter(_weather!.sunset);
      });
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // default animation

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return _isNight ? 'assets/cloudynight.json' : 'assets/windy.json';
      case 'mist':
        return 'assets/mist.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return _isNight
            ? 'assets/night_rain.json'
            : 'assets/partly_shower.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return _isNight ? 'assets/night.json' : 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _searchCity() async {
    final result = await showSearch(
      context: context,
      delegate: CitySearchDelegate(),
    );

    if (result != null) {
      _fetchWeather(cityName: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: _isDarkMode ? Colors.white : Colors.black54,
                  ),
                  onPressed: _searchCity,
                ),
                IconButton(
                  icon: Icon(
                    _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: _isDarkMode ? Colors.white : Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: _isDarkMode ? Colors.white54 : Colors.black54,
                    size: 28,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _weather?.cityName ?? 'City not found',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF-Pro-Display-Regular',
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
              height: 150,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              '${_weather?.temperature.round()}°C',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                fontFamily: 'SF-Pro-Display-Regular',
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherDetail('Min', '${_weather?.tempMin.round()}°C'),
                _buildWeatherDetail('Max', '${_weather?.tempMax.round()}°C'),
                _buildWeatherDetail(
                    'Sensação', '${_weather?.feelsLike.round()}°C'),
                _buildWeatherDetail('Umidade', '${_weather?.humidity}%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF-Pro-Display-Regular',
            color: _isDarkMode ? Colors.white54 : Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF-Pro-Display-Regular',
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}

class CitySearchDelegate extends SearchDelegate<String> {
  final WeatherService _weatherService =
      WeatherService('6b5f5034bfeb059a6bb54e09bca5ada6');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _weatherService.searchCities(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao buscar cidades'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma cidade encontrada'));
        } else {
          final cities = snapshot.data!;
          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cities[index]),
                onTap: () {
                  close(context, cities[index]);
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
