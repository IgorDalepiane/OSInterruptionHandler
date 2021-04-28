import 'dart:math' as math;

class Process {
  int id;
  int size;
  int duration;
  int state = 0;
  String color =
      'rgb(${math.Random().nextInt(255)}, ${math.Random().nextInt(255)}, ${math.Random().nextInt(255)})';

  Process(int size, int id, int duration) {
    this.size = size;
    this.id = id;
    this.duration = duration;
  }

  int getId() {
    return id;
  }

  void setId(int id) {
    this.id = id;
  }

  int getState() {
    return state;
  }

  void setState(int state) {
    this.state = state;
  }

  int getDuration() {
    return duration;
  }

  void setDuration(int duration) {
    this.duration = duration;
  }

  int getSize() {
    return size;
  }

  String getColor() {
    return color;
  }
}
