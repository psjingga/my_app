import 'dart:async';
import 'dart:math';

enum Weather {
  cloudy('assets/images/cloudy.png', 25),
  sunny('assets/images/sunny.png', 32),
  rain('assets/images/rain.png', 20);

  final String path;
  final int derajat;
  const Weather(this.path, this.derajat);
}

class WeatherRepository {
  Future getWeather() async {
    await Future.delayed(Duration(seconds: 2));

    switch (Random().nextInt(4)) {
      case 0:
        return Weather.cloudy;
      case 1:
        return Weather.rain;
      case 2:
        return Weather.sunny;
      default:
        throw Exception('Gagal ambil data');
    }
  }

  Stream getStreamWeather() async* {
    while (true) {
      yield await getWeather();
    }
  }
}
