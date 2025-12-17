class Model {
  final int? id;
   final String task;
   final String description;

  Model({ this.id, required this.task, required this.description});
  Map<String, dynamic> toMap() {  
  return {
    'id': id,
    'task': task,
    'description': description,
  };
}
factory Model.fromJson(Map<String, dynamic> json) {
  return Model(
    id: json['id'],
    task: json['task'],
    description: json['description'],
  );
}

}
