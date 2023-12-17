import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_keeper/controllers/item_controller.dart';
import 'package:shop_keeper/objects/item.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

ItemController _controller=Get.find();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20) ,
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 20, 20, 20) ,
        foregroundColor: Colors.yellowAccent,
        actions: [
          IconButton(onPressed: (){
            _showAddItemForm(context);
          }, icon: Icon(Icons.add))
        ],
      ),
      body:
            Center(
              child: SizedBox(
                  width: width*0.9,
                    height: height,
                  child: Obx((){
                    if(_controller.isLoading.value){
                      return CircularProgressIndicator();
                    }else if(_controller.itemList.isEmpty){
                      return Text('No Items');
                    }else{
                      return ListView.builder(
                        itemCount: _controller.itemList.length,
                        itemBuilder: (context,index){
                        final item=_controller.itemList[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Delete Item'),
                                content: Row(
                                  children: [],
                                ),
                                actions: [
                                  TextButton(onPressed: (){
                                    _controller.deleteItem(item);
                                    Navigator.pop(context);
                                  }, child: Text('Delete')),
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text('Cancel'))
                                ],
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: width*0.8,
                                //height: 50,
                                            
                                            decoration: BoxDecoration(
                                              boxShadow: [BoxShadow(
                                                blurRadius: 2,spreadRadius: 2,offset: Offset(2, 2)
                                              )],
                                              color: Color.fromARGB(136, 64, 249, 255),
                                              borderRadius: BorderRadius.circular(10)
                                              
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                            Column(
                              children: [
                                 Text(item.name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                Text(item.count.toString())
                              ],
                            ),
                             Column(
                              children: [
                                Text('Unit Price',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                Text(item.unitPrice.toString())
                              ],
                            ),
                            Column(
                              children: [
                                const Text('1KG price',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                Text(item.kgPrice.toString())
                              ],
                            )
                                                ],
                                              ),
                                            ),
                                ),
                          ),
                        );
                      });
                    }
                  }),
                ),
            )
    );

            
          
        
      
  
  }

  Future<void>_showAddItemForm(BuildContext context)async{
String name='';
String count='0';
String unitPrice='0';
String kgPrice='0';

final GlobalKey<FormState> formKey=GlobalKey<FormState>();
//ItemController _controller=Get.find();
await showDialog(context: context,
 builder: (BuildContext context){
  return AlertDialog(
    title: Text('Add New Item'),
    content: Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              
              decoration: InputDecoration(
                labelText: 'Item Name'
              ),
              validator: (value) {
                if(value==''|| value==null){
                  return 'Please enter a valid Name';
                }
                return null;
              },
              onChanged: (value) => name=value,
            ),
            SizedBox(height: 10,),
          
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Count/Amount'
              ),
              validator: (value) {
                if(value==null || value=='0'){
                  return 'Amount Cannot be 0';
                }
                return null;
          
              },
              onChanged: (value){
                try{
                  count=value;
                }catch(error){
                  print(error);
                }
              },
            ),
            SizedBox(height: 10,),
          
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Unit Price'
              ),
                // validator: (value) {
                //   if(value==null || value==''){
                //     return 'Amount Cannot be nul';
                //   }
                //   return null;
          
                // },
              onChanged: (value){
                try{
                  unitPrice=value;
                }catch(error){
                  print(error);
                }
              },
            ),
            SizedBox(height: 10,),
          
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '1kg Price'
              ),
                // validator: (value) {
                //   if(value==null || value=='0'){
                //     return 'Amount Cannot be null';
                //   }
                //   return null;
          
                // },
              onChanged: (value){
                try{
                  kgPrice=value;
                }catch(error){
                  print(error);
                }
              },
            )
          
          
          ],
        ),
      ),
    ),
    actions: [TextButton(onPressed: (){
      Navigator.pop(context);
    }, child: Text('Cancel')),
    
    TextButton(
      onPressed: (){
        if(formKey.currentState?.validate()??false){
          if((unitPrice!='0' && unitPrice!='')||(kgPrice!='0' && kgPrice!='')){
            Item item=Item(name,double.parse(count),double.parse(unitPrice),double.parse(kgPrice));
          _controller.addItem(item);
          Navigator.pop(context);
            
          }else{
            Get.snackbar('Price', 'At least One Price Needed!');
          }

          
        }
      },
      child: Text('Add'),
    )
    ],
    
    
  );
 });


  }
}