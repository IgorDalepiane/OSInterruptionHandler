import 'dart:async';
import 'dart:html';
import 'dart:math' as math;
import 'Interruption.dart';
import 'Log.dart';
import 'Process.dart';
import 'SO.dart';

class InterruptionHandler {
  static int elements = 0;
  static List interruptions = [];

  InterruptionHandler(int type, Process process) {
    if (type == 1) {
      interruptions.add(Interruption(InterruptionHandler.elements + 1,
          type, math.Random().nextInt(3), process));
    } else if (type == 2) {
      interruptions.add(Interruption(InterruptionHandler.elements + 1,
          type, math.Random().nextInt(6) + 3, process));
    } else {
      interruptions.add(Interruption(InterruptionHandler.elements + 1,
          type, math.Random().nextInt(9) + 6, process));
    }
    InterruptionHandler.elements++;
    toHtmlOne(interruptions[interruptions.length - 1]);
    runInterruption(interruptions[interruptions.length - 1]);
  }

  static void runInterruption(Interruption inte) {
    var count = 0;
    var interruptionDiv = querySelector('#inte${inte.getId()}');
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (count == inte.duration) {
        Log.createLog(
            'w-full h-7 border-2 border-t-0 border-gray gap-1 bg-red-100',
            'Interruption ${inte.getId()} is solved!');
        interruptionDiv.remove();
        var runBtn =
            querySelector('#runningBtn${inte.getProcess().getId()}');
        runBtn.id = 'runningBtn${inte.getProcess().getId()}';
        runBtn.text = 'Running';
        runBtn.className = 'w-full h-full bg-red-200';
        SO.runProcess(inte.getProcess().getId(), inte.getProcess());

        timer.cancel();
      }
      interruptionDiv.text =
          'Processo: ${inte.getProcess().getId()} Tipo ${inte.getType()} Duração: ${inte.getDuration()} Progresso: $count';
      count++;
    });
  }

  void toHtmlOne(Interruption v) {
    var iTable = querySelector('#interruptionsTable');
    var iDiv = DivElement();
    iDiv.className =
        'w-full h-7 border-2 border-gray text-white ml-0 bg-red-800 text-center';
    iDiv.id = 'inte${v.getId()}';
    iDiv.text =
        'Processo: ${v.getProcess().getId()} Tipo ${v.getType()} Duração: ${v.getDuration()} Progresso: 0';
    iTable.append(iDiv);
  }
}
