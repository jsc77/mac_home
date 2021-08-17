class ItemModel {
  String name;
  String img;
  String time;
  String profile;
  ItemModel({this.name, this.img, this.time, this.profile});
  ItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    time = json['time'];
    profile = json['profile'];
  }
  Map<String, dynamic> toJson() => {'name': name, 'img': img, 'time': time, 'profile':profile};
}
