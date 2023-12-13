import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.add))
        ],
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      
          Container(
            width: width*0.8,
      
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                blurRadius: 2,spreadRadius: 2,offset: Offset(2, 2)
              )],
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(10)
              
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Item Name',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                      Text('')
                    ],
                  ),
                  const Column(
                    children: [
                      Text('Unit Price',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                      Text('120')
                    ],
                  ),
                  Column(
                    children: [
                      const Text('1KG price',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                      Text('300')
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}