import 'package:code_zero/network/convert_interface.dart';

class RedEnvelopeTask extends ConvertInterface{
  int? targetOrderNum;
  int? completedOrderNum;
  int? unfinishedOrderNum;
  int? isCompleted;
  String? expiredAt;
  List<TaskItemList>? taskItemList;

  RedEnvelopeTask(
      {this.targetOrderNum,
        this.completedOrderNum,
        this.unfinishedOrderNum,
        this.isCompleted,
        this.expiredAt,
        this.taskItemList});

  RedEnvelopeTask.fromJson(Map<String, dynamic> json) {
    targetOrderNum = json['targetOrderNum'];
    completedOrderNum = json['completedOrderNum'];
    unfinishedOrderNum = json['unfinishedOrderNum'];
    isCompleted = json['isCompleted'];
    expiredAt = json['expiredAt'];
    if (json['taskItemList'] != null) {
      taskItemList = <TaskItemList>[];
      json['taskItemList'].forEach((v) {
        taskItemList!.add(new TaskItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['targetOrderNum'] = this.targetOrderNum;
    data['completedOrderNum'] = this.completedOrderNum;
    data['unfinishedOrderNum'] = this.unfinishedOrderNum;
    data['isCompleted'] = this.isCompleted;
    data['expiredAt'] = this.expiredAt;
    if (this.taskItemList != null) {
      data['taskItemList'] = this.taskItemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return RedEnvelopeTask.fromJson(json);
  }
}

class TaskItemList {
  String? desc;
  String? completedAt;
  int? isCompleted;

  TaskItemList({this.desc, this.completedAt, this.isCompleted});

  TaskItemList.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    completedAt = json['completedAt'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['completedAt'] = this.completedAt;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}
