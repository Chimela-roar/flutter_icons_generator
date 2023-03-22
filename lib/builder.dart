import 'dart:io';

import 'package:build/build.dart';
import 'package:yaml/yaml.dart';

import 'icons_generator.dart';
import 'models/icons_model.dart';

const String iconConfig = 'icons_config';

Builder iconBuilder(BuilderOptions options) {
  try {
    final optionsPath = Map<String, dynamic>.from(options.config);
    if (optionsPath[iconConfig] != null) {
      final configFile = File(optionsPath[iconConfig]);
      final yamlString = configFile.readAsStringSync();
      final yamlMap = loadYaml(yamlString);
      final iconsModel = IconsModel.fromYaml(yamlMap);

      return IconsGenerator(iconsModel);
    }
    throw Exception('no yaml path');
  } catch (e) {
    throw Exception(e);
  }
}
