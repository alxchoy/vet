import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class StadisticsScreen extends StatefulWidget {

  @override
  _StadisticsScreenState createState() => _StadisticsScreenState();
}

class _StadisticsScreenState extends State<StadisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments;
    print(data);

    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
      ),
      body: Container(
        child: SimpleChart.withRealData(data: data)
      )
    );
  }
}

class SimpleChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleChart(this.seriesList, { this.animate });

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleChart.withRealData({data}) {
    return new SimpleChart(
      _createSampleData(listData: data),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: false,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true)
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearEvolution, int>> _createSampleData({listData}) {
    final List<LinearEvolution> data = [];

    for (var item in listData) {
      final date = DateTime.parse(item['dateCreated']);
      data.add(new LinearEvolution(date.month, item['petWeight']));
    }

    return [
      new charts.Series<LinearEvolution, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearEvolution evolution, _) => evolution.month,
        measureFn: (LinearEvolution evolution, _) => evolution.weight,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearEvolution {
  final int month;
  final double weight;

  LinearEvolution(this.month, this.weight);
}