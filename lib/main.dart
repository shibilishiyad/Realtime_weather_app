import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen/home.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather_service_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=>Locationprovider()),
      ChangeNotifierProvider(create: (context)=>WeatherServiceProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          iconTheme:const IconThemeData(color: Colors.white,size: 25),
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}


  