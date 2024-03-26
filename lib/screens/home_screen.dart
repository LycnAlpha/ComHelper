import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tele_communication_helper/screens/reload_history_screen.dart';
import 'package:tele_communication_helper/screens/reload_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff329BFC),
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(color: Color(0xff329BFC)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                homePageHeader(),
                providerButtons(context),
                reloadHistoryButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget homePageHeader() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Com Helper",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 35, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        Text(
          "Your TeleCommunication Partner",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white54, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 50.0,
        ),
        Text(
          "Let's Get Started",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        Text(
          "Please select your corresponding service provider",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white54,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget providerButtons(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReloadScreen()));
                },
                child: Container(
                  height: 100.0,
                  width: 150.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Image.asset('assets/icons/icon_dialog.png'),
                ),
              ),
              const SizedBox(
                width: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReloadScreen()));
                },
                child: Container(
                  height: 100.0,
                  width: 150.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Image.asset('assets/icons/icon_mobitel.png'),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReloadScreen()));
                },
                child: Container(
                  height: 100.0,
                  width: 150.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Image.asset('assets/icons/icon_hutch.png'),
                ),
              ),
              const SizedBox(
                width: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReloadScreen()));
                },
                child: Container(
                  height: 100.0,
                  width: 150.0,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Image.asset('assets/icons/icon_airtel.png'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget reloadHistoryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReloadHistoryScreen()));
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
              color: Colors.white),
          child: const Text(
            'Reload History',
            style: TextStyle(
                color: Color(0xff329BFC),
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
