class TaskFireBaseModel {
  final String image;
  final String textTitle;
  final String textDesc;
  final String priority;
  final String progress;
  final String date;
  final String taskId;
  final String userId;

  TaskFireBaseModel( {
    required this.image,
    required this.textTitle,
    required this.textDesc,
    required this.priority,
    required this.progress,
    required this.date,
    required this.taskId,
    required this.userId,
  });

  factory TaskFireBaseModel.fromJson(Map<String, dynamic> json, String id) {
    return TaskFireBaseModel(
        image: json["image"],
        textTitle: json["taskTitle"],
        textDesc: json["taskDesc"],
        priority: json["priority"],
        progress: json["progress"]?? "Waiting",
        date: json["date"],
        taskId: id,
        userId: json["id"]);
  }
}
