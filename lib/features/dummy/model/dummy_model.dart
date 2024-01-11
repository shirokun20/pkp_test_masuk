class SampleModel {
  String? name;
  String? image;
  String? desc;

  SampleModel({this.name, this.image, this.desc});

  SampleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['desc'] = desc;
    return data;
  }
}