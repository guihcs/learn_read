import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:learn_read/services/exercise/user_progress_service.dart';

class ProgressTab extends StatefulWidget {
  @override
  _ProgressTabState createState() => _ProgressTabState();
}

class _ProgressTabState extends State<ProgressTab> {
  @override
  Widget build(BuildContext context) {
    List<num> progressHistory = UserProgressService.progressHistory;

    dynamic progress = List.generate(
      progressHistory.length,
          (index) => FlSpot(index * 1.0, progressHistory[index] * 1.0),
    ).skip(progressHistory.length > 10 ? progressHistory.length - 10 : 0).toList();

    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListTile(
        title: Text(
            'Taxa de aprendizado: ${UserProgressService.learningRate.toStringAsFixed(2)}'),
      ),
      Container(
        padding: EdgeInsets.only(top: 16, bottom: 16, right: 16),
        width: double.infinity,
        height: 400,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: progress,
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
