import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:sittler_app/Pages/Staff/staff_settings.dart';

import 'booking-list.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({Key? key}) : super(key: key);

  @override
  _StaffHomeState createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
     int _currentIndex = 0;
  final int _counter = 0;

final screens = [
Center(child: Text('Home', style: TextStyle(fontSize: 60),),),
const BookingList(),
const Center(child: Text('Chat', style: TextStyle(fontSize: 60),),),
const staffsettings(),
];

  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    //context.read<SignUpSignInController>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    DateTime backpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        backpress = DateTime.now();
        if (cantExit) {
          Fluttertoast.showToast(msg: 'Press Back button again to Exit');

          return false;
        } else {
          SystemNavigator.pop();

          return true;
        }
      },
      child: Scaffold(
        key: _key,
        
        // appBar: AppBar(
        //   //automaticallyImplyLeading: false, //remove arrow back icon
        //   centerTitle: true,
        //   title: const Text("Staff Home"),

        //   actions: [
        //     Switch(
        //         value: isDark,
        //         onChanged: (newValue) {
        //           context.read<ThemeManager>().toggleTheme(newValue);
        //         })
        //   ],
        // ),
        appBar: AppBar(
            centerTitle: false,
            
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xff004aa0),
            elevation: 0,
            
          ),

          body: 
        // drawer: const StaffDrawer(),
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection("table-staff")
        //       .where('email', isEqualTo: user!.email)
        //       .snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        //     final currentUser = snapshot.data?.docs;

        //     if (snapshot.hasData) {
        //       return Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             addVerticalSpace(10),
        //             Text(
        //               'Hi ' '${currentUser![0]['fullName']}',
        //               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //             ),
        //             // addVerticalSpace(50),
        //             // ElevatedButtonStyle.elevatedButton("List of Sittlers", onPressed: () {
        //             //   RouteNavigator.gotoPage(context, BookAnAppointment());
        //             // }),
        //           ],
        //         ),
        //       );
        //       //   Container(
        //       //   height: 400,
        //       //   child: GridView(
        //       //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       //           crossAxisCount: 3, mainAxisSpacing: 16, crossAxisSpacing: 16),
        //       //       children: [
        //       //         Image.network('https://picsum.photos/250?image=1'),
        //       //         Image.network('https://picsum.photos/250?image=2'),
        //       //         Image.network('https://picsum.photos/250?image=3'),
        //       //         Image.network('https://picsum.photos/250?image=1'),
        //       //         Image.network('https://picsum.photos/250?image=2'),
        //       //         Image.network('https://picsum.photos/250?image=3'),
        //       //       ]),
        //       // );
        //     } else {
        //       return const Center(
        //           child: CircularProgressIndicator(
        //         color: Colors.black,
        //       ));
        //     }
        //   },
        // ),

        screens[_currentIndex],
    

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xff004aa0),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.apps),
            title: const Text('Home'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.people),
            title: const Text('Bookings'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.message),
            title: const Text('Chat',),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      ),
    );
  }
}
