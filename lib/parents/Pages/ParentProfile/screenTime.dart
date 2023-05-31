import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenTimeManagement extends StatelessWidget {
  final String childId;

  const ScreenTimeManagement({super.key, required this.childId});
  Future<void> _saveScreenTime(Duration duration) async {
    await FirebaseFirestore.instance.collection('screenTime').doc(childId).set({
      'duration': duration.inMinutes,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getScreenTime() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      // this is for making the finishing animation looks smooth, you can remove it if you don't like it.
    );
    return FirebaseFirestore.instance
        .collection('screenTime')
        .doc(childId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Duration> duration =
        ValueNotifier(const Duration(minutes: 45));

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      elevation: 20,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Text(
            'إدارة وقت الشاشة',
            style: TextStyle(
              color: Color(0xff394445),
              fontSize: 18,
              fontFamily: "Cairo",
              fontWeight: FontWeight.w600,
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 750),
            curve: Curves.fastLinearToSlowEaseIn,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Child')
                  .doc(childId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff394445),
                      ),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Text(
                    'لايوجد طفل مسجل!',
                    style: TextStyle(
                      color: Color(0xff6888a0),
                      fontSize: 12,
                      fontFamily: "Cairo",
                    ),
                  );
                }
                final Map<String, dynamic> data = snapshot.data!.data()!;
                final String childName = data['name'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'يمكنك بسهولة تعيين حدود زمنية ل$childName لتجنب الاستخدام المفرط.',
                      style: const TextStyle(
                        color: Color(0xff6888a0),
                        fontSize: 12,
                        fontFamily: "Cairo",
                      ),
                    ),
                    const Divider(),
                    FutureBuilder(
                      future: getScreenTime(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Padding(
                            padding: EdgeInsets.all(50.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff394445),
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData && snapshot.data!.exists) {
                          duration.value = Duration(
                              minutes: snapshot.data!.data()!['duration']);
                        }
                        return Column(
                          children: [
                            Localizations.override(
                              context: context,
                              locale: const Locale('en'),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Theme(
                                  data: ThemeData(
                                    cupertinoOverrideTheme:
                                        const CupertinoThemeData(
                                      textTheme: CupertinoTextThemeData(
                                        pickerTextStyle: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff394445),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: duration.value,
                                    onTimerDurationChanged: (value) =>
                                        duration.value = value,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                            Center(
                              child: ValueListenableBuilder(
                                valueListenable: duration,
                                child: const Text(
                                  'حفظ وقت الشاشة',
                                  style: TextStyle(
                                    fontFamily: "Cairo",
                                  ),
                                ),
                                builder: (context, Duration duration,
                                    Widget? child) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (duration.inMinutes == 0) return;
                                      await _saveScreenTime(duration);
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff394445)),
                                    child: child,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
