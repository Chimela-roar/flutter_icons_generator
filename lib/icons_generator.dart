import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:build/build.dart';
import 'package:fontify_plus/fontify_plus.dart';

import 'font_class_gen.dart';
import 'models/icons_model.dart';

class IconsGenerator implements Builder {
  final IconsModel iconsModel;

  const IconsGenerator(this.iconsModel);

  @override
  Map<String, List<String>> get buildExtensions {
    List<String> outputs = [];
    for (final pack in iconsModel.packs) {
      outputs.add('${iconsModel.outputFileFolderPath}/${pack.classFileName}');
      outputs.add('${iconsModel.outputFontFolder}/${pack.fontFileName}');
    }
    return {r'$package$': outputs};
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    try {
      for (final pack in iconsModel.packs) {
        final svgMap = _getSvgMap(svgDirectoryPath: pack.sourceFolderPath);

        final svgToOtfResult = svgToOtf(
          svgMap: svgMap,
          fontName: pack.fontName,
        );

        final fontFilePath =
            '${iconsModel.outputFontFolder}/${pack.fontFileName}';

        final fontByteData =
            OTFWriter().write(svgToOtfResult.font).buffer.asUint8List();
        final newFontAsset = AssetId(buildStep.inputId.package, fontFilePath);
        await buildStep.writeAsBytes(newFontAsset, fontByteData);

        final classFilePath =
            '${iconsModel.outputFileFolderPath}/${pack.classFileName}';

        final generatedClass = _generateFontClass(
          glyphList: svgToOtfResult.glyphList,
          familyName: svgToOtfResult.font.familyName,
          className: pack.fontName,
          fontFileName: fontFilePath,
        );

        final newFileAsset = AssetId(buildStep.inputId.package, classFilePath);
        await buildStep.writeAsString(newFileAsset, generatedClass);
      }
      return null;
    } catch (e) {
      developer.log(e.toString());
    }
  }

  Map<String, String> _getSvgMap({required String svgDirectoryPath}) {
    final svgDirectory = Directory(svgDirectoryPath).listSync();

    Map<String, String> svgMap = {};

    for (final svg in svgDirectory) {
      if (svg is File) {
        svgMap[svg.path.split('/').last.split('.svg').first] =
            svg.readAsStringSync();
      }
    }
    return svgMap;
  }

  String _generateFontClass({
    required List<GenericGlyph> glyphList,
    required String className,
    required String familyName,
    required String fontFileName,
    String? package,
  }) {
    final generator = FontClassGenerator(
      glyphList: glyphList,
      className: className,
      fontFileName: fontFileName,
      familyName: familyName,
      package: package,
    );

    return generator.generate();
  }
}
