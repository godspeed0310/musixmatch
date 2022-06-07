import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musixmatch/frontend/shared/shared_constants.dart';
import 'package:musixmatch/frontend/views/home.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked_themes/stacked_themes.dart';

void main() async {
  await ThemeManager.initialise();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, devicetype) {
        return ThemeBuilder(
          lightTheme: Themes.light,
          darkTheme: Themes.dark,
          defaultThemeMode: ThemeMode.system,
          builder: (context, lightTheme, darkTheme, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              home: const HomeView(),
            );
          },
        );
      },
    );
  }
}
