// ignore_for_file: curly_braces_in_flow_control_structures

import 'dependencies.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      duration: const Duration(milliseconds: 200),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Container(
              width: 200,
              height: 700,
              color: ColorPallet.name5,
              child: Column(
                children: [
                  TextButton(
                    child: const Text("Light Theme"),
                    onPressed: () {
                      ColorTheming.switchThemeModeTo(ThemeMode.light);
                    },
                  ),
                  TextButton(
                    child: const Text("Dark Theme"),
                    onPressed: () {
                      ColorTheming.switchThemeModeTo(ThemeMode.dark);
                    },
                  ),
                  TextButton(
                    child: const Text("System Theme"),
                    onPressed: () {
                      ColorTheming.switchThemeModeTo(ThemeMode.system);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
