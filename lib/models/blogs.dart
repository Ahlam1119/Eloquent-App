class BolgsModel {
  final String uid;
  final String Parentuid;
  final String ParentName;
  final String blog;
  final String blogTitle;
  final String image;

  const BolgsModel(
      {required this.ParentName,
      required this.Parentuid,
      required this.blog,
      required this.blogTitle,
      required this.uid,
      required this.image});
  //(fetch data from firebase ) data from the database will converted and store in this model to use in the app
  factory BolgsModel.fromJson(Map<String, dynamic> json) => BolgsModel(
      uid: json['uid'],
      ParentName: json['ParentName'],
      Parentuid: json['Parentuid'],
      blog: json['blog'],
      blogTitle: json['blogTitle'],
      image: json['image']);

  //(send data to firebase )data  will converted and store in data base

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'ParentName': ParentName,
        'Parentuid': Parentuid,
        'blog': blog,
        'blogTitle': blogTitle,
        'image': image
      };
}
