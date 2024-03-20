import 'dart:async';
import 'dart:math';

enum Weather {
  cloudy('assets/images/cloudy.png'),
  sunny('assets/images/sunny.png'),
  rain('assets/images/rain.png');

  final String path;

  const Weather(this.path);
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
