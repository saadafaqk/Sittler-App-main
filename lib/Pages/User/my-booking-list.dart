import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sittler_app/Model/book-model.dart';
import 'package:sittler_app/Pages/User/chat-to-staff.dart';
import 'package:sittler_app/Route-Navigator/route-navigator.dart';

class MyBookingList extends StatefulWidget {
  const MyBookingList({Key? key}) : super(key: key);

  @override
  _MyBookingListState createState() => _MyBookingListState();
}

class _MyBookingListState extends State<MyBookingList> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //       centerTitle: true,
      //       backgroundColor: Colors.white,
      //       foregroundColor: const Color(0xff004aa0),
      //       elevation: 0,
      //     ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("table-book")
            .where('userModel.uid', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final userStaff = snapshot.data!.docs[index];
                  final DocumentSnapshot bookingData = snapshot.data!.docs[index];

                  return Card(
                    elevation: 1,
                    child: ListTile(
                      leading: Image.network(
                        userStaff.get('userStaff.imageUrl'),
                      ),
                      title: Text(userStaff.get('userStaff.fullName')),
                      subtitle: Text(userStaff.get('userStaff.email')),
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            elevation: 20,
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue,
                                      child: MaterialButton(
                                          padding:
                                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                          minWidth: MediaQuery.of(context).size.width,
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            RouteNavigator.gotoPage(
                                                context,
                                                ChatToStaff(
                                                    staffInfo: BookModel.fromMap(
                                                        userStaff.data())));
                                          },
                                          child: const Text(
                                            "Send Message",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                      child: MaterialButton(
                                          padding:
                                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                          minWidth: MediaQuery.of(context).size.width,
                                          onPressed: () async {},
                                          child: const Text(
                                            "Edit Booking",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  );
                });
          } else {
            return const Text("No Data");
          }
        },
      ),
    );
  }
}
