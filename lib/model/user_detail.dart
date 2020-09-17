class User {
  String name = '';
  String headshot = '';
  User({this.name, this.headshot});

  String get userName => name;

  String get userHeadshot => headshot;
}
