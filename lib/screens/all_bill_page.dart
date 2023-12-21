import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_keeper/controllers/bill_controller.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

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
    Future.microtask((){
      billController.fetchBills(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
double height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
appBar: AppBar(
  title: Text('All Bills $date'),
  actions: [
    IconButton(onPressed: (){
     showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content:  FutureBuilder(
          future: Future.microtask(() => DateTime.now()),
          builder: (context,snapshot){
            return TimePickerSpinnerPopUp(
          mode: CupertinoDatePickerMode.date,
          initTime: DateTime.now(),
          onChange: (dateTime){
            setState(() {
             
              date=DateFormat.yMMMd().format(dateTime);
              billController.fetchBills(date);
              Navigator.pop(context);
            });
          },
              );
          },
        ),
      );
     });
    }, icon: Icon(Icons.date_range))
  ],
),
body: 

        SizedBox(
  
          width: width,
  
          height: height,
  
          child: Obx((){
  
          
  
            if(billController.isLoading.value){
  
          
  
              return Center(child: LoadingAnimationWidget.dotsTriangle(color: Colors.yellowAccent, size: 30),);
  
          
  
            }else if(billController.todayBills.isEmpty){
             return Center(child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/nothing.png'),width:150,height: 150,),
                          SizedBox(height: 10,),
                          Text('No Bills Found!',style: TextStyle(color: Colors.white),)

                        ],
                      ));
            }
            
            
            else{
  
          
  
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
                          Text('Debt: ${bill.fullTotal-bill.payedAmount}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:(bill.fullTotal-bill.payedAmount)>0? Colors.red:Colors.green),)

                        ],
                       )
                        ,
                        Row(
                          children: [
                            Text(bill.buyerName.toString().toUpperCase(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        DataTable(
                      dataRowHeight: 60,
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