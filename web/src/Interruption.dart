import 'Process.dart';

class Interruption {
  int id;
  int type = 0;
  int duration = 0;
  Process process;

  Interruption(int id, int type, int duration, Process process) {
    this.id = id;
    this.type = type;
    this.duration = duration;
    this.process = process;
  }

  int getId() {
    return id;
  }

  void setId(int id) {
    this.id = id;
  }

  int getType() {
    return type;
  }

  void setType(int type) {
    this.type = type;
  }

  Process getProcess() {
    return this.process;
  }

  int getDuration() {
    return duration;
  }

  void setDuration(int duration) {
    this.duration = duration;
  }
}
