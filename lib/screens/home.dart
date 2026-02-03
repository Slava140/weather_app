import 'package:flutter/material.dart';
import 'package:sem2/models/weather.dart';
import 'package:sem2/utils/utils.dart';


class HomeScreen extends StatefulWidget {
  final Future<WeatherResponse> futureWeather;
  HomeScreen({super.key, required this.futureWeather});
  @override
  HomeScreenState createState() => HomeScreenState(futureWeather: futureWeather);
}

class HomeScreenState extends State<HomeScreen> {
  final Future<WeatherResponse> futureWeather;
  final PreferencesService prefs = PreferencesService();
  Future<String?>? futureLoggedInLogin = null;
  bool _loaded = false;

  HomeScreenState({required this.futureWeather});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      setState(() {
        futureLoggedInLogin = prefs.getLoggedInLogin();
      });
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Караганда',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  FutureBuilder(
                      future: futureLoggedInLogin,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Text(snapshot.data.toString());
                        } else {
                          return Text('');
                        }
                      }
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.map_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.account_circle_outlined),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/login'
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 48),
              Column(
                children: [
                  Text(
                    getFormattedDate(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  FutureBuilder<WeatherResponse>(
                      future: futureWeather,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.current.tempC.toInt().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 96,
                            ),
                          );
                        } else {
                          return Text('Нет данных');
                        }
                      }
                  ),
                ],
              ),
              FutureBuilder<WeatherResponse>(
                  future: futureWeather,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Image.network('https:${snapshot.data!.current.condition.iconUrl}', width: 128, height: 128);
                    } else {
                      return Text('Нет данных');
                    }
                  }
              ),
              FutureBuilder<WeatherResponse>(
                  future: futureWeather,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.current.condition.text,
                        style: TextStyle(
                            fontSize: 18
                        ),
                      );
                    } else {
                      return Text('Нет данных');
                    }
                  }
              ),
              SizedBox(height: 48),
              TextButton(
                  onPressed: () => {

                    Navigator.pushNamed(
                        context, '/details'
                    )
                  },
                  child: Text(
                    'Подробнее',
                    style: TextStyle(fontSize: 24),
                  )
              ),
            ],
          ),
        )
    );
  }

  // @override
  // State<HomeScreen> createState() {
  //   return _HomeScreenState();
  // }
}

// class _HomeScreenState extends State<HomeScreen> {
//   late Future<WeatherResponse> futureWeather;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   futureWeather =
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.read<WeatherController>();
//     futureWeather = fetchWeather(
//         '8672369e1dbd452385640544262701',
//         controller.city
//     );
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Караганда',
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontSize: 24
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.map_outlined),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.settings_outlined),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 48),
//             Column(
//               children: [
//                 Text(
//                   getFormattedDate(),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                   ),
//                 ),
//                 FutureBuilder<WeatherResponse>(
//                     future: futureWeather,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('${snapshot.error}');
//                       } else if (snapshot.hasData) {
//                         return Text(
//                           snapshot.data!.current.tempC.toInt().toString(),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 96,
//                           ),
//                         );
//                       } else {
//                         return Text('Нет данных');
//                       }
//                     }
//                 ),
//               ],
//             ),
//             FutureBuilder<WeatherResponse>(
//                 future: futureWeather,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     return Image.network('https:${snapshot.data!.current.condition.iconUrl}', width: 128, height: 128);
//                   } else {
//                     return Text('Нет данных');
//                   }
//                 }
//             ),
//             FutureBuilder<WeatherResponse>(
//                 future: futureWeather,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     return Text(
//                       snapshot.data!.current.condition.text,
//                       style: TextStyle(
//                           fontSize: 18
//                       ),
//                     );
//                   } else {
//                     return Text('Нет данных');
//                   }
//                 }
//             ),
//             SizedBox(height: 48),
//             TextButton(
//                 onPressed: () => {
//                   Navigator.pushNamed(
//                       context, '/details'
//                   )
//                 },
//                 child: Text(
//                   'Подробнее',
//                   style: TextStyle(fontSize: 24),
//                 )
//             ),
//           ],
//         ),
//       )
//     );
//   }
// }