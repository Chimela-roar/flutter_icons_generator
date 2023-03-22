import 'package:recase/recase.dart';

const _className = 'className';
const _sourceFolderPath = 'sourceFolderPath';

class IconPack {
  final String className; //class name
  final String sourceFolder; //source folderPath

  factory IconPack.fromYaml(dynamic yamlMap) {
    return IconPack(
      className: yamlMap[_className],
      sourceFolder: yamlMap[_sourceFolderPath],
    );
  }

  IconPack({
    required this.className,
    required this.sourceFolder,
  });

  String get fontName => className;

  String get _fileName => className.snakeCase;

  String get classFileName => '$_fileName.dart';

  String get fontFileName => '$_fileName.otf';

  String get sourceFolderPath => sourceFolder;

  @override
  String toString() {
    return fontName;
  }
}
