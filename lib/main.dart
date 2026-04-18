import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leave_tracker_application/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/database/db_helper.dart';
import 'package:leave_tracker_application/src/presentation/providers/localization_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/loading_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/localization_state.dart';
import 'package:leave_tracker_application/src/presentation/view/register_user_page.dart';
import 'package:leave_tracker_application/src/utils/extensions/notifications_handler.dart';
import 'package:lottie/lottie.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager.initializeNotifications();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  var status = await Permission.notification.status;
  if (status.isDenied) {
    Permission.notification.request();
  }
  DatabaseHelper();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(localizationsProvider.notifier).getLocalizationData();
    return Builder(
      builder: (context) {
        final isLoading = ref.watch(loadingProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Flutter Demo',
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            fontFamily: "Karla",
          ),
          home: Stack(
            children: [
              Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  );
                },
              ),
              if (isLoading == true)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Center(
                    child: Lottie.asset(
                      "assets/lotties/loader.json",
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      repeat: true,
                      reverse: true,
                      animate: true,
                    ),
                  ),
                ),
            ],
          ),
          locale: Locale(ref.watch(localizationProvider).locale),
        );
      },
    );
  }
}
