import 'icon_pack.dart';

const _outputFontFolder = 'outputFontPath';
const _outputFileFolder = 'outputFilePath';
const _packs = 'icons';

class IconsModel {
  final List<IconPack> packs; //list of icons packs
  final String outputFontFolder; //.otf file output path
  final String outputFileFolder; //.dart file output path

  factory IconsModel.fromYaml(dynamic yamlMap) {
    try {
      return IconsModel(
        packs: [for (final pack in yamlMap[_packs]) IconPack.fromYaml(pack)],
        outputFileFolder: yamlMap[_outputFileFolder],
        outputFontFolder: yamlMap[_outputFontFolder],
      );
    } catch (_) {
      throw ('Unsupported yaml file format');
    }
  }

  IconsModel({
    required this.packs,
    required this.outputFontFolder,
    required this.outputFileFolder,
  });

  String get outputFontFolderPath => outputFontFolder;

  String get outputFileFolderPath => outputFileFolder;

  @override
  String toString() {
    return packs.map((e) => e.toString()).toString();
  }
}
