import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Data/Repositories/userrepository.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';

class FirebaseUserRepository implements Userrepository {
  final FirebaseFirestore _firestore;

  FirebaseUserRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Usermodel?> fetchUserbyId(String uid) async {
    final snapshot = await _firestore.collection("users").doc(uid).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return Usermodel.fromMap(snapshot.data()!);
  }

  @override
  Future<List<Usermodel>> fetchAllUsers() async {
    final snapshot = await _firestore.collection("users").get();
    print('Fetched ${snapshot.docs.length} users from Firestore');
    if (snapshot.docs.isEmpty) return [];

    return snapshot.docs
        .map((doc) => Usermodel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> createUser(Usermodel usermodel) async {
    await _firestore
        .collection("users")
        .doc(usermodel.uid)
        .set(usermodel.toMap());
  }

  @override
  Future<void> updateUser(Usermodel usermodel) async {
    await _firestore
        .collection("users")
        .doc(usermodel.uid)
        .update(usermodel.toMap());
  }

  @override
  Future<void> addXp(String userId, int amount) async {
    final user = await fetchUserbyId(userId);
    if (user == null) return;
    final newXp = user.userXp + amount;
    await _firestore.collection("users").doc(userId).update({"userXp": newXp});
  }

  @override
  Future<void> addCompletedQuest(String userId, Questmodel quest) async {
    await _firestore.collection("users").doc(userId).update({
      "completedQuests": FieldValue.arrayUnion([quest.uid]),
    });
  }

  @override
  Future<void> addScannedWord(String userId, String word) async {
    await _firestore.collection("users").doc(userId).update({
      "scannedWords": FieldValue.arrayUnion([word]),
    });
  }

  @override
  Future<void> addLanguagesExplored(String userId, String language) async {
    await _firestore.collection("users").doc(userId).update({
      "languagesExplored": FieldValue.arrayUnion([language]),
    });
  }

  @override
  Future<List<Questmodel>> fetchCompletedQuests(String userId) async {
    final user = await fetchUserbyId(userId);
    if (user == null || user.completedQuests == null) return [];
    return user.completedQuests!
        .map(
          (id) => Questmodel(
            uid: userId,
            questName: '',
            questHint: '',
            questXp: 0,
            questType: Questtype.scanPOS,
          ),
        )
        .toList();
  }

  @override
  Future<void> addIncompleteQuests(String userId, Questmodel quest) async {
    await _firestore.collection("users").doc(userId).update({
      "incompletedQuests": FieldValue.arrayUnion([quest.uid]), // only ID
    });
  }

  @override
  Future<void> addActiveQuests(String userId, Questmodel quest) async {
    await _firestore.collection("users").doc(userId).update({
      "activeQuests": FieldValue.arrayUnion([quest.uid]), // only ID
    });
  }

  @override
  Future<void> removeActiveQuests(String userId, Questmodel quest) async {
    await _firestore.collection("users").doc(userId).update({
      "activeQuests": FieldValue.arrayRemove([quest.uid]),
    });
  }

  @override
  Future<void> removeIncompleteQuests(String userId, Questmodel quest) async {
    await _firestore.collection("users").doc(userId).update({
      "incompletedQuests": FieldValue.arrayRemove([quest.uid]),
    });
  }

  @override
  Future<void> updateProfile(
    String? username,
    String? email,
    String? password,
    int? imageId,
  ) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> dataToUpdate = {};

    if (username != null && username.isNotEmpty) {
      dataToUpdate["username"] = username;
    }

    if (email != null && email.isNotEmpty) {
      dataToUpdate["email"] = email;
    }

    if (imageId != null) {
      dataToUpdate["profilepicture"] = imageId;
    }

    if (dataToUpdate.isNotEmpty) {
      await _firestore.collection("users").doc(uid).update(dataToUpdate);
    }

    if (email != null && email.isNotEmpty) {
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
    }
    if (password != null && password.isNotEmpty) {
      await FirebaseAuth.instance.currentUser!.updatePassword(password);
    }
  }
}
