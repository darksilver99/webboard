class WebboardList {
  String? id;
  String? subject;
  String? detail;
  String? create_date;
  String? hits;

  WebboardList({this.id, this.subject, this.detail});

  WebboardList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    detail = json['detail'];
    create_date = json['create_date'];
    hits = json['hits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['detail'] = this.detail;
    data['create_date'] = this.detail;
    data['hits'] = this.detail;
    return data;
  }
}
