import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Robin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Layout Demo'),
        ),
        body: ListView(
          children: [
            titleSection,
            dataSectionTime,
            dataSectionCategories,
          ],
        ),
      ),
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(32.0),
  child: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Sheriff of Nottingham',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Lord',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      Icon(
        Icons.star,
        color: Colors.yellow[700],
      ),
      Text('41 Donations'),
    ],
  ),
);


Widget dataSectionTime = Container(
  height: 200,
  padding: const EdgeInsets.all(32.0),
  child: PointsLineChart.withSampleData(),
);


/// Donations per unit time
class PointsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<d_DonationsTime, int>> _createSampleData() {
    final data = [
      new d_DonationsTime(0, 5),
      new d_DonationsTime(1, 25),
      new d_DonationsTime(2, 100),
      new d_DonationsTime(3, 75),
    ];

    return [
      new charts.Series<d_DonationsTime, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (d_DonationsTime sales, _) => sales.day,
        measureFn: (d_DonationsTime sales, _) => sales.dollars,
        data: data,
      )
    ];
  }
}


/// Linear data type
class d_DonationsTime {
  final int day;
  final double dollars;

  d_DonationsTime(this.day, this.dollars);
}


Widget dataSectionCategories = Container(
  height: 200,
  padding: const EdgeInsets.all(32.0),
  child: DonutAutoLabelChart.withSampleData(),
);

/// Donation transaction categories
class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChart.withSampleData() {
    return new DonutAutoLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        //
        // [ArcLabelDecorator] will automatically position the label inside the
        // arc if the label will fit. If the label will not fit, it will draw
        // outside of the arc with a leader line. Labels can always display
        // inside or outside using [LabelPosition].
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<d_DonationsCategory, int>> _createSampleData() {
    final data = [
      new d_DonationsCategory(1, "Food", 100),
      new d_DonationsCategory(2, "Personal hygeine", 75),
      new d_DonationsCategory(3, "Education", 25),
      new d_DonationsCategory(4, "Other", 5),
    ];

    return [
      new charts.Series<d_DonationsCategory, int>(
        id: 'Sales',
        domainFn: (d_DonationsCategory cat, _) => cat.enumeration,
        measureFn: (d_DonationsCategory cat, _) => cat.dollars,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (d_DonationsCategory row, _) => '${row.category}',
      )
    ];
  }
}

/// A certain category of donation and how much was donated
class d_DonationsCategory {
  final int enumeration;
  final String category;
  final double dollars;

  d_DonationsCategory(this.enumeration, this.category, this.dollars);
}