import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:flutter/material.dart';
import 'package:sittler_app/Pages/Staff/staff-signin.dart';
import 'package:sittler_app/Pages/User/user-signin.dart';

class verifyuser extends StatefulWidget {
  const verifyuser({Key? key}) : super(key: key);

  @override
  State<verifyuser> createState() => _verifyuserState();
}

class _verifyuserState extends State<verifyuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xff004aa0),
            elevation: 0,
          ),
      body: SizedBox(
        width: double.infinity,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 20),

            const Text('Are you a', 
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),

            const SizedBox(height: 30),

            ElevatedButton(
            
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff004aa0),
              onPrimary: Colors.white,
              shadowColor: const Color.fromARGB(255, 53, 143, 247),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              minimumSize: const Size(200, 40),
              maximumSize: const Size(200, 40) //////// HERE
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserClientLoginPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [ Text('Parent ', style: TextStyle(color: Colors.white, fontSize: 20)),
              Icon(FontAwesomeIcons.arrowRight)
            ]

            ),
            
          ),

          const SizedBox(height: 20),

            ElevatedButton(
            
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff004aa0),
              onPrimary: Colors.white,
              shadowColor: const Color.fromARGB(255, 53, 143, 247),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              minimumSize: const Size(200, 40),
              maximumSize: const Size(200, 40) //////// HERE
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const StaffSignIn()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [ Text('Babysitter ', style: TextStyle(color: Colors.white, fontSize: 20)),
              Icon(FontAwesomeIcons.arrowRight)
            ]

            ),
            
          ),
            
            
          ],
        ),
      ),

    );
    
  }
}
