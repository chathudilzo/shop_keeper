import 'package:flutter/material.dart';

class MeetDevelopers extends StatelessWidget {
  const MeetDevelopers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Developer Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/back.jpeg',
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Chathura Dilshan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Passionate Flutter Developer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('About Billify Shop App'),
              subtitle: Text(
                'Billify is a Flutter-based shop app that simplifies the billing process for businesses. '
                'It allows users to add items, create bills, and track daily sales seamlessly.'
                ' Explore some of the features and functionalities below:',
              ),
            ),
            ListTile(
              title: Text('Features and Functionalities'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Add and manage items for sale.'),
                  Text('• Create and track bills for each transaction.'),
                  Text('• View daily sales summaries.'),
                  // Add more features as needed
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/back.jpeg'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to the Developer Profile!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'I am',
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 20,
                ),
              ),
              Text(
                'CHATHURA DILSHAN',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add any action you want
                },
                child: Text('Explore More'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amberAccent,
                  textStyle: TextStyle(color: Colors.black),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}