import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sittler_app/Model/book-model.dart';
import 'package:http/http.dart' as http;
import 'package:sittler_app/Widgets/sizebox.dart';

class ChatToStaff extends StatefulWidget {
  final BookModel staffInfo;
  const ChatToStaff({required this.staffInfo});

  @override
  _ChatToStaffState createState() => _ChatToStaffState();
}

class _ChatToStaffState extends State<ChatToStaff> {
  User? user = FirebaseAuth.instance.currentUser;

  final messageTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void sendPushMessage(String token, String title, String body) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAK-9tvqM:APA91bFSuuKsJVoTuNC19D_Tg1QkmW2Cfbfop879_daYGyvQYOa3zWBP2qcQwRfUPf5UVsJ01-xc6ZTfnz5cBjrkRQRRUPRshiflERqjCdU5byGIoHma8XrVuO2HPEE4FHCWUyTW5D9X',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  void onSendMessage(String? content, int? type) async {
    await FirebaseFirestore.instance
        .collection('table-chat')
        .doc(widget.staffInfo.id.toString())
        .set({
      'sender': user!.email,
      'reciever': widget.staffInfo.userStaff!['email'],
      'id': user!.uid,
    }).then((value) {
      FirebaseFirestore.instance
          .collection("table-chat")
          .doc(widget.staffInfo.id.toString())
          .collection("messages")
          .add({
        'sender': user!.email,
        'text': content,
        "type": type,
        "timestamp": DateTime.now().millisecondsSinceEpoch
      });
    });
    //Clear Text Field
    messageTextController.text = "";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xff004aa0),
            elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.staffInfo.userStaff!['imageUrl'].toString()),
                // Image.network(widget.staffInfo.userStaff!['imageUrl'].toString()),
              ),
              addHorizontalSpace(15),
              Text(widget.staffInfo.userStaff!['fullName']),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: StreamBuilder<QuerySnapshot?>(
                  stream: FirebaseFirestore.instance
                      .collection("table-chat")
                      .doc(widget.staffInfo.id)
                      .collection("messages")
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          reverse: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            //final bookingData = snapshot.data!.docs[index];

                            final DocumentSnapshot bookingData =
                                snapshot.data!.docs[index];

                            return Align(
                              alignment: bookingData['sender'] == user!.email
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    bookingData['text'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: bookingData['sender'] == user!.email
                                            ? Colors.black
                                            : Colors.blue),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Text("Empty Chat Message...");
                    }
                  }),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  color: Colors.black26,
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: messageTextController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                onSendMessage(messageTextController.text, 0);
                                sendPushMessage(
                                    widget.staffInfo.userStaff!['token'],
                                    widget.staffInfo.userModel!['fullName'],
                                    messageTextController.text);
                              },
                              icon: const Icon(Icons.send)),
                          hintText: "Write message...",
                          hintStyle: const TextStyle(color: Colors.white60),
                          filled: true,
                          fillColor: Colors.blueGrey,
                          border: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,

                            //borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}
