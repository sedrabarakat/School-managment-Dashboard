class Available_teacher_model {
  int? id;
  int? teacherId;
  int? subjectId;
  int? safId;
  String? createdAt;
  String? updatedAt;

  Available_teacher_model(
      {this.id,
        this.teacherId,
        this.subjectId,
        this.safId,
        this.createdAt,
        this.updatedAt});

  Available_teacher_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    subjectId = json['subject_id'];
    safId = json['saf_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher_id'] = this.teacherId;
    data['subject_id'] = this.subjectId;
    data['saf_id'] = this.safId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}