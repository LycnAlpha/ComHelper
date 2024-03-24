import 'package:flutter/material.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Com Helper",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  "Your TeleCommunication Partner",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white54,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReloadScreen()));
                    },
                    child: const Text(
                      "Let's Get Started",
                      style:
                          TextStyle(fontSize: 20.0, color: Color(0xff329BFC)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
