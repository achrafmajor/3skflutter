
import 'package:get_it/get_it.dart';
import 'package:webstreaming/Notification/Push_Notification.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton(() => PushNotificationService());
}