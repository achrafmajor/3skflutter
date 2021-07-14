import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webstreaming/locator.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/variable.dart';
import './rout/routs.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale('ar', 'AE'),
      title: appname,

      theme: ThemeData(
        textTheme: GoogleFonts.reemKufiTextTheme(
          Theme.of(context).textTheme
        ),
        backgroundColor: Colors.black,
        accentColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.black
        ),
      ),
      onGenerateRoute: router.generateRoute,
        initialRoute: Splashscreen_const,
    );
  }

}

