
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_keeper/controllers/bill_controller.dart';
import 'package:shop_keeper/controllers/daily_sales_controller.dart';
import 'package:shop_keeper/controllers/summery_controller.dart';
import 'package:shop_keeper/objects/summary.dart';

import '../objects/daily_sales.dart';

class _BarChart extends StatefulWidget {

  const _BarChart();

  @override
  State<_BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<_BarChart> {
  BillController summaryController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child:Obx((){
                if(summaryController.isLoading.value){
                  return CircularProgressIndicator();
                }else if(summaryController.summaries.isEmpty){
                  return Text('Empty');
                }else{
                  return BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: generateBarGroups(),
          gridData:  FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          //maxY: 20,
        ),
        );
        }
      }
      )
      );


       
    
  }

List<BarChartGroupData>generateBarGroups(){
  List<Summary> last7Days=summaryController.summaries.reversed.take(7).toList();

  return List.generate(7, (index){
    if(index<last7Days.length){
      return BarChartGroupData(x: index,
      barRods: [
        BarChartRodData(toY: last7Days[index].total,gradient: _barsGradient)
      ],showingTooltipIndicators: [0]);
    }else{
      return BarChartGroupData(x: index,barRods: [
        BarChartRodData(toY: 0,gradient: _barsGradient)
      ],
      showingTooltipIndicators: [0],
      );
    }
  });
}




  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    List<Summary>last7Days=summaryController.summaries.reversed.take(7).toList();

    if(value>=0 && value<last7Days.length){
      final dateString=last7Days[value.toInt()].date;
      final DateTime dateTime=DateFormat.yMMMd().parse(dateString);
      final day=DateFormat.d().format(dateTime);

      return SideTitleWidget(child: Text(day,style: style,), axisSide: meta.axisSide,space: 4,);
    }else{
      return SideTitleWidget(child: Text("",style: style,), axisSide: meta.axisSide,space: 4,);
    }

    
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.blue
,
          Colors.blueAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {



@override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {

    return  AspectRatio(
      aspectRatio: 1.6,
      child:
                   _BarChart()
              
    
    
      
     

    );
  }
}