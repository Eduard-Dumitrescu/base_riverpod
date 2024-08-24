import 'package:base_riverpod/core/storage/app_database.dart';
import 'package:base_riverpod/core/storage/database_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_module.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) => constructDb();
