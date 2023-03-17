import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'features/trivial/presentation/pages/trivia_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.green.shade600,
        ),
      ),
      home: const TriviaPage(),
    );
  }
}
