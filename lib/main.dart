import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_sphere/core/service/bloc_observer.dart';
import 'package:shop_sphere/core/service/notification_service.dart';
import 'package:shop_sphere/core/service/setup_locator.dart';
import 'package:shop_sphere/core/utils/app_const.dart';
import 'package:shop_sphere/core/utils/app_keys.dart';
import 'package:shop_sphere/features/main/data/notification_model.dart';
import 'package:shop_sphere/firebase_options.dart';
import 'package:shop_sphere/shopsphere_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  setupLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  Hive.registerAdapter(NotificationModelAdapter());

  await Hive.openBox<NotificationModel>(AppConst.appNotificationBox);
   await Hive.openBox(AppConst.dashboardScreen);
  await NotificationService.initialize();
  await NotificationService.initializeLocalNotifications();

  await Supabase.initialize(
    url: AppKeys.supbaseUrl,
    anonKey: AppKeys.supbaseApiKey,
  );

  Bloc.observer = MyBlocObserver();
  runApp(const ShopSphere());
}
