import 'package:flutter/material.dart';

class CustomTherapistCard extends StatelessWidget {
  const CustomTherapistCard({
    Key? key,
    required this.name,
    required this.JobTitle,
    required this.experince,
    required this.date,
    required this.arabic,
    required this.english,
    required this.TherapistAvatar,
    this.onReject,
    this.onAccept,
    this.cardClick,
  }) : super(key: key);

  final String name;
  final String JobTitle;
  final String experince;
  final String date;
  final String TherapistAvatar;
  final bool arabic;
  final bool english;
  final onReject;
  final onAccept;
  final cardClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: cardClick,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 7,
          child: Container(
              child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Image.asset(TherapistAvatar),
                            ),
                            const SizedBox(
                              width: 10, //
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      JobTitle,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 117, 147, 171)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.assignment_ind_rounded,
                                size: 17,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "سنوات الخبرة :",
                                    style: TextStyle(
                                        fontFamily: 'Cairo', fontSize: 14),
                                  ),
                                  Text(
                                    experince,
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.menu_book_rounded,
                                size: 17,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "اللغات: ",
                                    style: TextStyle(
                                        fontFamily: 'Cairo', fontSize: 14),
                                  ),
                                  if (arabic)
                                    const Text(
                                      "العربية",
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  if (english)
                                    const Text(
                                      "الانجليزية",
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 120,
                              child: Material(
                                color: Colors.black87,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: MaterialButton(
                                    splashColor: Colors.black,
                                    child: const Text(
                                      "قبول",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    onPressed: onAccept),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 45,
                              width: 120,
                              child: Material(
                                color: Colors.red.shade900,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: MaterialButton(
                                    splashColor: Colors.black,
                                    child: const Text(
                                      "رفض",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    onPressed: onReject),
                              ),
                            )
                          ]),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}

Future<void> showAlertDialog({
  required BuildContext context,
  required String name,
  required String JobTitle,
  required String email,
  required String experience,
  required String duration,
  required bool arabic,
  required bool english,
  required bool inCenter,
  required String GeneralInfo,
  required String TherapistAvatar,
  required onAccept,
  required onReject,
}) async {
  String languages = arabic ? "العربية" : "";
  languages = english ? "$languages الانجليزية" : languages;

  String inCenter = arabic ? "في المركز" : "";
  inCenter = english ? "$inCenter عن بعد" : inCenter;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30)),
              height: MediaQuery.of(context).size.height / 1.4,
              width: double.infinity,
              child: Container(
                clipBehavior: Clip.none,
                padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width / 1.1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      JobTitle,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(85, 158, 158, 158),
                    ),
                    FittedBox(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRowForDialog(
                                  icon: Icons.assignment_ind_rounded,
                                  subtitle: experience,
                                  title: "سنوات الخبرة:",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomRowForDialog(
                                  icon: Icons.menu_book_rounded,
                                  subtitle: inCenter,
                                  title: "يقدم استشارات:",
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRowForDialog(
                                  icon: Icons.assignment_ind_rounded,
                                  subtitle: languages,
                                  title: "اللغات:",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomRowForDialog(
                                    icon: Icons.menu_book_rounded,
                                    subtitle: duration,
                                    title: "مدة الجلسة بالدقائق:"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    FittedBox(
                        child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding:
                          const EdgeInsets.only(top: 13, right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "نبذة عن المختص",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                    FittedBox(
                        child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Text(GeneralInfo),
                    )),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 120,
                              child: Material(
                                color: Colors.black87,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: MaterialButton(
                                    splashColor: Colors.black,
                                    onPressed: onAccept,
                                    child: const Text(
                                      "قبول",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              height: 45,
                              width: 120,
                              child: Material(
                                color: Colors.red.shade900,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: MaterialButton(
                                    splashColor: Colors.black,
                                    onPressed: onReject,
                                    child: const Text(
                                      "رفض",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )),
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.none,
              child: CircleAvatar(
                radius: 40,
                child: Image.asset(TherapistAvatar),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class CustomRowForDialog extends StatelessWidget {
  const CustomRowForDialog({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        )
      ],
    );
  }
}
