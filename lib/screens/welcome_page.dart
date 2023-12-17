import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_keeper/screens/add_item_page.dart';
import 'package:shop_keeper/screens/all_bill_page.dart';
import 'package:shop_keeper/screens/chart.dart';
import 'package:shop_keeper/screens/daily_sales_page.dart';
import 'package:shop_keeper/screens/dev_meet.dart';
import 'package:shop_keeper/screens/home_page.dart';

import '../controllers/daily_sales_controller.dart';
import 'full_summary.dart';

class WelcomePage extends StatefulWidget {
   WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20) ,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        foregroundColor: Colors.white,
        title: Text('Hello,Billify User!',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.to(MeetDevelopers()),
                  child: Text('Meet Developers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ],
            ),
            SizedBox(
              height: height*0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(ItemPage()),
                    child: Container(
                      width: width*0.40,
                      height: width*0.35,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          blurRadius: 2,spreadRadius: 3,offset: Offset(2,3)
                        )],
                        color: Color.fromARGB(159, 56, 56, 56),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('➕',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                            Text('Add Items',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(HomePage()),
                    child: Container(
                      width: width*0.40,
                      height: width*0.35,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          blurRadius: 2,spreadRadius: 3,offset: Offset(2,3)
                        )],
                        color: Color.fromARGB(159, 56, 56, 56),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('🛒',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                            Text('Billing',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    
                  ),
                  
                ],
              ),
            ),
            Expanded(
              child: Container(
               
                height:height*0.5 ,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/back.jpeg')),
                  gradient: LinearGradient(colors: [const Color.fromARGB(255, 55, 57, 59),Colors.black]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(150),
                    topRight: Radius.circular(10)
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(FullSummaryPage()),
                          child: Container(
                            width: width*0.35,
                            height: width*0.30,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                blurRadius: 2,spreadRadius: 3,offset: Offset(2,3)
                              )],
                              color: Color.fromARGB(159, 56, 56, 56),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('📶',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                                  Text('Summary',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(DailySalesPage()),
                          child: Container(
                            width: width*0.35,
                            height: width*0.30,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                blurRadius: 2,spreadRadius: 3,offset: Offset(2,3)
                              )],
                              color: Color.fromARGB(159, 56, 56, 56),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('📈',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                                  Text('Daily Sales',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                          
                        ),
                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(AllBillPage()),
                          child: Container(
                            width: width*0.35,
                            height: width*0.30,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                blurRadius: 2,spreadRadius: 3,offset: Offset(2,3)
                              )],
                              color: Color.fromARGB(159, 56, 56, 56),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('💵',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                                  Text('Bills',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(AllBillPage()),
                          child: Container(
                            width: width*0.35,
                            height: width*0.30,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                blurRadius: 2,spreadRadius: 3,offset: Offset(2,3)
                              )],
                              color: Color.fromARGB(159, 56, 56, 56),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('📊',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                                  Text('Full Daily',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                          
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            )

            //  BarChartSample3()
            
          ],
        ),
      ),
    );
  }
}