import 'package:flutter/material.dart';

class MeetDevelopers extends StatelessWidget {
  const MeetDevelopers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Text('Welcome to the Developer Page!'),
      ),
    );
  }
}