import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lexiquest/Data/Repositories/sharedpreferences.dart';
import '../../Model/usermodel.dart';

class Authrepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign up/Create account
  Future<Usermodel?> signUp(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      Usermodel UserModel = Usermodel(
        uid: user!.uid,
        username: username,
        email: email,
      );

      await _db.collection('users').doc(user.uid).set(UserModel.toMap());
      await Sharedpreferences.saveUserId(user.uid);

      return UserModel;
    } catch (e) {
      print("sign up Failed");
      return null;
    }
  }

  // login
  Future<Usermodel?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      DocumentSnapshot doc = await _db.collection('users').doc(user!.uid).get();
      await Sharedpreferences.saveUserId(user.uid);

      return Usermodel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print("login error");
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await Sharedpreferences.clear();
  }

  Future<String?> getCurrentUid() async {


    return Sharedpreferences.getUserId();
  }
}
