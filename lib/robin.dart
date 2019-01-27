import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

/// Donations per unit time
class PointsLineChart extends StatelessWidget {
  final bool animate;

  PointsLineChart({this.animate});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ScopedModel.of<AppModel>(context).donationHistory,
        builder:
            (BuildContext buildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container();
          return charts.LineChart(
              [
                new charts.Series<d_DonationsTime, int>(
                  id: 'Sales',
                  colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                  domainFn: (d_DonationsTime sales, _) => sales.day,
                  measureFn: (d_DonationsTime sales, _) => sales.dollars,
                  data: snapshot.data.documents
                      .map((DocumentSnapshot documentSnapshot) {
                    return d_DonationsTime(
                        (documentSnapshot['timeDonated'] as DateTime).day,
                        (documentSnapshot['amount'] as int));
                  }).toList(),
                )
              ].cast<charts.Series<dynamic, int>>(),
              animate: animate,
              defaultRenderer:
                  new charts.LineRendererConfig(includePoints: true));
        });
  }
}

/// Linear data type
class d_DonationsTime {
  final int day;
  final num dollars;

  d_DonationsTime(this.day, this.dollars);
}

Widget dataSectionCategories = Container(
  height: 200,
  padding: const EdgeInsets.all(32.0),
  child: DonutAutoLabelChart(),
);

/// Donation transaction categories
class DonutAutoLabelChart extends StatelessWidget {
  final bool animate;

  DonutAutoLabelChart({this.animate});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ScopedModel.of<AppModel>(context).donationHistory,
        builder:
            (BuildContext buildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container();
          return charts.PieChart(
              [
                new charts.Series<d_DonationsCategory, int>(
                  id: 'Sales',
                  domainFn: (d_DonationsCategory cat, _) => cat.enumeration,
                  measureFn: (d_DonationsCategory cat, _) => cat.dollars,
                  data: [
                    d_DonationsCategory(
                      Category.FOOD.index,
                      'Food',
                      ScopedModel.of<AppModel>(context)
                          .amountByCategory(Category.FOOD, snapshot),
                    ),
                  ],
                  labelAccessorFn: (d_DonationsCategory row, _) =>
                      '${row.category}',
                )
              ].cast<charts.Series<dynamic, int>>(),
              animate: animate,
              defaultRenderer: new charts.ArcRendererConfig(
                  arcWidth: 60,
                  arcRendererDecorators: [new charts.ArcLabelDecorator()]));
        });
  }
}

/// A certain category of donation and how much was donated
class d_DonationsCategory {
  final int enumeration;
  final String category;
  final double dollars;

  d_DonationsCategory(this.enumeration, this.category, this.dollars);
}

class Robin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScopedModel.of<AppModel>(context).donate(Category.FOOD);
        },
        icon: Icon(Icons.attach_money),
        label: Text("Donate"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.greenAccent,
      ),
      body: Hero(
        tag: 'Robin',
        child: Material(
          color: Colors.greenAccent,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  title: Hero(
                    tag: 'Robin title',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Robin',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  background: Container(
                    color: Colors.greenAccent,
                  ),
                  centerTitle: true,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
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
                          StreamBuilder<QuerySnapshot>(
                            stream: ScopedModel.of<AppModel>(context)
                                .donationHistory,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              int count = 0;
                              if (snapshot.connectionState !=
                                  ConnectionState.waiting) {
                                count = ScopedModel.of<AppModel>(context)
                                    .count(snapshot);
                              }
                              return Text('$count Donations');
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(32.0),
                      child: PointsLineChart(),
                    ),
                    dataSectionCategories,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
