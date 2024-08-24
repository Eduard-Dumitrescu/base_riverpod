export 'database_unsupported.dart'
    if (dart.library.ffi) 'database_native.dart'
    if (dart.library.html) 'database_web.dart';
