import 'package:base_riverpod/core/storage/database_shared.dart';
import 'package:drift/drift.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase(super.e);

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        //await customStatement('CREATE INDEX ...');
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');

        // await customStatement('PRAGMA recursive_triggers = ON');
      },

      //TODO, do proper migration once app is live
      onUpgrade: (m, from, to) async {
        await transaction(() async {
          await customStatement('PRAGMA foreign_keys = OFF');
          await Future.wait(
            allTables.map((table) => m.deleteTable(table.actualTableName)),
          );
        });
        await m.createAll();

        // if (from == 1) {
        // we added the dueDate property in the change from version 1
        // await m.addColumn(todos, todos.dueDate);
        // }
      },
    );
  }

  /// you should bump this number whenever you change or add a table definition
  @override
  int get schemaVersion => 1;

  Future<void> deleteAllTables() async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      await transaction(
        () async {
          await Future.wait(
            [for (final table in allTables) delete(table).go()],
          );
        },
      );
    } catch (ex, st) {
      // print('AppDatabase.deleteAllTables failed to delete all tables, err: $ex, st: $st');
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  }
}

Future<void> deleteAllTablesData() async {
  final AppDatabase db = constructDb();

  await db.deleteAllTables();

  await db.close();
}
