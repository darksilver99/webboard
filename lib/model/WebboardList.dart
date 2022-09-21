class WebboardList {
  String? id;
  String? subject;
  String? detail;

  WebboardList({this.id, this.subject, this.detail});

  WebboardList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['detail'] = this.detail;
    return data;
  }
}
