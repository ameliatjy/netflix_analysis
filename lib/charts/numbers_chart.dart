import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts
  show BarChart, Series, ColorUtil;
import 'package:netflix_analysis/model/analysis_series.dart';

class NumbersChart extends StatelessWidget {
  final List<AnalysisSeries> data;
  final String title;

  const NumbersChart(
    {
      Key? key,
      required this.data,
      required this.title
    }
  ) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    List<charts.Series<AnalysisSeries, String>> series = [
      charts.Series(
        id: "popularity",
        data: data,
        domainFn: (dynamic series, _) => "${series.year}",
        measureFn: (dynamic series, _) => series.metric,
        colorFn: (dynamic series, _) => charts.ColorUtil.fromDartColor(Colors.green)
      )
    ];

    return Container(
      height: 300,
      padding: const EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}