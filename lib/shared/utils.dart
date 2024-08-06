import 'package:cardi_care/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Utils {
  static DateTime convertToDateTime(String date) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.parse(date);
  }

  static String convertToDayFormat(DateTime date) {
    DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String convertToHourFormat(DateTime date) {
    DateFormat formatter = DateFormat('HH.mm');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String formatDateJanjiTemu(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd MMMM yyyy - HH.mm');
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static String getWaktu(DateTime dateTime) {
    int hour = dateTime.hour;
    if (hour >= 7 && hour < 12) {
      return 'Pagi';
    } else if (hour >= 12 && hour < 15) {
      return 'Siang';
    } else if (hour >= 15 && hour < 19) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  static Future<DocumentSnapshot> getDocumentWithCache(
      DocumentReference docRef) async {
    try {
      DocumentSnapshot doc =
          await docRef.get(const GetOptions(source: Source.cache));
      if (doc.exists) {
        return doc;
      }

      return await docRef.get(const GetOptions(source: Source.server));
    } catch (e) {
      return await docRef.get(const GetOptions(source: Source.cache));
    }
  }

  static Future<String> getInitialRoute() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Routes.splash;
    }

    try {
      DocumentSnapshot userSnapshot = await getDocumentWithCache(
          FirebaseFirestore.instance.collection('users').doc(user.uid));

      if (userSnapshot.exists) {
        return Routes.mainWrapper;
      }

      DocumentSnapshot keluargaSnapshot = await getDocumentWithCache(
          FirebaseFirestore.instance.collection('keluarga').doc(user.uid));

      if (keluargaSnapshot.exists) {
        return Routes.keluargaWrapper;
      }

      DocumentSnapshot adminSnapshot = await getDocumentWithCache(
          FirebaseFirestore.instance.collection('admin').doc(user.uid));

      if (adminSnapshot.exists) {
        return Routes.adminWrapper;
      }
    } catch (e) {
      return Routes.splash;
    }

    return Routes.splash;
  }
}

Future<XFile?> selectGalleryImage() async {
  XFile? selectedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  return selectedImage;
}

Future<XFile?> selectCameraImage() async {
  XFile? selectedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);
  return selectedImage;
}
