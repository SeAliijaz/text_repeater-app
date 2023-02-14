import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:text_repeater_app/Screens/home_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///title of app
      title: "Text-Repeater",

      ///Theme
      theme: ThemeData(
        ///setting color
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(color: Colors.teal),

        ///Default Text Theme
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      ///home
      home: HomeScreen(),
    );
  }
}
