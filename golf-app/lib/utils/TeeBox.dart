class TeeBox {
  int id;
  int course_id;
  String name;
  int slope;
  double rating;
  int front_9;
  int back_9;
  int total_yards;
  int par;

  TeeBox(this.id, this.course_id, this.name, this.slope, this.rating,
      this.front_9, this.back_9, this.total_yards, this.par);

  TeeBox.fromTeeBox(
      {required this.id,
      required this.course_id,
      required this.name,
      required this.slope,
      required this.rating,
      required this.front_9,
      required this.back_9,
      required this.total_yards,
      required this.par});

  factory TeeBox.fromJson(dynamic res) {
    return TeeBox.fromTeeBox(
        id: res['id'],
        course_id: res['course_id'],
        name: res['name'],
        slope: res['Slope'],
        rating: res['Rating'],
        front_9: res['front_9'],
        back_9: res['back_9'],
        total_yards: res['total_yardage'],
        par: res['Par']);
  }
}
