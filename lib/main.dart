import 'package:flutter/material.dart';
import 'package:melodify/models/playlist_provider.dart';
import 'package:melodify/pages/home_page.dart';
import 'package:melodify/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider(),),
    ChangeNotifierProvider(create: (context) => PlaylistProvider(),)
  ],
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melodify',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MyHomePage(),
    );
  }
}
