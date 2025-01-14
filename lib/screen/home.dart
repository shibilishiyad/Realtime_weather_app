import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather_service_provider.dart';

import 'package:weather_app/widget/apptext.dart';
import 'package:weather_app/widget/image_path.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _clicked = false;
  final TextEditingController _citycontroller = TextEditingController();

  @override
  void dispose() {
    _citycontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Provider.of<Locationprovider>(context, listen: false).determainposition();
    //  Provider.of<WeatherServiceProvider>(context, listen: false).fechDataByCity('dubai');
    final locationprovider =
        Provider.of<Locationprovider>(context, listen: false);
    locationprovider.determainposition().then((_) {
      if (locationprovider.currentlocationname != null) {
        var city = locationprovider.currentlocationname?.locality;
        if (city != null) {
          // ignore: use_build_context_synchronously
          Provider.of<WeatherServiceProvider>(context, listen: false)
              .fechDataByCity(city);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final locationprovider = Provider.of<Locationprovider>(context);
    final weatherprovider = Provider.of<WeatherServiceProvider>(context);
    DateTime now = DateTime.now();
    String? timeOfDay;

    if (now.hour >= 5 && now.hour < 12) {
      timeOfDay = "Morning";
    } else if (now.hour >= 12 && now.hour < 17) {
      timeOfDay = "Afternoon";
    } else if (now.hour >= 17 && now.hour < 21) {
      timeOfDay = "Evening";
    } else {
      timeOfDay = "Night";
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 90,
          left: 20,
          right: 20,
        ),
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(backgroundImage[
                        weatherprovider.weather?.weather![0].main ?? 'N/A'] ??
                    'lib/asset/image /b2c662f6-41ec-4341-8708-96e78698e105.jpeg'))),
        child: Stack(
          children: [
            _clicked == true
                ? Align(
                    alignment: const Alignment(00, -0.87),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _citycontroller,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Search by city',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              weatherprovider
                                  .fechDataByCity(_citycontroller.text);
                              print(_citycontroller
                                  .text); // Changed to _citycontroller.text
                            },
                            icon: const Icon(Icons.search, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: 50,
              child: Consumer<Locationprovider>(
                builder: (context, locationProvider, child) {
                  String? mylocation;
                  if (locationprovider.currentlocationname != null) {
                    mylocation = locationProvider.currentlocationname?.locality;
                  } else {
                    mylocation = 'Unknown Location00';
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 35,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Apptext(
                                data: mylocation,
                                size: 18,
                                color: Colors.white,
                              ),
                              Apptext(
                                data: timeOfDay,
                                size: 15,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      _clicked
                          ? const SizedBox.shrink() // Hides the search button
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  _clicked =
                                      !_clicked; // Toggles the _clicked state
                                });
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
            Align(
                alignment: const Alignment(00, -0.68),
                child: Image.asset(
                  imagePath[
                          weatherprovider.weather?.weather![0].main ?? 'N/A'] ??
                      'lib/asset/image /clouds.png',
                  height: 150,
                )),
            Align(
              alignment: const Alignment(00, -0.11),
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Apptext(
                        data:
                            "${weatherprovider.weather?.main?.temp?.toStringAsFixed(0) ?? "N/A"}\u00b0 C",
                        size: 32,
                        color: Colors.white,
                        fw: FontWeight.bold,
                      ),
                      Apptext(
                        data: weatherprovider.weather?.name.toString() ?? "N/A",
                        size: 24,
                        color: Colors.white.withOpacity(0.9),
                        fw: FontWeight.w600,
                      ),
                      Apptext(
                        data:
                            weatherprovider.weather?.weather![0].main ?? "N/A",
                        size: 20,
                        color: Colors.white.withOpacity(0.8),
                        fw: FontWeight.w500,
                      ),
                      Apptext(
                        data: DateFormat("hh:mm a")
                            .format(DateTime.now())
                            .replaceFirst(RegExp(r'^0'), ''),
                        size: 22,
                        color: Colors.white.withOpacity(0.8),
                        fw: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(00, 0.6),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'lib/asset/image /temperature-high.png',
                              height: 65,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Apptext(
                                  data: 'Temp Max',
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                ),
                                Apptext(
                                  data:
                                      "${weatherprovider.weather?.main?.tempMax?.toStringAsFixed(0) ?? "N/A"}\u00b0 C",
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'lib/asset/image /temperature-low.png',
                              height: 65,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Apptext(
                                  data: 'Temp Min',
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                ),
                                Apptext(
                                  data:
                                      "${weatherprovider.weather?.main?.tempMin?.toStringAsFixed(0) ?? "N/A"}\u00b0 C",
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.6),
                      thickness: 2,
                      indent: 30.0,
                      endIndent: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'lib/asset/image /sun.png',
                              height: 70,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Apptext(
                                  data: 'Sunrise',
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                ),
                                Apptext(
                                  data: weatherprovider.weather?.sys?.sunset !=
                                          null
                                      ? DateFormat('hh:mm a')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  weatherprovider.weather!.sys!
                                                          .sunrise! *
                                                      1000))
                                          .replaceFirst(RegExp(r'^0'), '')
                                      : "N/A",
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'lib/asset/image /moon.png',
                              height: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Apptext(
                                  data: 'Sunset',
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                ),
                                Apptext(
                                  data: weatherprovider.weather?.sys?.sunset !=
                                          null
                                      ? DateFormat('hh:mm a')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  weatherprovider.weather!.sys!
                                                          .sunset! *
                                                      1000))
                                          .replaceFirst(RegExp(r'^0'), '')
                                      : "N/A",
                                  color: Colors.white,
                                  size: 15,
                                  fw: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
