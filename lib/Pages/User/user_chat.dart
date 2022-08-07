import 'package:flutter/material.dart';

class user_chat extends StatefulWidget {
  const user_chat({ Key? key }) : super(key: key);

  @override
  State<user_chat> createState() => _user_chatState();
}

class _user_chatState extends State<user_chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.orange,
                                      child: MaterialButton(
                                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                          minWidth: MediaQuery.of(context).size.width,
                                          onPressed: () async {},
                                          child: const Text(
                                            "Cancel Transaction",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ),
          ]
          
        )
    )
    );
  }
}