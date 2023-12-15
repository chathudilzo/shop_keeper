import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_keeper/controllers/daily_sales_controller.dart';
import 'package:shop_keeper/controllers/item_controller.dart';
import 'package:shop_keeper/objects/bill.dart';
import 'package:shop_keeper/objects/sell_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
ItemController controller=Get.find();
var textControllers=<String,TextEditingController>{};

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 35, 35),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            calculateTotal();
          }, icon: Icon(Icons.calculate))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            SizedBox(
              width: width,
              height: height*0.9,
              child: Obx((){
                if(controller.isLoading.value){
                  return CircularProgressIndicator();
                }else if(controller.itemList.isEmpty){
                  return Text('No Items');
                }else{
                  
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
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
                                  Column(
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
                                  SizedBox(
                                  child: Column(
                                    children: [
                                      DropdownButton<String>(items:<String>['','100','250','500','1000'].map<DropdownMenuItem<String>>((String value){
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
            )
          ],
        ),
      ),
    );
  }

  void calculateTotal(){
    print('Called');
    List<SellItem> sellItems=[];

    for(final item in controller.itemList){
      final textController=textControllers[item.name];

    

      final buyAmount=double.tryParse(textController!.text)??0;

      if(buyAmount>0){
        final sellItem=SellItem(item.name,item.kgPrice, item.unitPrice, buyAmount);
        sellItems.add(sellItem);
      }
      
    }
    if(sellItems.isNotEmpty){
      final bill=Bill(DateFormat.yMMMd().format(DateTime.now()), sellItems, '', 'Paid');
      print(bill);

      _showBill(context,bill);
    }
    
    for(SellItem sellItem in sellItems){
        print('Name: ${sellItem.name},UnitPrice: ${sellItem.unitPrice} , KgPrice:${sellItem.kgPrice}  Buy Amount: ${sellItem.buyAmount}, Total: ${sellItem.itemTotal}');
      }
  }

  Future<void>_showBill(BuildContext context,Bill bill)async{
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    
    String status=bill.payedStatus;

    await showDialog(context: context,
     builder: (BuildContext context){
      return BillDialog(bill);
      
      
      // AlertDialog(
      //   title: Text(bill.date.toString()),
      //   content: Column(
      //     children: [
      //         DataTable(
      //           columnSpacing: 20,
      //           columns:[
      //             DataColumn(label:Text('Name')),
      //             //DataColumn(label: Text('Unit Price')),
                  
      //             DataColumn(label: Text('Amount')),
      //             DataColumn(label: Text('Item Total'))
      //           ],
      //            rows:
      //            [
      //             for(int index=0;index<bill.sellItems.length;index++)
      //        DataRow(
              
      //           cells: [
      //             DataCell(Column(
      //               children: [
      //                 Text(bill.sellItems[index].name),
      //                 Text(bill.sellItems[index].unitPrice==0?bill.sellItems[index].kgPrice.toString():bill.sellItems[index].unitPrice.toString())
      //               ],
      //             )),


      //             DataCell(Text(bill.sellItems[index].buyAmount.toString())),
      //             DataCell(Text(bill.sellItems[index].itemTotal.toString()))

      //           ],
      //         ) 
      //            ]
                 
      //            ),

      //            Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Text('Total:${bill.fullTotal}')
      //             ],
      //            ),
      //            DropdownButton(
      //             value: status,
      //             items:[DropdownMenuItem(
      //             child: Text('Paid'),value: 'Paid',),
      //             DropdownMenuItem(child: Text('Not Paid'),value: 'Not Paid',)
      //             ,DropdownMenuItem(child: Text('Full Paid'),value: 'Half Paid',)],
      //             onChanged: (value){
      //               setState(() {
      //                 status=value!;
      //               });
      //             })









            
            
      //     ],
      //   ),
      // );
     });
  }
}


class BillDialog extends StatefulWidget {
  final Bill bill;

  BillDialog(this.bill);

  @override
  _BillDialogState createState() => _BillDialogState();
}

class _BillDialogState extends State<BillDialog> {
  String? status;
DailySalesController _salesController=Get.find();
  @override
  void initState() {
    super.initState();
    status = widget.bill.payedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.bill.date.toString()),
      content: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(
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
                      DataCell(Column(
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
            TextButton(onPressed: (){
              if(status=='Not Paid'){
      
              }else if(status=='Half Paid'){
      
              }else{
                _salesController.updateSalesData(widget.bill.sellItems);
              }
            }, child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
