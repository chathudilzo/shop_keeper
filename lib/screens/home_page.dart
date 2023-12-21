import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_keeper/controllers/bill_controller.dart';
import 'package:shop_keeper/controllers/daily_sales_controller.dart';
import 'package:shop_keeper/controllers/item_controller.dart';
import 'package:shop_keeper/objects/bill.dart';
import 'package:shop_keeper/objects/sell_item.dart';
import 'package:shop_keeper/screens/all_bill_page.dart';
import 'package:shop_keeper/screens/daily_sales_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
ItemController controller=Get.find();
BillController _billController=Get.find();

var textControllers=<String,TextEditingController>{};

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _billController.fetchBills(DateFormat.yMMMd().format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 35, 35),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Get.to(AllBillPage());
          }, icon: Icon(Icons.receipt)),
          IconButton(onPressed: (){
            calculateTotal();
          }, icon: Icon(Icons.calculate)),
          IconButton(onPressed: (){
            Get.to(DailySalesPage());
          }, icon: Icon(Icons.sell))
        ],
      ),
      body:Column(
          children: [
            SizedBox(height: 10,),
            Obx((){
              if(_billController.isLoading.value){
                return CircularProgressIndicator();
              }else{
                return Card(
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Total Sales: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        Text(_billController.todaySummary.value.total.toStringAsFixed(2)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Total Income: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        Text(_billController.todaySummary.value.income.toStringAsFixed(2)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Total Debt: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        Text(_billController.todaySummary.value.depth.toStringAsFixed(2)),
                      ],
                    ),
                    
                  ],
                ),
              ),
            );
              }
            } ),
            Expanded(
              child: SizedBox(
                 width: width,
                // height: height,
                
                     child: Obx((){
                                   if(controller.isLoading.value){
                      return Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: Colors.yellowAccent, size: 30),
                      );
                                   }else if(controller.itemList.isEmpty){
                      return Center(child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/nothing.png'),width:150,height: 150,),
                              SizedBox(height: 10,),
                              Text('No Items Found!',style: TextStyle(color: Colors.white),)
                   
                            ],
                          ));
                                   }else{
                      
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.itemList.length,
                            itemBuilder:(context,index){
                              final item=controller.itemList[index];
                              final textController=textControllers[item.name]?? TextEditingController();
                              textControllers[item.name]=textController;
                                    String dropDownValue='';
                              return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text("Kg price: ${item.kgPrice.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text("Unit Price: ${item.unitPrice.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                        child: Column(
                                          children: [
                                            DropdownButton<String>(items:<String>['','100','250','500','750','1000'].map<DropdownMenuItem<String>>((String value){
                                              return DropdownMenuItem<String>(child:Text(value),value: value,);
                                            }).toList(),
                        
                                            value: dropDownValue,
                                            //icon: Icon(Icons.arrow_downward),
                                            onChanged:(String? newValue){
                                              setState(() {
                                                dropDownValue=newValue!;
                                                textController.text=newValue;
                                              });
                                            })
                                          ],
                                        ),
                                        ),
                                        SizedBox(
                                          width: width * 0.4,
                                          child: TextField(
                                            controller: textController,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(fontSize: 16),
                                            decoration: InputDecoration(
                                              labelText: 'Buy Amount',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                        
                              );
                             
                          }),
                        
                      );
                                   }
                                 }),
                   ),
            )
              
            
          ],
        ),
      
    );
  }

  void calculateTotal(){
    print('Called');
    List<SellItem> sellItems=[];

    try{
      for(final item in controller.itemList){
        final textController=textControllers[item.name];

      
        if(textController?.text!=null && textController!.text.isNotEmpty){
          
          final buyAmount=double.tryParse(textController.text)??0;

          if(buyAmount>0){
            final sellItem=SellItem(item.name,item.kgPrice, item.unitPrice, buyAmount);
            sellItems.add(sellItem);
          }
        }
      
      }
      if(sellItems.isNotEmpty){
        final bill=Bill(DateFormat.yMMMd().format(DateTime.now().add(Duration(days: 0))), sellItems, '', 'Paid',0);
        print(bill);

        _showBill(context,bill);
      }
    
    // for(SellItem sellItem in sellItems){
    //     print('Name: ${sellItem.name},UnitPrice: ${sellItem.unitPrice} , KgPrice:${sellItem.kgPrice}  Buy Amount: ${sellItem.buyAmount}, Total: ${sellItem.itemTotal}');
    //   }
    }catch(error){
      Get.snackbar('Error', error.toString());
    }
  }

  Future<void>_showBill(BuildContext context,Bill bill)async{
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    
    String status=bill.payedStatus;

    await showDialog(context: context,
     builder: (BuildContext context){
      return BillDialog(bill,textControllers);
     });
  }
}


class BillDialog extends StatefulWidget {
  final Bill bill;
  final Map<String,TextEditingController> textControllers;

  BillDialog(this.bill,this.textControllers);

  @override
  _BillDialogState createState() => _BillDialogState();
}

class _BillDialogState extends State<BillDialog> {
  String? status;
DailySalesController _salesController=Get.find();
BillController _billController=Get.find();
TextEditingController buyerController=TextEditingController();
TextEditingController halfPayController=TextEditingController();

  @override
  void initState() {
    super.initState();
    status = widget.bill.payedStatus;
  }

  @override
  Widget build(BuildContext context) {
   double width=MediaQuery.of(context).size.width;
  double height=MediaQuery.of(context).size.height;

    return AlertDialog(
      title: Text(widget.bill.date.toString()),
      content:Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height*0.6,
                  child: SingleChildScrollView(
                    child: DataTable(
                        dataRowMaxHeight: 70,
                        columnSpacing: 20,
                        columns: [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Total'))
                        ],
                        rows: [
                          for (int index = 0; index < widget.bill.sellItems.length; index++)
                            DataRow(
                              
                              cells: [
                                DataCell(
                                  
                                  Column(
                                  children: [
                                    Text(widget.bill.sellItems[index].name),
                                    Text(widget.bill.sellItems[index].unitPrice == 0
                                        ? widget.bill.sellItems[index].kgPrice.toString()
                                        : widget.bill.sellItems[index].unitPrice.toString())
                                  ],
                                )),
                                DataCell(Text(widget.bill.sellItems[index].buyAmount.toStringAsFixed(2))),
                                DataCell(Text(widget.bill.sellItems[index].itemTotal.toStringAsFixed(2)))
                              ],
                            )
                        ],
                      ),
                  ),
                ),
              ),
              Expanded(
                
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      
                              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text('Total:'),
                  Text(widget.bill.fullTotal.toStringAsFixed(2),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)],
                              ),
                              DropdownButton(
                  value: status,
                  items: [
                    DropdownMenuItem(child: Text('Paid'), value: 'Paid'),
                    DropdownMenuItem(child: Text('Not Paid'), value: 'Not Paid'),
                    DropdownMenuItem(child: Text('Half Paid'), value: 'Half Paid'),
                  ],
                  onChanged: (value) {
                    setState(() {
                      status = value!;
                      widget.bill.payedStatus=status!;
                    });
                  },
                              ),
                              status=='Not Paid'|| status=='Half Paid'? TextField(
                  controller: buyerController,
                  decoration: InputDecoration(
                    labelText: 'BuyerName',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                              ):Container(),
                              SizedBox(height: 10,),
                              status=='Half Paid'?TextField(
                  controller: halfPayController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Payed Amount',
                    border: OutlineInputBorder(
                      
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                        
                              ):Container()
                    ],
                  ),
                ),
              )
              
            ],
          ),
        
      
      actions: [
        TextButton(onPressed: (){
              if(widget.bill.payedStatus=='Not Paid'){
                if(buyerController.text.trim().isNotEmpty && buyerController.text!=''){
                  widget.bill.buyerName=buyerController.text;
                  _salesController.updateSalesData(widget.bill.sellItems);
                _billController.addBill(widget.bill);
                widget.textControllers.values.forEach((controller)=>controller.clear());
                _billController.fetchBills(DateFormat.yMMMd().format(DateTime.now()));
                Navigator.pop(context);
                }else{
                  Get.snackbar('Error', 'Buyer Name Cannot Be Empty!',
                  snackStyle: SnackStyle.FLOATING,
                  backgroundColor: Colors.red,
                  colorText: Colors.white
                  );
                }
                
              }else if(widget.bill.payedStatus=='Half Paid'){
                if(buyerController.text.trim().isNotEmpty && halfPayController.text.trim().isNotEmpty){
                  widget.bill.buyerName=buyerController.text;
                  widget.bill.payedAmount=double.parse(halfPayController.text);
                   _salesController.updateSalesData(widget.bill.sellItems);
                _billController.addBill(widget.bill);
                widget.textControllers.values.forEach((controller)=>controller.clear());
                _billController.fetchBills(DateFormat.yMMMd().format(DateTime.now()));
                Navigator.pop(context);
                  
                }else{
                  Get.snackbar('Error', 'Buyer and Paid amount cannot be empty!',
                  snackStyle: SnackStyle.FLOATING,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
                }
                
              }else{
                widget.bill.payedAmount=widget.bill.fullTotal;
                _salesController.updateSalesData(widget.bill.sellItems);
                _billController.addBill(widget.bill);
               widget.textControllers.values.forEach((controller)=>controller.clear());
               _billController.fetchBills(DateFormat.yMMMd().format(DateTime.now()));
                Navigator.pop(context);
               
              }
            }, child: Text('Save'))
      ],
    );
  }
}
