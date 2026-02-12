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
    return Location(
        name: json['name'],
        region: json['region'],
        country: json['country'],
        lat: json['lat'],
        lon: json['lon'],
        tzId: json['tz_id'],
        localtimeEpoch: json['localtime_epoch'],
        localtime: json['localtime'],
    );
  }
}


class Current {
  final num lastUpdatedEpoch;
  final String lastUpdated;
  final num tempC;
  final num tempF;
  final num isDay;
  final Condition condition;
  final num windKph;
  final num pressureMb;
  final num humidity;
  final num visKm;

  const Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.pressureMb,
    required this.humidity,
    required this.visKm,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
        lastUpdatedEpoch: json['last_updated_epoch'],
        lastUpdated: json['last_updated'],
        tempC: json['temp_c'],
        tempF: json['temp_f'],
        isDay: json['is_day'],
        condition: Condition.fromJson(json['condition']),
        windKph: json['wind_kph'],
        pressureMb: json['pressure_mb'],
        humidity: json['humidity'],
        visKm: json['vis_km'],
    );
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