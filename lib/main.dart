import 'package:flutter/material.dart';
import 'screens/selection_screen.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(RubiosRestaurants());
}

class RubiosRestaurants extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rubio\'s Restaurants',
      initialRoute: SelectionScreen.id,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.black,
          primaryVariant: Colors.black,
          secondary: Colors.red,
        ),
        cardTheme: CardTheme(
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.white54,
        ),
      ),
      routes: {
        SelectionScreen.id: (context) => SelectionScreen(),
        MenuScreen.id: (context) => MenuScreen(),
      },
      home: SelectionScreen(),
    );
  }
}
