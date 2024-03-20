import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app_new/repositories/weather_repo.dart';

var weatherRepositoryProvider =
    Provider<WeatherRepository>((ref) => WeatherRepository());

var weatherFutureProvider =
    FutureProvider((ref) => ref.watch(weatherRepositoryProvider).getWeather());

var weatherStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(weatherRepositoryProvider).getStreamWeather());
