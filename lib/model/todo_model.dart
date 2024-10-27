import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();
final isoDateFormatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

class TodoModel {
  TodoModel({
    this.id,
    required this.title,
    this.description,
    this.isCompleted = 0,
    required this.priority,
    required this.category,
    required this.createdAt,
  });

  final int? id;
  final String title;
  final String? description;
  final int? isCompleted;
  final DateTime createdAt;
  final String priority;
  final String category;

  String get formattedDate => dateFormatter.format(createdAt);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'category': category,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
      priority: map['priority'],
      category: map['category'],
      createdAt: isoDateFormatter.parse(map['createdAt']),
    );
  }
}
