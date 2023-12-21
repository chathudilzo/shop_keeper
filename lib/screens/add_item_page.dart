import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_keeper/controllers/item_controller.dart';
import 'package:shop_keeper/objects/item.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
          }, icon: Icon(Icons.add)),
          IconButton(onPressed: (){
            _showDeleteAll(context);
          }, icon: Icon(Icons.delete))
        ],
      ),
      body:
            Center(
              child: SizedBox(
                  width: width*0.9,
                    height: height,
                  child: Obx((){
                    if(_controller.isLoading.value){
                      return Center(child: LoadingAnimationWidget.beat(color: Colors.yellowAccent, size: 30));
                    }else if(_controller.itemList.isEmpty){
                      return Center(child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/nothing.png'),width:150,height: 150,),
                          SizedBox(height: 10,),
                          Text('No Items Found!',style: TextStyle(color: Colors.white),)

                        ],
                      ));
                    }else{
                      return ListView.builder(
                        itemCount: _controller.itemList.length,
                        itemBuilder: (context,index){
                        final item=_controller.itemList[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('${item.name}'),
                                content: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Image(image: AssetImage('assets/delandupdate.png'),fit: BoxFit.cover,),
                                ),
                                actions: [
                                  TextButton(onPressed: (){
                                    _controller.deleteItem(item);
                                    Navigator.pop(context);
                                  }, child: Text('Delete',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),)),
                                  
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                    _showUpdateItemForm(context,item);
                                  }, child: Text('Update',style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),)),
                                  
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

Future<void>_showDeleteAll(BuildContext context)async{
await showDialog(context: context, builder: (BuildContext context){
  return AlertDialog(
    title: Text('Delete All Items'),
    content: SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            
            borderRadius: BorderRadius.circular(150),
            child: Image(image: AssetImage('assets/deleteall.png'),fit: BoxFit.cover,),
          ),
          Text('Are You Sure You Want To Delete All Items?',style: TextStyle(
            fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold
          ),)
        ],
      ),
      
    ),
  actions: [
    TextButton(onPressed: (){
      _controller.deleteAll();
      Navigator.pop(context);

    }, child: Text('Yes',style: TextStyle(color: Colors.red,fontSize: 16),)),
    TextButton(onPressed: (){
      Navigator.pop(context);
    }, child: Text('No',style: TextStyle(fontSize: 20),))

  ],
  );
  
});
}


Future<void>_showUpdateItemForm(BuildContext context,Item item)async{
 TextEditingController countController = TextEditingController(text: item.count.toString());
  TextEditingController unitPriceController = TextEditingController(text: item.unitPrice.toString());
  TextEditingController kgPriceController = TextEditingController(text: item.kgPrice.toString());

String name=item.name;

  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();

  await showDialog(context: context, builder: (BuildContext cotext){
    return AlertDialog(
      title: Text('Update Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
          children: [
            TextFormField(
              enabled: false,
              initialValue: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                labelText: 'Item Name'
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: countController,
              //initialValue: countController.text,
              decoration: InputDecoration(
                
                labelText: 'Count/Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                  
                ),
              
                
              ),
              validator: (value) {
                if(value==null|| value.isEmpty){
                  countController.text='0';
                  }
              },
              // onChanged: (value) {
              //   print(value);
              //   if(value.trim()==''){
              //     value='0';
              //     count=value;
              //   }
              //   print(value);
              // },
            ),
            SizedBox(height: 10,),
            TextFormField(keyboardType: TextInputType.number,
              controller: unitPriceController,
              //initialValue: unitPriceController.text,
              decoration: InputDecoration(
                labelText: 'Unit Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                  
                ),
                
              ),
              validator: (value) {
                if(value==null || value.isEmpty){
                  return 'Price cannot be empty';
                }
                return null;
              },
              // onChanged: (value) {
              //   print(value);
              //   if(value.trim()==''){
              //     value='0';
              //     unitPrice=value;
              //   }
              //   print(value);
              // },
            ),
            SizedBox(height: 10,),
            TextFormField(keyboardType: TextInputType.number,
              //initialValue: kgPriceController.text,
              controller: kgPriceController,
              decoration: InputDecoration(
                labelText: '1KG Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                  
                ),
                
              ),
              validator: (value) {
                if(value==null|| value.isEmpty){
                  return 'Price cannot be empty';
                }return null;
              },
              // onChanged: (value) {
              //   print(value);
              //   if(value.trim()==''){
              //     value='0';
              //     kgPrice=value;
              //   }
              //   print(value);
              // },
            ),
          ],
              ),
        )),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel')),

        TextButton(onPressed: (){
          if(_formKey.currentState?.validate()??false){
            try{
              print('name:$name , UnitPrice:${unitPriceController.text} ,KGprice:${kgPriceController.text} ,Amount: ${countController.text}');
            double uPrice=double.parse(unitPriceController.text);
            double kprice=double.parse(kgPriceController.text);
print('name:$name , UnitPrice:$uPrice ,KGprice:$kprice ,Amount: ${countController.text}');

            if(uPrice!=0 && kprice==0 || uPrice==0 && kprice!=0){
             Item item= Item(name, double.parse(countController.text), double.parse(unitPriceController.text), double.parse(kgPriceController.text));
              _controller.updateItem(item);
              Navigator.pop(context);
            }else{
              Get.snackbar('Invalid Inputs', 'Only one price can be added! and both cannot be 0');
            }
            }catch(error){
              Get.snackbar('Error', error.toString());
            }
          }
        }, child:Text('Update'))
      ],
    );
  });

}




  Future<void>_showAddItemForm(BuildContext context)async{
TextEditingController countController = TextEditingController(text:'');
  TextEditingController unitPriceController = TextEditingController(text: '');
  TextEditingController kgPriceController = TextEditingController(text:'');
TextEditingController nameController = TextEditingController(text:'');




final GlobalKey<FormState> formKey=GlobalKey<FormState>();
//ItemController _controller=Get.find();
await showDialog(context: context,
 builder: (BuildContext context){
  return AlertDialog(
    title: Text('Add New Item'),
    content: Form(
      key: formKey,
      child: SingleChildScrollView(
        physics:ClampingScrollPhysics(),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Item Name'
              ),
              validator: (value) {
                if(value==''|| value==null){
                  return 'Please enter a valid Name';
                }
                return null;
              },
              
            ),
            SizedBox(height: 10,),
          
            TextFormField(
              controller: countController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Count/Amount'
              ),
              validator: (value) {
                if(value==null || value.isEmpty){
                  countController.text='0';
                }
                return null;
          
              },
              
            ),
            SizedBox(height: 10,),
          
            TextFormField(
              controller: unitPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Unit Price'
              ),
                 validator: (value) {
                   if(value==null || value.isEmpty){
                     unitPriceController.text='0';
                   }
                   return null;
          
                 },
              
            ),
            SizedBox(height: 10,),
          
            TextFormField(
              controller: kgPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '1kg Price'
              ),
                 validator: (value) {
                   if(value==null || value.isEmpty){
                     kgPriceController.text='0';
                   }
                   return null;
          
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
        try{
          if(formKey.currentState?.validate()??false){
          if(((unitPriceController.text.trim()!='0' && unitPriceController.text.trim()!='')
          && (kgPriceController.text.trim()=='0') )
          ||((kgPriceController.text.trim()!='0' && kgPriceController.text.trim()!='')
          &&(unitPriceController.text.trim()=='0'))
          ){
            Item item=Item(nameController.text,double.parse(countController.text.trim()),double.parse(unitPriceController.text.trim()),double.parse(kgPriceController.text.trim()));
          _controller.addItem(item);
          Navigator.pop(context);
            
          }else{
            Get.snackbar('Price', 'At least One Price Needed from unit and Kg and cannot add both!');
          }

          
        }
        }catch(error){
        Get.snackbar('Error', error.toString());
        }
      },
      child: Text('Add'),
    )
    ],
    
    
  );
 });


  }
}