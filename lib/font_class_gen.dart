import 'package:fontify_plus/fontify_plus.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

const _unnamedIconName = 'unnamed';

class FontClassGenerator {
  /// * [glyphList] is a list of non-default glyphs.
  /// * [className] is generated class' name.
  /// * [familyName] is font's family name to use in IconData.
  /// * [package] is the name of a font package. Used to provide a font through package dependency.
  /// * [fontFileName] is font file's name. Used in generated docs for class.

  FontClassGenerator({
    required this.glyphList,
    required this.fontFileName,
    required String familyName,
    required String className,
    String? package,
  })  : _familyName = familyName.pascalCase,
        _className = className.pascalCase,
        _iconVarNames = _generateVariableNames(glyphList),
        _package = package?.isEmpty ?? true ? null : package,
        _indent = ' ';

  final List<GenericGlyph> glyphList;
  final String fontFileName;
  final String _familyName;
  final String? _package;
  final List<String> _iconVarNames;
  final String _className;
  final String _indent;

  static List<String> _generateVariableNames(List<GenericGlyph> glyphList) {
    final iconNameSet = <String>{};

    return glyphList.map((g) {
      final baseName = p.basenameWithoutExtension(g.metadata.name!).snakeCase;
      final usingDefaultName = baseName.isEmpty;

      var variableName = usingDefaultName ? _unnamedIconName : baseName;

      if (iconNameSet.contains(variableName)) {
        final countMatch = RegExp(r'^(.*)_([0-9]+)$').firstMatch(variableName);

        var variableNameCount = 1;
        var variableWithoutCount = variableName;

        if (countMatch != null) {
          variableNameCount = int.parse(countMatch.group(2)!);
          variableWithoutCount = countMatch.group(1)!;
        }

        String variableNameWithCount;

        do {
          variableNameWithCount =
              '${variableWithoutCount}_${++variableNameCount}';
        } while (iconNameSet.contains(variableNameWithCount));

        variableName = variableNameWithCount;
      }

      iconNameSet.add(variableName);

      return variableName;
    }).toList();
  }

  bool get _hasPackage => _package != null;

  String get _fontFamilyConst =>
      "\tstatic const _iconFontFamily = '$_familyName';\n";

  String get _fontPackageConst =>
      "\tstatic const _iconFontPackage = '$_package';\n";

  List<String> _generateIconConst(int index) {
    final glyphMeta = glyphList[index].metadata;

    final charCode = glyphMeta.charCode!;

    final varName = _iconVarNames[index].camelCase;
    final hexCode = charCode.toRadixString(16);

    final posParamList = [
      'fontFamily: _iconFontFamily',
      if (_hasPackage) 'fontPackage: _iconFontPackage'
    ];

    final posParamString = posParamList.join(', ');

    return [
      '\tstatic const IconData $varName = IconData(0x$hexCode, $posParamString);'
    ];
  }

  String generate() {
    final classContent = [
      '\t$_className._();\n',
      _fontFamilyConst,
      if (_hasPackage) _fontPackageConst,
      for (var i = 0; i < glyphList.length; i++) ..._generateIconConst(i),
    ];

    final classContentString =
        classContent.map((e) => e.isEmpty ? '' : '$_indent$e').join('\n');

    return '''
import 'package:flutter/widgets.dart';

/// To use this class, make sure you declare the font in your
/// project's `pubspec.yaml` file in the `fonts` section. This ensures that
/// the "$_familyName" font is included in your application. This font is used to
/// display the icons. For example:
/// 
/// flutter:
///   fonts:
///     - family: $_familyName
///       fonts:
///         - asset: $fontFileName
class $_className {
$classContentString
}
''';
  }
}
