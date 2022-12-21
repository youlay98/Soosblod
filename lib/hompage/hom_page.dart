import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sosblood/hompage/widget/search_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosblood/local_notification/local_notification.dart';

import '../auth/authstreampage.dart';
import 'widget/drop_down_button.dart';
import 'widget/blood_drop_down.dart';
import 'widget/list_veiw_blood_donor.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get.put(DataController(), permanet: true);
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotification.display(message);
    });
    LocalNotification.storeToken();
  }

  bool donnerSelected = true;
  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    double heightsize = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffED252F),
        onPressed: () {},
        child: Image.asset('assets/floatingbloodbutton.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: const [
          Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              backgroundColor: Color(0xff0099A1),
              radius: 40,
              child: Text(
                'YA',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ), //Text
            ),
          ),
        ],
        title: const Text(
          'Welcome',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: heightsize * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (() {
                    setState(() {
                      donnerSelected = true;
                    });
                  }),
                  child: Container(
                    width: widthsize / 2.6,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 5,
                            color: !donnerSelected
                                ? const Color(0xff0099A1).withOpacity(0)
                                : const Color(0xff0099A1)),
                      ),
                    ),
                    child: Text(
                      'Donors',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: !donnerSelected
                              ? Colors.grey
                              : const Color(0xff0099A1)),
                    ),
                  ),
                ),
                SizedBox(
                  width: widthsize / 10,
                ),
                GestureDetector(
                  onTap: (() {
                    setState(() {
                      donnerSelected = false;

                      FirebaseAuth.instance.signOut();
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const Loginandsigninpage()),
                        (Route<dynamic> route) => false);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 5,
                            color: donnerSelected
                                ? const Color(0xff0099A1).withOpacity(0)
                                : const Color(0xff0099A1)),
                      ),
                    ),
                    width: widthsize / 2.6,
                    child: Text(
                      'Applicant',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: donnerSelected
                              ? Colors.grey
                              : const Color(0xff0099A1)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const CityDopdown(),
                const SizedBox(
                  width: 20,
                ),
                const BloodDopdown(),
                const SizedBox(
                  width: 20,
                ),
                SearchButton(
                  onpressed: () {
                    ref.read(searchbuttoncileckedProvidere.notifier).state =
                        !ref.read(searchbuttoncileckedProvidere.notifier).state;
                  },
                )
              ],
            ),
            const SizedBox(
              width: 100,
            ),
            const Blooddoner()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.chat),
          //     label: 'Search',
          //     backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
