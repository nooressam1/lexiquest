import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Data/Repositories/Firebase/authrepository.dart';
import 'package:lexiquest/Data/Repositories/Firebase/firebaseuserrepository.dart';
import 'package:lexiquest/Data/Repositories/Sqlite/sqliteuserrespository.dart';
import 'package:lexiquest/Data/Repositories/sharedpreferences.dart';
import 'package:lexiquest/Data/Repositories/userrepository.dart';

class Authviewmodel extends ChangeNotifier {
  final authservice = Authrepository();
  final userservice = FirebaseUserRepository();

  final localDB = Sqliteuserrespository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  Future<Usermodel?> signUp(
    String email,
    String password,
    String username,
  ) async {
    isLoading = true;
    notifyListeners();

    final user = await authservice.signUp(email, password, username);

    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<Usermodel?> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final user = await authservice.login(email, password);

    isLoading = false;
    notifyListeners();
    return user;
  }

  Future<Usermodel?> autoLogin() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      final userFromCloud = await userservice.fetchUserbyId(firebaseUser.uid);
      print("Testing 1: ${userFromCloud}");

      if (userFromCloud != null) {
        await localDB.updateUser(userFromCloud);
        print("Auto-login: User found in Firebase: ${firebaseUser.uid}");
        return userFromCloud;
      }
    }

    final localUid =
        await Sharedpreferences.getUserId(); // method to get locally saved UID
    print("Testing 2: ${localUid}");

    if (localUid != null) {
      final userFromLocal = await localDB.fetchUserbyId(localUid as String);
      print("Testing 3: ${userFromLocal}");

      if (userFromLocal != null) {
        print("Auto-login: User found locally: $localUid");
        return userFromLocal;
      }
    }

    print("Auto-login: No user found");
    return null;
  }
}
