import 'package:rxdart/rxdart.dart';

import 'Model/probe_match.dart';
import 'Model/sme_device.dart';

ProbeBloc probeData = ProbeBloc();
ProbeMatchBloc probeMatchData = ProbeMatchBloc();
SMEDeviceBLOC deviceBLOC = SMEDeviceBLOC();

class ProbeBloc {
  String? _probe;
  BehaviorSubject<String?> _subject = BehaviorSubject();
  Stream<String?> get probes => _subject.stream;
  ProbeBloc() {
    _subject.add(_probe);
  }
  void add(String s) {
    _subject.sink.add(s);
  }
}

class ProbeMatchBloc {
  ProbeMatch? _probeMatchBloc;
  BehaviorSubject<ProbeMatch?> _subject = BehaviorSubject();
  Stream<ProbeMatch?> get probeMatches => _subject.stream;
  ProbeMatchBloc() {
    _subject.add(_probeMatchBloc);
  }
  void add(ProbeMatch s) {
    _subject.sink.add(s);
  }
}

class SMEDeviceBLOC {
  SmeDevice? _device;
  BehaviorSubject<SmeDevice?> _subject = BehaviorSubject();
  Stream<SmeDevice?> get devices => _subject.stream;
  SMEDeviceBLOC() {
    _subject.add(_device);
    _subject.sink.add(SmeDevice());
  }
  void add(SmeDevice s) {
    _subject.sink.add(s);
  }
}
