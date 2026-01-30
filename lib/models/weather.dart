class Location {
  final String name;
  final String region;
  final String country;
  final num lat;
  final num lon;
  final String tzId;
  final num localtimeEpoch;
  final String localtime;

  const Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    var l = Location(
        name: json['name'],
        region: json['region'],
        country: json['country'],
        lat: json['lat'],
        lon: json['lon'],
        tzId: json['tz_id'],
        localtimeEpoch: json['localtime_epoch'],
        localtime: json['localtime'],
    );
    print(l.lat);
    return l;
  }
}


class Current {
  final num lastUpdatedEpoch;
  final String lastUpdated;
  final num tempC;
  final num tempF;
  final num isDay;
  final Condition condition;
  // final num windMph;
  // final num windKph;
  // final num windDegree;
  // final String windDir;
  // final num pressureMb;
  // final num pressureIn;
  // final num precipMm;
  // final num precipIn;
  // final num humidity;
  // final num cloud;
  // final num feelslikeC;
  // final num feelslikeF;
  // final num windchillC;
  // final num windchillF;
  // final num heatindexC;
  // final num heatindexF;
  // final num dewponumC;
  // final num dewponumF;
  // final num visKm;
  // final num visMiles;
  // final num uv;
  // final num gustMph;
  // final num gustKph;
  // final num shortRad;
  // final num diffRad;
  // final num dni;
  // final num gti;

  const Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    // required this.windMph,
    // required this.windKph,
    // required this.windDegree,
    // required this.windDir,
    // required this.pressureMb,
    // required this.pressureIn,
    // required this.precipMm,
    // required this.precipIn,
    // required this.humidity,
    // required this.cloud,
    // required this.feelslikeC,
    // required this.feelslikeF,
    // required this.windchillC,
    // required this.windchillF,
    // required this.heatindexC,
    // required this.heatindexF,
    // required this.dewponumC,
    // required this.dewponumF,
    // required this.visKm,
    // required this.visMiles,
    // required this.uv,
    // required this.gustMph,
    // required this.gustKph,
    // required this.shortRad,
    // required this.diffRad,
    // required this.dni,
    // required this.gti,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    // print(json['temp_c']);
    var c = Current(
        lastUpdatedEpoch: json['last_updated_epoch'],
        lastUpdated: json['last_updated'],
        tempC: json['temp_c'],
        tempF: json['temp_f'],
        isDay: json['is_day'],
        condition: Condition.fromJson(json['condition']),
        // windMph: json['wind_mph'],
        // windKph: json['wind_kph'],
        // windDegree: json['wind_degree'],
        // windDir: json['wind_dir'],
        // pressureMb: json['pressure_mb'],
        // pressureIn: json['pressure_in'],
        // precipMm: json['precip_mm'],
        // precipIn: json['precip_in'],
        // humidity: json['humidity'],
        // cloud: json['cloud'],
        // feelslikeC: json['feelslike_c'],
        // feelslikeF: json['feelslike_f'],
        // windchillC: json['windchill_c'],
        // windchillF: json['windchill_f'],
        // heatindexC: json['heatindex_c'],
        // heatindexF: json['heatindex_f'],
        // dewponumC: json['dewponum_c'],
        // dewponumF: json['dewponum_f'],
        // visKm: json['vis_km'],
        // visMiles: json['vis_miles'],
        // uv: json['uv'],
        // gustMph: json['gust_mph'],
        // gustKph: json['gust_kph'],
        // shortRad: json['short_rad'],
        // diffRad: json['diff_rad'],
        // dni: json['dni'],
        // gti: json['gti'],
    );
    print(c);
    return c;
  }
}


class Condition {
  final String text;
  final String iconUrl;
  final num code;

  const Condition({
    required this.text,
    required this.iconUrl,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      iconUrl: json['icon'],
      code: json['code'],
    );
  }
}

class WeatherResponse {
  final Location location;
  final Current current;

  const WeatherResponse({
    required this.location,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
        location: Location.fromJson(json['location']),
        current: Current.fromJson(json['current'])
    );
  }
}