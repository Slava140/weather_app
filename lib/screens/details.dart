import 'package:flutter/material.dart';
import '../models/weather.dart';


class DetailsScreen extends StatelessWidget {
  final Future<WeatherResponse> futureWeather;

  const DetailsScreen({super.key, required this.futureWeather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        'Караганда',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 24
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.map_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.settings_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 96),
              FutureBuilder<WeatherResponse>(
                  future: futureWeather,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Скорость ветра',
                                    style: TextStyle(fontSize: 16)),
                                Text('${(snapshot.data!.current.windKph * 1000 /
                                    3600).toInt()} м/с',
                                  style: TextStyle(fontSize: 18),)
                              ],
                            ),
                            SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Влажность',
                                    style: TextStyle(fontSize: 16)),
                                Text('${snapshot.data!.current.humidity
                                    .toInt()}%',
                                  style: TextStyle(fontSize: 18),)
                              ],
                            ),
                            SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Видимость',
                                    style: TextStyle(fontSize: 16)),
                                Text('${snapshot.data!.current.visKm
                                    .toInt()} Км',
                                  style: TextStyle(fontSize: 18),)
                              ],
                            ),
                            SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Давление',
                                    style: TextStyle(fontSize: 16)),
                                Text('${(snapshot.data!.current.pressureMb *
                                    0.750062).toInt()} мм.рт.ст',
                                  style: TextStyle(fontSize: 18),)
                              ],
                            ),
                          ]
                      );
                    } else {
                      return Text('Нет данных');
                    }
                  }
              ),
            ],
          ),
        )
    );
  }

// @override
// State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   late Future<WeatherResponse> futureWeather;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   futureWeather = fetchWeather(
//   //       '8672369e1dbd452385640544262701',
//   //       'qaraghandy'
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = context.read<WeatherController>();
//     futureWeather = fetchWeather(controller.city);
//     return Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () => Navigator.pop(context),
//                         icon: const Icon(Icons.arrow_back),
//                       ),
//                       Text(
//                         'Караганда',
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                             fontSize: 24
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.map_outlined),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.settings_outlined),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 96),
//               FutureBuilder<WeatherResponse>(
//                   future: futureWeather,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('${snapshot.error}');
//                     } else if (snapshot.hasData) {
//                       return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Скорость ветра', style: TextStyle(fontSize: 16)),
//                                 Text('${(snapshot.data!.current.windKph * 1000 / 3600).toInt()} м/с', style: TextStyle(fontSize: 18),)
//                               ],
//                             ),
//                             SizedBox(height: 16),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Влажность', style: TextStyle(fontSize: 16)),
//                                 Text('${snapshot.data!.current.humidity.toInt()}%', style: TextStyle(fontSize: 18),)
//                               ],
//                             ),
//                             SizedBox(height: 16),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Видимость', style: TextStyle(fontSize: 16)),
//                                 Text('${snapshot.data!.current.visKm.toInt()} Км', style: TextStyle(fontSize: 18),)
//                               ],
//                             ),
//                             SizedBox(height: 16),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Давление', style: TextStyle(fontSize: 16)),
//                                 Text('${(snapshot.data!.current.pressureMb * 0.750062).toInt()} мм.рт.ст', style: TextStyle(fontSize: 18),)
//                               ],
//                             ),
//                           ]
//                       );
//                     } else {
//                       return Text('Нет данных');
//                     }
//                   }
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }
}