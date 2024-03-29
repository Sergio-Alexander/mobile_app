import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mob_dev/utils/app_localization.dart';
import 'package:mob_dev/pages/settings.dart';
import 'package:provider/provider.dart';
import 'package:mob_dev/utils/app_status.dart';
import 'floor_model/recorder_database/recorder_database.dart';
import 'routing/router.dart';
import 'utils/database_init.dart';
import 'firebase/firebase_setup.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  runApp(
    DatabaseInitializer(
      child: Builder(
        builder: (context) {
          final database = Provider.of<RecorderDatabase>(context, listen: false);
          final recordingState = RecordingState(database: database);
          return FutureBuilder(
            future: Future.wait([
              recordingState.loadLastStatus(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ChangeNotifierProvider.value(
                  value: recordingState,
                  child: MyApp(),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void toggleTheme() {
    setState(() {
      if (currentTheme == ThemeStyle.material) {
        currentTheme = ThemeStyle.cupertino;
      } else {
        currentTheme = ThemeStyle.material;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: appRouter,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('id', ''), // Indonesian
      ],
      locale: _locale,
    );
  }
}

