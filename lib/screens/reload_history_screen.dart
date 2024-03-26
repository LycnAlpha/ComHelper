import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tele_communication_helper/screens/home_screen.dart';

class ReloadHistoryScreen extends StatelessWidget {
  const ReloadHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff329BFC),
      appBar: AppBar(
        title: const Text(
          "Reload History",
          style: TextStyle(color: Color(0xff329BFC)),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                "Your Reload History",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            reloadHistoryList(),
          ],
        ),
      )),
    );
  }

  Widget reloadHistoryCard(snap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${snap['phoneNumber']}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            Text(
              'Amount: ${snap['amount']}',
              style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600),
            ),
            Text(
              '${snap['date']}',
              style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget reloadHistoryList() {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('reload').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) => Container(
                      child: reloadHistoryCard(
                        snapshot.data!.docs[index].data(),
                      ),
                    )));
          }),
    );
  }
}
