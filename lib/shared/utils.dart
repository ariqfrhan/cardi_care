import 'package:cardi_care/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
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
      return await docRef.get(const GetOptions(source: Source.server));
    }
  }

  static Future<String> getInitialRoute() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Routes.splash;
    }

    final prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('user_type');

    if (userType != null) {
      return _getUserRoute(userType);
    }

    try {
      if (await _checkUserExists('users', user.uid)) {
        await prefs.setString('user_type', 'user');
        return Routes.mainWrapper;
      }
      if (await _checkUserExists('keluarga', user.uid)) {
        await prefs.setString('user_type', 'keluarga');
        return Routes.keluargaWrapper;
      }
      if (await _checkUserExists('admin', user.uid)) {
        await prefs.setString('user_type', 'admin');
        return Routes.adminWrapper;
      }
    } catch (e) {
      print("Error checking user type: $e");
      if (userType != null) {
        return _getUserRoute(userType);
      }
      Routes.splash;
    }

    return Routes.splash;
  }

  static Future<bool> _checkUserExists(String collection, String uid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(collection)
          .doc(uid)
          .get();
      return doc.exists;
    } catch (e) {
      print("Error checking $collection: $e");
      return false;
    }
  }

  static String _getUserRoute(String userType) {
    switch (userType) {
      case 'user':
        return Routes.mainWrapper;
      case 'keluarga':
        return Routes.keluargaWrapper;
      case 'admin':
        return Routes.adminWrapper;
      default:
        return Routes.splash;
    }
  }

  static Future<String> fetchActor() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return "Please Login";
    }

    final prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('user_type');

    if (userType != null) {
      return userType;
    }

    try {
      if (await _checkUserExists('users', user.uid)) {
        await prefs.setString('user_type', 'user');
        return "user";
      }
      if (await _checkUserExists('keluarga', user.uid)) {
        await prefs.setString('user_type', 'keluarga');
        return "keluarga";
      }
      if (await _checkUserExists('admin', user.uid)) {
        await prefs.setString('user_type', 'admin');
        return "admin";
      }
    } catch (e) {
      print("Error fetching actor: $e");
    }

    return "";
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
