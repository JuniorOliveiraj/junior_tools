import 'package:flutter/material.dart';
import 'package:junior_tools/ChangeNotifier.dart';
import 'package:junior_tools/pages/HomePage.dart';
import 'package:junior_tools/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Core());
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  void setThemeDark(bool value) {
    _isDark = value;
    notifyListeners(); 
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Sizer(
      builder: ((context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Junior Tools',
          theme: themeNotifier.isDark ? darkTheme : lightTheme,
          home: HomePage(setThemeDark: themeNotifier.setThemeDark),
        );
      }),
    );
  }
}

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (val) => ThemeNotifier(),
      child: const Home(),
    );
  }
}

class DefaultView extends StatelessWidget {
  const DefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
