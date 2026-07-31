import 'package:flutter/material.dart';

class CustomerInformationCard extends StatelessWidget {
  const CustomerInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text(
              "Customer Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text("John Doe"),
              subtitle: Text("john@email.com"),
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.phone),
              title: Text("+91 9876543210"),
            ),

          ],
        ),
      ),
    );
  }
}