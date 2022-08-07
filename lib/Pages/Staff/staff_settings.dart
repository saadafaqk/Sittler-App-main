
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sittler_app/Controller-Provider/Staff-Controller/signin-signup-controller-staff.dart';

import 'package:sittler_app/Pages/Staff/Staff-EditProfile-Page.dart';

import '../../Controller-Provider/Theme-Controller/theme-controler-provider.dart';
import '../../Route-Navigator/route-navigator.dart';
import '../../Widgets/list-tiles.dart';
import '../../Widgets/sizebox.dart';
import '../Utils/darkmode.dart';

class staffsettings extends StatefulWidget {
  const staffsettings({ Key? key }) : super(key: key);

  @override
  State<staffsettings> createState() => _staffsettingsState();
}

class _staffsettingsState extends State<staffsettings> {
   User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("table-staff")
            .where('email', isEqualTo: user!.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          final currentUser = snapshot.data?.docs;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              // width: 300.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color:
                        Provider.of<ThemeManager>(context, listen: false).getDarkMode ==
                                true
                            ? Colors.black.withOpacity(1)
                            : Colors.white.withOpacity(1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 24),
                    child: Row(
                      children: [
                        Hero(
                          tag: "tag1",
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage("${currentUser![0]['imageUrl']}"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        addVerticalSpace(20),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${currentUser[0]['fullName']}",
                                style: const TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.circle,
                                size: 10,
                                color: Colors.green,
                                
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(20),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTiles.listTile(
                    label: "Edit Profile",
                    icon: IconButton(
                      icon: const Icon(Icons.account_circle),
                      color: const Color(0xff004aa0),
                      onPressed: () {},
                    ),
                    onTap: () {
                      RouteNavigator.gotoPage(context, const staffeditpage());
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTiles.listTile(
                    label: "Dark Mode",
                    icon: IconButton(
                      icon: const Icon(Icons.lightbulb),
                      color: const Color(0xff004aa0),
                      onPressed: () {},
                    ),
                    onTap: () {
                      RouteNavigator.gotoPage(context, const darkmode());
                    },
          
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTiles.listTile(
                    label: "Settings",
                    icon: IconButton(
                      icon: const Icon(Icons.message),
                      color: const Color(0xff004aa0),
                      onPressed: () {},
                    ),
                    onTap: () {},
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTiles.listTile(
                    label: "Sign Out",
                    icon: IconButton(
                      icon: const Icon(Icons.logout),
                      color: Colors.redAccent,
                      onPressed: () {},
                    ),
                    onTap: () {
                      SignUpSignInControllerStaff.logout(context);
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}