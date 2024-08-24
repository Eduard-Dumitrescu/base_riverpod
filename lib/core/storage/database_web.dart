// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:js';

import 'package:base_riverpod/core/storage/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/remote.dart';
import 'package:drift/web.dart';
import 'package:flutter/foundation.dart';

AppDatabase constructDb() {
  if (context.hasProperty('SharedWorker')) {
    return AppDatabase(
      LazyDatabase(
        () async {
          return _connectToWorker('db').executor;
        },
      ),
    );
  } else {
    return AppDatabase(
      WebDatabase.withStorage(
        DriftWebStorage.indexedDb('db'),
      ),
    );
  }
}

DatabaseConnection _connectToWorker(final String databaseName) {
  final SharedWorker worker = SharedWorker(
    kReleaseMode ? 'worker.dart.min.js' : 'worker.dart.js',
    databaseName,
  );

  return remote(worker.port!.channel());
}
