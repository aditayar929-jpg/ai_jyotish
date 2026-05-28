import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../storage/local_storage.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Core
  getIt.registerSingleton<LocalStorage>(LocalStorage(prefs));
  getIt.registerSingleton<DioClient>(DioClient());
  getIt.registerSingleton<Dio>(getIt<DioClient>().dio);
}
