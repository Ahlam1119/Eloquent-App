import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eloquentapp/models/blogs.dart';
import 'package:eloquentapp/models/childModel%20.dart';
import 'package:eloquentapp/models/parentModel.dart';
import 'package:eloquentapp/models/therapistModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class for parent

// create a new user with an email an password
class FirebaseHelperParent {
  const FirebaseHelperParent._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> saveUser(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) {
        return false;
      }
      //Add parent ditals to firestore
      var parentRef = _db.collection('Parent').doc(credential.user!.uid);

      final parentModel = ParentModel(
          name: name,
          email: email,
          phone: phone,
          pass: password,
          uid: credential.user!.uid);

      await parentRef.set(parentModel.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }
}

//---------------------------------------------------------------------------------------
//class for therapist

// class FirebaseHelperTherapist {
//   const FirebaseHelperTherapist._();

// //this function is to create a new user with an email an password

//   static final FirebaseAuth _auth =
//       FirebaseAuth.instance; //this is instance  from firebase auth
//   static final FirebaseFirestore _db =
//       FirebaseFirestore.instance; //this is instance  from firebase Cloud

//   static Future<bool> saveUser(
//       {required String email,
//       required String password,
//       required String name,
//       required String phone,
//       required String GeneralInfo,
//       required String YearsofExperience,
//       required String duration,
//       required bool arabicLanguage,
//       required bool englishLanguage,
//       required bool incenter,
//       required bool online}) async {
//     try {
//       final UserCredential credential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       if (credential.user == null) {
//         return false;
//       }
//       //Add therapist ditals to firestore
//       var theraRef = _db.collection('Therapist').doc(credential.user!.uid);

//       final therapistModel = TherapistModel(
//           name: name,
//           email: email,
//           phone: phone,
//           pass: password,
//           uid: credential.user!.uid,
//           GeneralInfo: GeneralInfo,
//           YearsofExperience: YearsofExperience,
//           duration: duration,
//           arabicLanguage: arabicLanguage,
//           englishLanguage: englishLanguage,
//           incenter: incenter,
//           online: online);

//       await theraRef.set(therapistModel.toJson());

//       return true;
//     } catch (e) {
//       //her add code to show user ther is somthing wrong
//       return false;
//     }
//   }

//   static Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews =>
//       _db.collection("Therapist").snapshots();

//   // Stream<List<TherapistModel>> readUser()=> Fi

// }

//therpist

class FirebaseHelperTherapist {
  const FirebaseHelperTherapist._();

//this function is to create a new user with an email an password

  static final FirebaseAuth _auth =
      FirebaseAuth.instance; //this is instance  from firebase auth
  static final FirebaseFirestore _db =
      FirebaseFirestore.instance; //this is instance  from firebase Cloud

  static Future<bool> saveUser(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String GeneralInfo,
      required String YearsofExperience,
      required String duration,
      required String JobTitle,
      required bool arabicLanguage,
      required bool englishLanguage,
      required bool incenter,
      required bool online,
      required bool active,
      required String centerid,
      required String centerName,
      required String TherapistAvatar}) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) {
        return false;
      }
      //Add therapist ditals to firestore
      var theraRef = _db.collection('Therapist').doc(credential.user!.uid);

      final therapistModel = TherapistModel(
          name: name,
          email: email,
          phone: phone,
          pass: password,
          uid: credential.user!.uid,
          GeneralInfo: GeneralInfo,
          YearsofExperience: YearsofExperience,
          duration: duration,
          arabicLanguage: arabicLanguage,
          englishLanguage: englishLanguage,
          incenter: incenter,
          online: online,
          JobTitle: JobTitle,
          time: FieldValue.serverTimestamp(),
          active: active,
          centerid: centerid,
          centerName: centerName,
          TherapistAvatar: TherapistAvatar);

      await theraRef.set(therapistModel.toJson());

      return true;
    } catch (e) {
      //her add code to show user ther is somthing wrong
      return false;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews =>
      _db.collection("Therapist").snapshots();

  // Stream<List<TherapistModel>> readUser()=> Fi
}

class FirebaseHelperChild {
  const FirebaseHelperChild._();

//this function is to create a new user with an email an password

  static final FirebaseAuth _auth =
      FirebaseAuth.instance; //this is instance  from firebase auth
  static final FirebaseFirestore _db =
      FirebaseFirestore.instance; //this is instance  from firebase Cloud

  static Future<bool> saveUser({
    required String uidParent,
    required String name,
    required String ParentName,
    required String uid,
    required DateTime BirthDate,
    required String ChildEducationalLevel,
    required String chronicdiseasesOtherField,
    required String previoustreatmentYesField,
    required String CheckupsYesField,
    required String SurgeryYesField,
    required String IntelligencetestYesField,
    required String allergyYesField,
    required Movement,
    required personalBehaviour,
    required emotionalBehaviour,
    required understanding,
    required dispersion,
    required visualCommunication,
    required Agressive,
    required fear,
    required cooperating,
    required visualCondition,
    required auditoryCondition,
    required expressionLevel,
    required LetteringLevel,
    required MotionClassification,
    required physicalGrowth,
    required chronicDiseases,
    required previousTreatment,
    required checkUp,
    required Surgery,
    required DefiningIntelligence,
    required sensitive,
    required String ChildAvatar,
  }) async {
    // Add child ditals to firestore
    var childRef = _db.collection('Child');

    final childModel = ChildModel(
        ParentName: ParentName,
        uidParent: uidParent,
        uid: uid,
        name: name,
        BirthDate: BirthDate,
        ChildEducationalLevel: ChildEducationalLevel,
        chronicdiseasesOtherField: chronicdiseasesOtherField,
        previoustreatmentYesField: previoustreatmentYesField,
        CheckupsYesField: CheckupsYesField,
        SurgeryYesField: SurgeryYesField,
        IntelligencetestYesField: IntelligencetestYesField,
        allergyYesField: allergyYesField,
        Movement: Movement,
        personalBehaviour: personalBehaviour,
        emotionalBehaviour: emotionalBehaviour,
        understanding: understanding,
        dispersion: dispersion,
        visualCommunication: visualCommunication,
        Agressive: Agressive,
        fear: fear,
        cooperating: cooperating,
        visualCondition: visualCondition,
        auditoryCondition: auditoryCondition,
        expressionLevel: expressionLevel,
        LetteringLevel: LetteringLevel,
        MotionClassification: MotionClassification,
        physicalGrowth: physicalGrowth,
        chronicDiseases: chronicDiseases,
        previousTreatment: previousTreatment,
        checkUp: checkUp,
        Surgery: Surgery,
        DefiningIntelligence: DefiningIntelligence,
        sensitive: sensitive,
        ChildAvatar: ChildAvatar);
    try {
      await childRef.doc(uid).set(childModel.toJson());

      return true;
    } catch (e) {
      //  her add code to show user ther is somthing wrong
      return false;
    }
  }
}

class bolgHelper {
  const bolgHelper._();

// this function is to create a new user with an email an password

  static final FirebaseAuth _auth =
      FirebaseAuth.instance; //this is instance  from firebase auth
  static final FirebaseFirestore _db =
      FirebaseFirestore.instance; //this is instance  from firebase Cloud

  static Future<bool> saveUser(
      {required String ParentName,
      required String Parentuid,
      required String blog,
      required String blogTitle,
      required String uid,
      required String image}) async {
    // Add child ditals to firestore
    var blogRef = _db.collection('blog');

    final blogParameter = BolgsModel(
        ParentName: ParentName,
        Parentuid: Parentuid,
        uid: uid,
        blog: blog,
        blogTitle: blogTitle,
        image: image);
    try {
      await blogRef.add(blogParameter.toJson());

      return true;
    } catch (e) {
      //  her add code to show user ther is somthing wrong
      return false;
    }
  }
}
