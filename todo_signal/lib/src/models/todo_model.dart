import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String title;
  final String? description;

  final bool completed;

  TodoModel(this.title, {String? descriptionC, String? idC, bool? completedC})
      : id = idC ?? const Uuid().v4(),
        description = descriptionC,
        completed = completedC ?? false;

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
  }) {
    return TodoModel(
      title ?? this.title,
      descriptionC: description ?? this.description,
      idC: id ?? this.id,
      completedC: completed ?? this.completed,
    );
  }
}
