import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_keeper/controllers/bill_controller.dart';

import '../objects/bill.dart';

class AllBillPage extends StatefulWidget {
  const AllBillPage({super.key});

  @override
  State<AllBillPage> createState() => _AllBillPageState();
}

class _AllBillPageState extends State<AllBillPage> {
  BillController billController=Get.find();
  String date=DateFormat.yMMMd().format(DateTime.now());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billController.fetchBills(date);
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
double height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
appBar: AppBar(),
body: 

        SizedBox(
  
          width: width,
  
          height: height,
  
          child: Obx((){
  
          
  
            if(billController.isLoading.value){
  
          
  
              return CircularProgressIndicator();
  
          
  
            }else{
  
          
  
              return ListView.builder(
  
          
  
                itemCount: billController.todayBills.length,
  
          
  
                itemBuilder:(BuildContext context,index){
  
          
  
                  Bill bill=billController.todayBills[index];
  
          
  
                return Card(
                    elevation: 3,
                    //color: bill.payedStatus=='Not Paid'?Colors.red.shade700:bill.payedStatus=='Half Paid'?Colors.amberAccent:Colors.greenAccent,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                    
                            
                    
                      children: [
                    
                            
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Date: ${bill.date}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text('Status: ${bill.payedStatus}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                          ],
                        ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Amount Paid: ${bill.payedAmount}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Text('Depth: ${bill.fullTotal-bill.payedAmount}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:(bill.fullTotal-bill.payedAmount)>0? Colors.red:Colors.green),)

                        ],
                       )
                        ,
                        Row(
                          children: [
                            Text(bill.buyerName.toString().toUpperCase(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        DataTable(
                          columns:[
                          DataColumn(label: Text('Name'),),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Total'))
                        ], rows: [
                          for(int index=0;index<bill.sellItems.length;index++)
                          DataRow(cells: [
                            DataCell(Column(
                              children: [
                                Text(bill.sellItems[index].name),
                                Text(bill.sellItems[index].unitPrice == 0
                                ? bill.sellItems[index].kgPrice.toString()
                                : bill.sellItems[index].unitPrice.toString())
                              ],
                            )),
                            DataCell(Text(bill.sellItems[index].buyAmount.toStringAsFixed(2))),
                            DataCell(Text(bill.sellItems[index].itemTotal.toStringAsFixed(2)))
                          
                          ])
                        ]
                        ),
                        Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Total:'),
                                  Text(
                    bill.fullTotal.toStringAsFixed(2),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                    
                            
                    
                      ],
                    
                            
                    
                    ),
                  ),
  
          
  
                );
  
          
  
              });
  
          
  
            }
  
          
  
          }),
  
        ),
        
  
    
  
      
  
    
  
    


    );
  }
}