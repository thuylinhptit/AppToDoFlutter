import 'package:cloud_firestore/cloud_firestore.dart';

class Api{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Api( this.path ) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getData() {
    return ref.get() ;
  }
  Stream<QuerySnapshot> streamData() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getTaskById(String id) {
    return ref.doc(id).get();
  }
  Future<void> removeTask(String id){
    return ref.doc(id).delete();
  }
  Future<DocumentReference> addTask(Map data) {
    return ref.add(data);
  }
  Future<void> updateTask(Map data , String id) {
    return ref.doc(id).update(data) ;
  }


}