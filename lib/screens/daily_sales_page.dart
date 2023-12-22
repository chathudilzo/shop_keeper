import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_keeper/controllers/daily_sales_controller.dart';

class DailySalesPage extends StatefulWidget {
  const DailySalesPage({super.key});

  @override
  State<DailySalesPage> createState() => _DailySalesPageState();
}

class _DailySalesPageState extends State<DailySalesPage> {
DailySalesController controller=Get.find();
String date=DateFormat.yMMMd().format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getDailySales(date);
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Today Sales'),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Obx((){
          if(controller.isLoading.value){
            return CircularProgressIndicator();
          }else if(controller.dailySales.salesData.isEmpty){
            return Center(child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/nothing.png'),width:150,height: 150,),
                          SizedBox(height: 10,),
                          Text('No Sales Found!',style: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),)

                        ],
                      ));
          }else{
         
              return Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.dailySales.date),
                        Row(
                          children: [
                            Text('Today Total Income: ',style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),
                        Text((controller.dailySales.salesData.fold(0.0, (sum, item) => sum+item.itemTotal)).toStringAsFixed(2),style: TextStyle(color: Colors.blueAccent,fontSize: 18,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        DataTable(
                          dataRowHeight: 60,
                          columns:[
                          DataColumn(label: Text('Item')),
                          DataColumn(label: Column(
                            children: [
                              Text('Amount'),
                              Text('grams/units')
                            ],
                          )),
                          DataColumn(label: Text('Income'))
                        ], rows:[
                          for(int index=0;index<controller.dailySales.salesData.length;index++)
                          DataRow(
                          cells: [
                            DataCell(Column(
                              children: [
                                Text(controller.dailySales.salesData[index].name),
                                //Text('${controller.dailySales.salesData[index].unitPrice==0?'1Kg ':'1U'}'),
                                Text(controller.dailySales.salesData[index].unitPrice==0?controller.dailySales.salesData[index].kgPrice.toStringAsFixed(2):controller.dailySales.salesData[index].unitPrice.toStringAsFixed(2))
                              ],
                            )),
                            DataCell(Text(controller.dailySales.salesData[index].buyAmount.toStringAsFixed(2))),
                            DataCell(Text(controller.dailySales.salesData[index].itemTotal.toStringAsFixed(2)))
                            ]
                            )
                            
                        ]
                        )
                         
                      ],
                    ),
                  ),
                ),
              
              );   
          }
          }
        
        ),
      ),
    );
  }
}