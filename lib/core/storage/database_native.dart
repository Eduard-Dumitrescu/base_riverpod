import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:base_riverpod/core/storage/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';

Future<DriftIsolate> _createDriftIsolate() async {
  // this method is called from the main isolate. Since we can't use
  // getApplicationDocumentsDirectory on a background isolate, we calculate
  // the database path in the foreground isolate and then inform the
  // background isolate about the path.
  final dir = await getApplicationDocumentsDirectory();
  final path = p.join(dir.path, 'db.sqlite');
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  // _startBackground will send the DriftIsolate to this ReceivePort
  return await receivePort.first as DriftIsolate;
}

void _startBackground(_IsolateStartRequest request) {
  // this is the entry point from the background isolate! Let's create
  // the database from the path we received
  final executor = NativeDatabase(File(request.targetPath));
  // we're using DriftIsolate.inCurrent here as this method already runs on a
  // background isolate. If we used DriftIsolate.spawn, a third isolate would be
  // started which is not what we want!
  bundleSqlite();

  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection(executor),
  );
  // inform the starting isolate about this, so that it can call .connect()
  request.sendDriftIsolate.send(driftIsolate);
}

// used to bundle the SendPort and the target path, since isolate entry point
// functions can only take one parameter.
class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

DatabaseConnection _createDriftIsolateAndConnect() {
  return DatabaseConnection.delayed(() async {
    final isolate = await _createDriftIsolate();
    return await isolate.connect();
  }());
}

AppDatabase constructDb() => AppDatabase(_createDriftIsolateAndConnect());

void bundleSqlite() {
  open.overrideFor(OperatingSystem.linux, _driftOpenOnLinux);
  open.overrideFor(OperatingSystem.windows, _driftOpenOnWindows);
}

DynamicLibrary _driftOpenOnLinux() {
  final Directory scriptDir = File(Platform.script.toFilePath()).parent;
  final File libraryNextToScript =
      File('${scriptDir.path}\\linux\\libsqliteX.so');
  return DynamicLibrary.open(libraryNextToScript.path);
}

DynamicLibrary _driftOpenOnWindows() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript = File('${scriptDir.path}\\windows\\sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}
