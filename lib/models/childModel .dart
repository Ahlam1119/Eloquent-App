import 'package:cloud_firestore/cloud_firestore.dart';

class ChildModel {
  final String uidParent;
  final String uid;
  final String name;
  final String ParentName;
  final DateTime BirthDate;
  final String ChildEducationalLevel;
  final String? Movement;
  final String? personalBehaviour;
  final String? emotionalBehaviour;
  final String? understanding;
  final String? dispersion;
  final String? visualCommunication;
  final String? Agressive;
  final String? fear;
  final String? cooperating;
  final String? visualCondition;
  final String? auditoryCondition;
  final String? expressionLevel;
  final String? LetteringLevel;
  final String? MotionClassification;
  final String? physicalGrowth;
  final String? chronicDiseases;
  final String? previousTreatment;
  final String? checkUp;
  final String? Surgery;
  final String? DefiningIntelligence;
  final String? sensitive;
  //الصفات الشخصية والسلوكية

  //الانتباه

  //الفهم والاستيعاب

  //التواصل

  //سلوك عدواني

  //خوف او قلق

  //متعاون

  //التواصل البصري

  //الحالة السمعية

  //التعبير

  //مخارج الحروف

  //تصنيف الحركة

  //النمو الجسمي

  //الامراض المزمنة

  final String chronicdiseasesOtherField;

  final String previoustreatmentYesField;

  //نحط تيكست فيلد
  // الفحوصات والعمليات

  final String CheckupsYesField;

  final String SurgeryYesField;

  final String IntelligencetestYesField;

  final String allergyYesField;
  final String ChildAvatar;

  const ChildModel({
    required this.uidParent,
    required this.ParentName,
    required this.name,
    required this.uid,
    required this.BirthDate,
    required this.ChildEducationalLevel,
    required this.Movement,
    required this.personalBehaviour,
    required this.emotionalBehaviour,
    required this.understanding,
    required this.dispersion,
    required this.visualCommunication,
    required this.Agressive,
    required this.fear,
    required this.cooperating,
    required this.visualCondition,
    required this.auditoryCondition,
    required this.expressionLevel,
    required this.LetteringLevel,
    required this.MotionClassification,
    required this.physicalGrowth,
    required this.chronicDiseases,
    required this.previousTreatment,
    required this.checkUp,
    required this.Surgery,
    required this.DefiningIntelligence,
    required this.sensitive,
    required this.chronicdiseasesOtherField,
    required this.previoustreatmentYesField,
    required this.CheckupsYesField,
    required this.SurgeryYesField,
    required this.IntelligencetestYesField,
    required this.allergyYesField,
    required this.ChildAvatar,
  });
  //(fetch data from firebase ) data from the database will converted and store in this model to use in the app
  factory ChildModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) =>
      ChildModel(
        ParentName: json['ParentName'],
        uidParent: json['uidParent'],
        uid: json['uid'],
        name: json['name'],
        BirthDate: json['BirthDate'],
        ChildEducationalLevel: json['ChildEducationalLevel'],
        Movement: json['Movement'],
        personalBehaviour: json['personalBehaviour'],
        emotionalBehaviour: json['emotionalBehaviour'],
        understanding: json['understanding'],
        dispersion: json['dispersion'],
        visualCommunication: json['visualCommunication'],
        Agressive: json['Agressive'],
        fear: json['fear'],
        cooperating: json['cooperating'],
        visualCondition: json['visualCondition'],
        auditoryCondition: json['auditoryCondition'],
        expressionLevel: json['expressionLevel'],
        LetteringLevel: json['LetteringLevel'],
        MotionClassification: json['MotionClassification'],
        physicalGrowth: json['physicalGrowth'],
        chronicDiseases: json['chronicDiseases'],
        previousTreatment: json['previousTreatment'],
        checkUp: json['checkUp'],
        Surgery: json['Surgery'],
        DefiningIntelligence: json['DefiningIntelligence'],
        sensitive: json['sensitive'],
        chronicdiseasesOtherField: json['chronicdiseasesOtherField'],
        previoustreatmentYesField: json['previoustreatmentYesField'],
        CheckupsYesField: json['CheckupsYesField'],
        SurgeryYesField: json['SurgeryYesField'],
        IntelligencetestYesField: json['IntelligencetestYesField'],
        allergyYesField: json['allergyYesField'],
        ChildAvatar: json['ChildAvatar'],
      );

  //(send data to firebase )data  will converted and store in data base

  Map<String, dynamic> toJson() => {
        'ParentName': ParentName,
        'uidParent': uidParent,
        'uid': uid,
        'name': name,
        'BirthDate': BirthDate,
        'ChildEducationalLevel': ChildEducationalLevel,
        'chronicdiseasesOtherField': chronicdiseasesOtherField,
        'previoustreatmentYesField': previoustreatmentYesField,
        'CheckupsYesField': CheckupsYesField,
        'SurgeryYesField': SurgeryYesField,
        'IntelligencetestYesField': IntelligencetestYesField,
        'allergyYesField': allergyYesField,
        'Movement': Movement,
        'personalBehaviour': personalBehaviour,
        'emotionalBehaviour': emotionalBehaviour,
        'understanding': understanding,
        'dispersion': dispersion,
        'visualCommunication': visualCommunication,
        'Agressive': Agressive,
        'fear': fear,
        'cooperating': cooperating,
        'visualCondition': visualCondition,
        'auditoryCondition': visualCondition,
        'expressionLevel': expressionLevel,
        'LetteringLevel': LetteringLevel,
        'MotionClassification': MotionClassification,
        'physicalGrowth': physicalGrowth,
        'chronicDiseases': chronicDiseases,
        'previousTreatment': previousTreatment,
        'checkUp': checkUp,
        'Surgery': Surgery,
        'DefiningIntelligence': DefiningIntelligence,
        'sensitive': sensitive,
        'ChildAvatar': ChildAvatar
      };

  // factory ChildModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return ChildModel(
  //       ParentName: data['ParentName'],
  //       uidParent: data['uidParent'],
  //       uid: data['uid'],
  //       name: data['name'],
  //       BirthDate: data['BirthDate'],
  //       ChildEducationalLevel: data['ChildEducationalLevel'],

  //       chronicdiseasesOtherField: data['chronicdiseasesOtherField'],

  //       previoustreatmentYesField: data['previoustreatmentYesField'],

  //       CheckupsYesField: data['CheckupsYesField'],

  //       SurgeryYesField: data['SurgeryYesField'],

  //       IntelligencetestYesField: data['IntelligencetestYesField'],

  //       allergyYesField: data['allergyYesField'],

  //  );

}



//          'Movement'
// 'personalBehaviour'
//   'emotionalBehaviour'
//   'understanding'
//   'dispersion'
//  'visualCommunication'
//   'Agressive'
//  'fear'
//   'cooperating'
//    'visualCondition'
// 'auditoryCondition'
//  'expressionLevel'
//  'LetteringLevel'
//  'MotionClassification'
//  'physicalGrowth'
//  'chronicDiseases'
//  'previousTreatment'
//  'checkUp'
//  'Surgery'
//  'DefiningIntelligence'
//  'sensitive'
         