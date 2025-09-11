import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_firebase/services/auth_service.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = AuthService();

  late final User? _user = _auth.currentUser;

  Future<void> addTarefa(String text) async {
    try {
      await _firestore
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .add({
            "titulo": text,
            "concluida": false,
            "dataCriacao": Timestamp.now(),
          });
    } catch (e) {
      throw FirebaseException(plugin: 'firestore');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTarefasForUser()  {
    try {
      return _firestore
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .orderBy("dataCriacao", descending: true).snapshots();
    } catch (e) {
      throw FirebaseException(plugin: 'firestore');
    }
  }

  Future<void> updateTarefaStatus(String docId, bool concluida) async {
    try{
      _firestore.collection('usuarios').doc(_user!.uid).collection('tarefas').doc(docId).update({"concluida" : concluida});
    } catch (e){
      throw FirebaseException(plugin: 'firestore');
    }
  }

  void deleteTarefa(String docId) {
    try{
      _firestore.collection("usuarios").doc(_user!.uid).collection("tarefas").doc(docId).delete();
    } catch (e){
      throw FirebaseException(plugin: 'firestore');
    }
  }
}
