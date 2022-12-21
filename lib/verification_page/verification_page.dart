import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosblood/hompage/hom_page.dart';
import 'package:sosblood/verification_page/widget/vfullnamefield.dart';
import 'package:sosblood/database/database.dart';

import '../auth/utils.dart';
import '../user/user.dart';
import 'widget/agefield.dart';
import 'widget/buttonconfirm.dart';
import 'widget/city.dart';
import 'widget/questionfield.dart';

enum Q1 { yes, no }

enum Q2 { yes, no }

enum Blood { ap, am, bp, bm, abp, abm, op, om }

class VerificationPage extends ConsumerStatefulWidget {
  const VerificationPage({super.key});

  @override
  ConsumerState<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends ConsumerState<VerificationPage> {
  Future<String>? fulnamefuture;
  TextEditingController fullname = TextEditingController();
  final age = TextEditingController();
  final city = TextEditingController();
  final _q3 = TextEditingController();
  final formkey = GlobalKey<FormState>();
  AUser? user;
  String dropdownvalue = 'Sexe';
  Q1? _q1 = Q1.no;
  Q2? _q2 = Q2.no;
  Blood? _b = Blood.ap;
  bool valuecheckbox = false;
  late Database database;
  @override
  void initState() {
    super.initState();
    database = ref.read(databaseProvider);
    fulnamefuture = database.getUserName(database.userId);
  }

  String bloodtype(Blood b) {
    String g;
    switch (b.toString()) {
      case "Blood.ap":
        {
          g = 'A+';
        }
        break;

      case "Blood.am":
        {
          g = 'A-';
        }
        break;

      case "Blood.bp":
        {
          g = 'B+';
        }
        break;

      case "Blood.bm":
        {
          g = 'B-';
        }

        break;
      case "Blood.abp":
        {
          g = 'AB+';
        }
        break;

      case "Blood.abm":
        {
          g = 'AB-';
        }
        break;
      case "Blood.o+":
        {
          g = 'O+';
        }
        break;

      case "Blood.o-":
        {
          g = 'O-';
        }
        break;

      default:
        {
          g = 'A+';
        }
        break;
    }
    return g;
  }

  @override
  Widget build(BuildContext context) {
    // double widthsize = MediaQuery.of(context).size.width;
    double heightsize = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: fulnamefuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            fullname.text = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                actions: const [],
                title: const Center(
                    child: Text(
                  'Blood Donor',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(children: [
                    SizedBox(
                      height: heightsize * 0.02,
                    ),
                    FullNameform(
                      controller: fullname,
                    ),
                    SizedBox(
                      height: heightsize * 0.02,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Flexible(
                          flex: 20,
                          child: Ageform(
                            controller: age,
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Flexible(
                          flex: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            height: 50.0,
                            width: 200.0,
                            child: DropdownButton(
                              isExpanded: true,
                              value: dropdownvalue,
                              focusColor: Colors.white,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Sexe',
                                  child: Text(
                                    'Sexe',
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'female',
                                  child: Text(
                                    'female',
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'male',
                                  child: Text(
                                    'male',
                                  ),
                                )
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                              style: const TextStyle(
                                  color: Color(0xff7A7C8B), fontSize: 16),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.02,
                    ),
                    CityForm(
                      controller: city,
                    ),
                    SizedBox(
                      height: heightsize * 0.02,
                    ),
                    Row(
                      children: const [
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          'Question 01 ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(
                          flex: 11,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.009,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Radio<Q1>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Q1.yes,
                          groupValue: _q1,
                          onChanged: (Q1? value) {
                            setState(() {
                              _q1 = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                        const Spacer(
                          flex: 5,
                        ),
                        Radio<Q1>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Q1.no,
                          groupValue: _q1,
                          onChanged: (Q1? value) {
                            setState(() {
                              _q1 = value;
                            });
                          },
                        ),
                        const Text('no'),
                        const Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.009,
                    ),
                    Row(
                      children: const [
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          'Question 02 ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(
                          flex: 11,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.009,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Radio<Q2>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Q2.yes,
                          groupValue: _q2,
                          onChanged: (Q2? value) {
                            setState(() {
                              _q2 = value;
                            });
                          },
                        ),
                        const Text('Yes'),
                        const Spacer(
                          flex: 5,
                        ),
                        Radio<Q2>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Q2.no,
                          groupValue: _q2,
                          onChanged: (Q2? value) {
                            setState(() {
                              _q2 = value;
                            });
                          },
                        ),
                        const Text('no'),
                        const Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.009,
                    ),
                    Row(
                      children: const [
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          'Question 03 ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(
                          flex: 11,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.009,
                    ),
                    QuestionField(
                      controller: _q3,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Radio<Blood>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Blood.ap,
                          groupValue: _b,
                          onChanged: (Blood? value) {
                            setState(() {
                              _b = value;
                            });
                          },
                        ),
                        const Text('A+'),
                        const Spacer(
                          flex: 5,
                        ),
                        Radio<Blood>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Blood.am,
                          groupValue: _b,
                          onChanged: (Blood? value) {
                            setState(() {
                              _b = value;
                            });
                          },
                        ),
                        const Text('A-'),
                        const Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.001,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Radio<Blood>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Blood.bp,
                          groupValue: _b,
                          onChanged: (Blood? value) {
                            setState(() {
                              _b = value;
                            });
                          },
                        ),
                        const Text('B+'),
                        const Spacer(
                          flex: 5,
                        ),
                        Radio<Blood>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Blood.bm,
                          groupValue: _b,
                          onChanged: (Blood? value) {
                            setState(() {
                              _b = value;
                            });
                          },
                        ),
                        const Text('B-'),
                        const Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.001,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Radio<Blood>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Blood.abp,
                          groupValue: _b,
                          onChanged: (Blood? value) {
                            setState(() {
                              _b = value;
                            });
                          },
                        ),
                        const Text('AB+'),
                        const Spacer(
                          flex: 5,
                        ),
                        Radio<Blood>(
                          activeColor: const Color(0xffDE2D2C),
                          value: Blood.abm,
                          groupValue: _b,
                          onChanged: (Blood? value) {
                            setState(() {
                              _b = value;
                            });
                          },
                        ),
                        const Text('AB-'),
                        const Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.001,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Checkbox(
                          fillColor:
                              const MaterialStatePropertyAll(Color(0xff0099A1)),
                          value: valuecheckbox,
                          onChanged: (value) {
                            setState(() {
                              valuecheckbox = value!;
                            });
                          },
                        ),
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff7A7C8B),
                                    fontWeight: FontWeight.w500),
                                children: [
                              TextSpan(text: 'I read and agree to '),
                              TextSpan(
                                text: 'the terms of use',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff0099A1),
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                        const Spacer(
                          flex: 12,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightsize * 0.001,
                    ),
                    ButtonConfirm(
                      name: 'Confirm',
                      onpressed: () {
                        if (dropdownvalue != 'Sexe' &&
                            formkey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: ((context) => const Center(
                                    child: CircularProgressIndicator(),
                                  )));
                          try {
                            AUser user = AUser(
                                isverifide: true,
                                age: int.parse(age.text),
                                sexe: dropdownvalue,
                                city: city.text,
                                q1: _q1.toString(),
                                q2: _q2.toString(),
                                q3: (_q3.text.isNotEmpty) ? _q3.text : 'null',
                                bloodType: bloodtype(_b!));

                            database.setDataForTheBlooddDonor(
                              user,
                            );
                            Utils.showSnackBargreen();

                            if (!mounted) return;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (Route<dynamic> route) => false);
                          } catch (e) {
                            Utils.showSnackBar(Future.error(e).toString());
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
