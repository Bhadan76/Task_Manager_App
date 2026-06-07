class TaskModel {
  final String id;
  final String tittle;
  final String description;
  final String status;
  final String createdAt;

  TaskModel({
    required this.id,
    required this.tittle,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData['_id'] ?? '',
      tittle: jsonData['title'] ?? jsonData['tittle'] ?? '',
      description: jsonData['description'] ?? '',
      status: jsonData['status'] ?? '',
      createdAt: jsonData['createdAt'] ?? '',
    );
  }
}
