import 'package:flutter/material.dart';

import 'auth/widget/button.dart';
import 'verification_page/verification_page.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  bool isclicked1 = false;
  bool isclicked2 = false;

  @override
  Widget build(BuildContext context) {
    double withdSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            const Center(
                child: Text(
              'Choose the right user\n         type you\'re',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            const Spacer(
              flex: 2,
            ),
            Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isclicked1 = true;
                      isclicked2 = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (isclicked1)
                                ? const Color(0xff0099A1)
                                : const Color(0xff0099A1).withOpacity(0.0),
                            width: 2.5),
                        color: (isclicked1)
                            ? Colors.white
                            : const Color(0xff0099A1).withOpacity(0.05),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    width: withdSize / 3,
                    height: heightSize / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Image.asset('assets/donnor.png'),
                        const Spacer(
                          flex: 1,
                        ),
                        const Text(
                          'Blood Donor',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0099A1)),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: (() => setState(() {
                        isclicked2 = true;
                        isclicked1 = false;
                      })),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (isclicked2)
                                ? const Color(0xffEA2429)
                                : const Color(0xffEA2429).withOpacity(0.0),
                            width: 2.5),
                        color: (isclicked2)
                            ? Colors.white
                            : const Color(0xffEA2429).withOpacity(0.05),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    width: withdSize / 3,
                    height: heightSize / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Image.asset('assets/blood.png'),
                        const Spacer(
                          flex: 1,
                        ),
                        const Text(
                          'Blood Needed',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffEA2429)),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Button(
              name: 'submit',
              onpressed: (() {
                if (isclicked1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerificationPage()),
                  );
                }
                // FirebaseAuth.instance.signOut();
              }),
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
