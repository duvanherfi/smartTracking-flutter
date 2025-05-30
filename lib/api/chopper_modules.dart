// coverage:ignore-file

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_tracking/api/base_chopper_module.dart';
import 'package:smart_tracking/utils/enviroments.dart';

@module
abstract class ChopperModule extends BaseChopperModule {
  @lazySingleton
  ChopperClient chopperBuilder() => ChopperClient(
        baseUrl: Uri.tryParse(Environments.baseUrl),
        interceptors: interceptors,
        converter: converters,
        errorConverter: errorConverter,
        services: dataSources,
      );
}
