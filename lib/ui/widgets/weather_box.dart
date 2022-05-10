import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/util/resources_manager.dart';
import 'package:weather_challenge/util/strings.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherBox extends StatelessWidget {
  final WeatherCityModel model;
  final bool showName;
  const WeatherBox({
    Key? key,
    this.showName = true,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              ResourceManager.getImageFromDescription(
                model,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: showName
                  ? [
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        model.time!.day == DateTime.now().day
                            ? WeatherStrings.today
                            : "${model.time!.day} ${DateFormat.MMMM().format(model.time!)}",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ]
                  : [
                      Text(
                        model.time!.day == DateTime.now().day
                            ? WeatherStrings.today
                            : "${model.time!.day} ${DateFormat.MMMM().format(model.time!)}",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ResourceManager.getIconFromDescription(
                  model,
                  size: 64.0,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  model.littleDescription,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.windy,
                    size: 24.0,
                    color: Colors.lightBlue,
                  ),
                  value: model.windSpeed.toStringAsFixed(2),
                  unit: WeatherStrings.windUnit,
                ),
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.thermometer,
                    size: 24.0,
                    color: Colors.red,
                  ),
                  value: model.temp.toStringAsFixed(1),
                  unit: WeatherStrings.tempUnit,
                ),
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.humidity,
                    size: 24.0,
                    color: Colors.orange,
                  ),
                  value: model.humidity.round().toString(),
                  unit: WeatherStrings.humidityUnit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WeatherValueBox extends StatelessWidget {
  final Icon property;
  final String value;
  final String unit;
  const WeatherValueBox({
    Key? key,
    required this.property,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 6.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            property,
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              unit,
              style: const TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
