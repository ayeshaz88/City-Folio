import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

const OPENWEATHER_KEY = '8e15dd95cd9a90577cb87ac8de01e6e8';

class WeatherScreen extends StatefulWidget {
  final String city;
  const WeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final WeatherFactory _wf;

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf = WeatherFactory(OPENWEATHER_KEY);
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      Weather w =
          await _wf.currentWeatherByCityName(widget.city); // Use selected city
      setState(() {
        _weather = w;
      });
    } catch (e) {
      print('Error fetching weather: $e'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          _dateTimeInfo(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          _weatherIcon(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _currentTemp(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // Add extra info widget here
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "".tr,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a".tr).format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE".tr).format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "${DateFormat("d.M.y".tr).format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
              ),
            ),
          ),
        ), // Container ending
        Text(
          _weather?.weatherDescription ?? "".tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C".tr,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // Define _extraInfo() widget here
}
