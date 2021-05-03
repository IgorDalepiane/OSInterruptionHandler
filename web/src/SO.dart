import 'dart:async';
import 'dart:html';
import 'dart:math' as math;
import 'InterruptionHandler.dart';
import 'Log.dart';
import 'Process.dart';

class SO {
  static Map processes = {};

  SO(int nProcess) {
    for (var i = 1; i <= nProcess; i++) {
      processes[i] = Process(i, math.Random().nextInt(12) + 1);
      // processes[i] = Process(math.Random().nextInt(20000), i);
    }
  }

  static void createProcess() {
    processes[processes.length + 1] =
        Process(processes.length + 1, math.Random().nextInt(12));
    var pTable = querySelector('#processesTable');
    pTable.scrollTop = pTable.scrollHeight;
    toHtmlOne(processes.length, processes[processes.length]);
  }

  static void toHtml() {
    processes.forEach((k, v) {
      toHtmlOne(k, v);
    });
  }

  static void runProcess(int index, Process process) {
    var count = process.progress;
    var processesDiv = querySelector('#processProg$index');
    var ended = false;
    // Timer.periodic(Duration(milliseconds: 200), (timer) {
    if (count < process.duration) {
      Timer.periodic(Duration(milliseconds: 1000), (timer) {
        if (count >= process.duration) {
          Log.createLog(
              'w-full h-7 border-2 border-t-0 border-gray gap-1 bg-green-100',
              'Process $index is completed!');
          var runBtn = querySelector('#runningBtn$index');
          runBtn.text = 'Ended';
          runBtn.className = 'w-full h-full bg-black text-white';
          ended = true;
          timer.cancel();
        }
        if (math.Random().nextInt(5) == 0 && !ended) {
          var runBtn = querySelector('#runningBtn$index');
          runBtn.text = 'INTERRUPTED';
          runBtn.className = 'w-full h-full bg-red-800 text-white';
          Log.createLog(
              'w-full h-7 border-2 border-t-0 border-gray gap-1 bg-red-800 text-white',
              'Process $index is interrupted!');
          InterruptionHandler(math.Random().nextInt(3) + 1, process);
          timer.cancel();
        }
        process.setProgress(count);
        processesDiv.text = '${process.getProgress()} s';
        count++;
      });
    }
  }

  static void toHtmlOne(int k, Process v) {
    var pTable = querySelector('#processesTable');
    var pIdDiv = DivElement();
    pIdDiv.className = 'w-full h-7 border-2 border-gray ml-0';
    pIdDiv.id = 'process$k';
    pIdDiv.text = 'ID: $k';
    pTable.append(pIdDiv);

    var pProgressDiv = DivElement();
    pProgressDiv.className = 'w-full h-7 border-2 border-gray ml-0';
    pProgressDiv.id = 'processProg$k';
    pProgressDiv.text = '${v.getProgress()} s';
    pTable.append(pProgressDiv);

    var pSizeDiv = DivElement();
    pSizeDiv.className =
        'w-full h-7 border-2 border-l-0 border-gray ml-0';
    pSizeDiv.text = '${v.getDuration()} s';
    pTable.append(pSizeDiv);

    var pActionsDiv = DivElement();
    pActionsDiv.className =
        'w-full h-7 border-2 border-l-0 border-gray ml-0';

    var processRunBtn = ButtonElement();
    processRunBtn.text = 'Run';
    processRunBtn.id = 'runBtn$k';
    processRunBtn.className = 'w-full h-full bg-yellow-200';
    processRunBtn.onClick.listen((event) {
      if (processRunBtn.text == 'Running') {
        Log.createLog(
            'w-full h-7 border-2 border-t-0 border-gray gap-1 bg-red-100',
            'The process P-$k is already running!');
      } else {
        processRunBtn.id = 'runningBtn$k';
        processRunBtn.text = 'Running';
        processRunBtn.className = 'w-full h-full bg-red-200';
        SO.runProcess(k, v);
        Log.createLog(
            'w-full h-7 border-2 border-t-0 border-gray gap-1 bg-green-300 ',
            'Process $k is running!');
      }
    });
    pActionsDiv.children.add(processRunBtn);
    pTable.append(pActionsDiv);
  }
}
