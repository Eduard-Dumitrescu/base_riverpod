import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_module.g.dart';

@riverpod
Dio dio(DioRef ref) => Dio(BaseOptions(baseUrl: ''));
