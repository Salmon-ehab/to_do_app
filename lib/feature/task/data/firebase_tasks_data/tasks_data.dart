import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

class TaskService {
  Future<List<TaskFireBaseModel>> getTasksFromFirebase( {String? progress}) async {
    List<TaskFireBaseModel> tasks = [];

    // Query query = FirebaseFirestore.instance.collection("tasks")
    //     .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    // if (progress != null) {
    //   query = query.where("progress", isEqualTo: progress);
    // }

    // QuerySnapshot snapshot = await query.get() ;

    // for (var doc in snapshot.docs) {
    //   TaskFireBaseModel task = TaskFireBaseModel.fromJson(
    //       doc.data() as Map<String, dynamic>, doc.id);

    //   tasks.add(task);
    // }

    return tasks;
  }


  // Future<List<TaskFireBaseModel>> getTasksFromFirebase() async {
  //   List<TaskFireBaseModel> tasks = [];
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection("tasks")
  //       .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   for (var doc in snapshot.docs) {
  //     TaskFireBaseModel task = TaskFireBaseModel.fromJson(
  //         doc.data() as Map<String, dynamic>, doc.id);
  //
  //     tasks.add(task);
  //   }
  //
  //   return tasks;
  // }

  // Future<void> deleteTask(String taskId) async {
  //   try {
  //     await FirebaseFirestore.instance.collection("tasks").doc(taskId).delete();
  //   } catch (e) {
  //     throw Exception("Failed to delete item: $e");
  //   }
  // }
}
