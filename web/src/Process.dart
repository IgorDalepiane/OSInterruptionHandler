import 'dart:math' as math;

class Process {
  int id;
  int duration;
  int state = 0;
  int progress = 0;
  String color =
      'rgb(${math.Random().nextInt(255)}, ${math.Random().nextInt(255)}, ${math.Random().nextInt(255)})';

  Process(int id, int duration) {
    this.id = id;
    this.duration = duration;
  }

  int setProgress(int progress) {
    this.progress = progress;
  }

  int getProgress() {
    return progress;
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

  String getColor() {
    return color;
  }
}
