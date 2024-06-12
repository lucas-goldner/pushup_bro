import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/extensions/int_ext.dart';
import 'package:pushup_bro/core/model/pushup.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';

class LastSevenDayPushups extends StatefulWidget {
  const LastSevenDayPushups({super.key});

  @override
  State<LastSevenDayPushups> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LastSevenDayPushups> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showTotal = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PushupSet>>(
      future: context.read<DBCubit>().getAllPushupSets(),
      builder: (context, snapshot) {
        final pushups = snapshot.data ?? [];
        final pushupsInTheLastSevenDays = pushups
            .where(
              (element) => element.completedDate
                  .isAfter(DateTime.now().subtract(const Duration(days: 7))),
            )
            .toList();

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: LineChart(
                  showTotal
                      ? mainData(pushups)
                      : lastSevenDaysData(pushupsInTheLastSevenDays),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PBButton(
              'Total',
              callback: () => setState(() => showTotal = !showTotal),
            ),
          ],
        );
      },
    );
  }

  Widget bottomTitleWidgets(
    BuildContext context,
    double value,
    TitleMeta meta,
  ) {
    final style = context.textTheme.bodyMedium;

    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('JAN', style: style);
      case 4:
        text = Text('APR', style: style);
      case 8:
        text = Text('AUG', style: style);
      case 12:
        text = Text('DEC', style: style);
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(BuildContext context, double value, TitleMeta meta) {
    final style = context.textTheme.bodyMedium;
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
      case 25:
        text = '25';
      case 50:
        text = '50';
      case 75:
        text = '75';
      case >= 100:
        text = 'Over 100';
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget lastSevenDaysBottomTitleWidgets(
    BuildContext context,
    double value,
    TitleMeta meta,
  ) {
    final style = context.textTheme.bodyMedium;

    Widget text;

    switch (value.toInt()) {
      case 1:
        text = Text('JAN', style: style);
      case 4:
        text = Text('APR', style: style);
      case 8:
        text = Text('AUG', style: style);
      case 12:
        text = Text('DEC', style: style);
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData(List<PushupSet> pushups) {
    return LineChartData(
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(
              context,
              value,
              meta,
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) => leftTitleWidgets(
              context,
              value,
              meta,
            ),
            reservedSize: 42,
          ),
        ),
      ),
      minX: 1,
      maxX: 12,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: pushups.stackedPerMonth
              .map(
                (e) => FlSpot(
                  e.month.toDouble(),
                  e.pushups.toDouble(),
                ),
              )
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData lastSevenDaysData(List<PushupSet> pushups) {
    final lastSevenDays = pushups.lastSevenDaysPushups.last.day.lastSevenDays;
    return LineChartData(
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => lastSevenDaysBottomTitleWidgets(
              context,
              value,
              meta,
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) => leftTitleWidgets(
              context,
              value,
              meta,
            ),
            reservedSize: 42,
          ),
        ),
      ),
      minX: lastSevenDays.first.day.toDouble(),
      maxX: lastSevenDays.last.day.toDouble(),
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: pushups.lastSevenDaysPushups
              .map(
                (e) => FlSpot(
                  e.day.toDouble(),
                  e.pushups.toDouble(),
                ),
              )
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
