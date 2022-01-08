

class Hole{

  int id;
  int courseId;
  int teeBoxId;
  int holeNum;
  int par; 
  int yards; 
  int strokeIndex;

  Hole(this.id, this.courseId, this.teeBoxId, this.holeNum, this.par, this.yards, this.strokeIndex);

  Hole.fromHole({
    required this.id,
    required this.courseId,
    required this.teeBoxId,
    required this.holeNum,
    required this.par, 
    required this.yards,
    required this.strokeIndex
  });

  factory Hole.fromJson(dynamic res){
      return Hole.fromHole(
        id: res['id'],
        courseId: res['course_id'],
        teeBoxId: res['tee_box_id'],
        holeNum: res['hole_num'],
        par: res['par'],
        yards: res['yards'],
        strokeIndex: res['stroke_index']
      );
  }
}