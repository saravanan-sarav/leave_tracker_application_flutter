import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/localizationState.dart';
import 'package:leave_tracker_application/src/presentation/state_management/pageNavigationState.dart';
import 'package:leave_tracker_application/src/presentation/view/createRequestPage.dart';
import 'package:leave_tracker_application/src/presentation/view/homePage.dart';
import 'package:leave_tracker_application/src/presentation/view/notificationPage.dart';
import 'package:leave_tracker_application/src/presentation/view/profilePage.dart';
import 'package:leave_tracker_application/src/presentation/view/timesheetPage.dart';
import 'package:leave_tracker_application/src/presentation/widgets/BottomNavigationBarWidget.dart';

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
      ),
      home: const MyHomePage(),
      locale: Locale(ref.watch(LocalizationProvider.notifier).getLocale()),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final List<Widget> _pages = [
    HomePage(),
    TimesheetPageWidget(),
    Center(),
    NotificationPageWidget(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    print("In main ${ref.watch(pageNavigatorProvider.notifier).getState()}");
    return Scaffold(
      body: _pages[ref.watch(pageNavigatorProvider.notifier).getState()],
      bottomNavigationBar: const BottomNavigationBarWidget(),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateRequestPage()))
        },
        backgroundColor: Colors.cyan,
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
