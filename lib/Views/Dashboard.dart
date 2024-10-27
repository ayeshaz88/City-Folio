import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/HomeScreenWidgets/Header.dart';

class PopulationData {
  final int year;
  final int malePopulation;
  final int femalePopulation;

  PopulationData(this.year, this.malePopulation, this.femalePopulation);
}

List<PopulationData> populationData = [
  PopulationData(2015, 10000, 9500),
  PopulationData(2020, 11200, 10800),
  PopulationData(2023, 13500, 13000),
];

class CrimeRate {
  final int year;
  final String category;
  final double crimeRate;

  CrimeRate(this.year, this.category, this.crimeRate);
}

List<CrimeRate> crimeDataRobbery = [
  CrimeRate(2015, 'Robbery'.tr, 12.5),
  CrimeRate(2016, 'Robbery'.tr, 14.2),
  CrimeRate(2017, 'Robbery'.tr, 13.8),
  CrimeRate(2018, 'Robbery'.tr, 15.1),
];

class Dashboard extends StatelessWidget {
  final String selectedCity;

  const Dashboard({Key? key, required this.selectedCity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = Get.size;

    List<charts.Series<PopulationData, String>> populationSeries = [
      charts.Series(
        id: 'Male'.tr,
        data: populationData,
        domainFn: (PopulationData data, _) => data.year.toString(),
        measureFn: (PopulationData data, _) => data.malePopulation,
        labelAccessorFn: (PopulationData data, _) => '${data.malePopulation}',
      ),
      charts.Series(
        id: 'Female'.tr,
        data: populationData,
        domainFn: (PopulationData data, _) => data.year.toString(),
        measureFn: (PopulationData data, _) => data.femalePopulation,
        labelAccessorFn: (PopulationData data, _) => '${data.femalePopulation}',
      ),
    ];

    List<charts.Series<CrimeRate, String>> crimeRateSeries = [
      charts.Series(
        id: 'Crime Rate'.tr,
        data: crimeDataRobbery,
        domainFn: (CrimeRate data, _) => data.year.toString(),
        measureFn: (CrimeRate data, _) => data.crimeRate,
        labelAccessorFn: (CrimeRate data, _) => '${data.crimeRate}',
      ),
    ];

    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        color: const Color(0xFFE8ECF4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height * 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(title: 'Dashboard'.tr),

                  SizedBox(height: size.height * 0.02),
                  Text('Population Chart'.tr,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    height: size.height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: charts.BarChart(
                      populationSeries,
                      animate: true,
                      barGroupingType: charts.BarGroupingType.grouped,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text('Crime Rate Chart'.tr,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    height: size.height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: charts.BarChart(
                      crimeRateSeries,
                      animate: true,
                      barGroupingType: charts.BarGroupingType.grouped,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}