import 'dart:convert';

import 'package:flutter_application_1/model/class_clouds.dart';
import 'package:flutter_application_1/model/class_coord.dart';
import 'package:flutter_application_1/model/class_sys.dart';
import 'package:flutter_application_1/model/class_weather.dart';
import 'package:flutter_application_1/model/class_weather_main.dart';
import 'package:flutter_application_1/model/class_wind.dart';

DataWeather dataWeatherFromJson(String str) =>
    DataWeather.fromJson(json.decode(str));

String dataWeatherToJson(DataWeather data) => json.encode(data.toJson());

class DataWeather {
  DataWeather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  factory DataWeather.fromJson(Map<String, dynamic> json) => DataWeather(
        coord: Coord.fromJson(json["coord"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord!.toJson(),
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
        "base": base,
        "main": main!.toJson(),
        "visibility": visibility,
        "wind": wind!.toJson(),
        "clouds": clouds!.toJson(),
        "dt": dt,
        "sys": sys!.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}
