class Categoryu {
  String thumbnail;
  String name;
  int noOfCourses;

  Categoryu({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Categoryu> categoryList = [
  Categoryu(
    name: 'Profile',
    noOfCourses: 55,
    thumbnail: 'assets/images/user.png',
  ),
  Categoryu(
    name: 'Data',
    noOfCourses: 20,
    thumbnail: 'assets/images/network_security.png',
  ),
];
