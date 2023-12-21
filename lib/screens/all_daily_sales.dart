

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_keeper/controllers/daily_sales_controller.dart';
import 'package:shop_keeper/objects/daily_sales.dart';

class AllDailySalesPage extends StatefulWidget {
  const AllDailySalesPage({super.key});

  @override
  State<AllDailySalesPage> createState() => _AllDailySalesPageState();
}

class _AllDailySalesPageState extends State<AllDailySalesPage> {
  final DailySalesController _controller=Get.find();



  @override
  Widget build(BuildContext context) {
        double width=MediaQuery.of(context).size.width;
double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Daily Sales'),
      ),
      body:SizedBox(
        height: height,
        width: width,
        child: Obx((){
          if(_controller.isLoading.value){
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.yellowAccent, size: 30),
            );

          }else if(_controller.allDailySalesList.isEmpty){
            return Center(child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/nothing.png'),width:150,height: 150,),
                          SizedBox(height: 10,),
                          Text('No Sales Found!',style: TextStyle(color: Colors.white),)

                        ],
                      ));
          }else{
            return ListView.builder(
              itemCount: _controller.allDailySalesList.length,
              itemBuilder: (BuildContext context,index){
                DailySales dailySales=_controller.allDailySalesList[index];
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Date:'),
                          Text(dailySales.date)
                        ],
                      ),
                      DataTable(
                        dataRowHeight: 60,
                        columns: [
                        DataColumn(label:Text('Item')),
                        DataColumn(label:Column(
                          children: [
                            Text('Amount'),
                            Text('grams/unitsS')
                          ],
                        ),
                        
                        ),
                        DataColumn(label: Text('Income'))
                      ], rows: [
                        for(int i=0;i<dailySales.salesData.length;i++)
                        DataRow(cells:[
                          DataCell(Column(
                            children: [
                              Text(dailySales.salesData[i].name),
                              Text(dailySales.salesData[i].unitPrice==0?dailySales.salesData[i].kgPrice.toStringAsFixed(2):dailySales.salesData[i].unitPrice.toStringAsFixed(2)),

                            ],
                          )),
                          DataCell(Text(dailySales.salesData[i].buyAmount.toStringAsFixed(2))),
                          DataCell(Text(dailySales.salesData[i].kgPrice.toStringAsFixed(2)))
                        ])
                      ])

                    ],
                  ),
                );

            });
          }
        }),
      ),
    );
  }
}