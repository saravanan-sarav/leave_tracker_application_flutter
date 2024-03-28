import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_tracker_application/src/data/database/db_helper.dart';
import 'package:leave_tracker_application/src/presentation/providers/localization_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/loading_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/localization_state.dart';
import 'package:leave_tracker_application/src/presentation/view/login_page.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  DatabaseHelper db = DatabaseHelper();
  await db.db;

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
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
                .copyWith(background: Colors.white),
            fontFamily: GoogleFonts.karla().fontFamily,
          ),
          home: Stack(
            children: [
              Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  );
                },
              ),
              if (isLoading == true)
                Container(
                  color: Colors.black.withOpacity(0.5),
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
