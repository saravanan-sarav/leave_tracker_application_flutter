import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_tracker_application/app.dart';
import 'package:leave_tracker_application/src/presentation/state_management/localizationState.dart';
import 'package:leave_tracker_application/src/presentation/view/loginPage.dart';
import 'package:leave_tracker_application/src/presentation/view/requestDetailPage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: Colors.white),
        fontFamily: GoogleFonts.karla().fontFamily,
      ),
      home: const LoginPage(),
      locale: Locale(ref.watch(LocalizationProvider.notifier).getLocale()),
    );
  }
}
