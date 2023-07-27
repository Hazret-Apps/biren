/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/icons/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/announcement.png
  AssetGenImage get announcement =>
      const AssetGenImage('assets/images/announcement.png');

  /// File path: assets/images/calender.png
  AssetGenImage get calender =>
      const AssetGenImage('assets/images/calender.png');

  /// File path: assets/images/classes.png
  AssetGenImage get classes => const AssetGenImage('assets/images/classes.png');

  /// File path: assets/images/exams.png
  AssetGenImage get exams => const AssetGenImage('assets/images/exams.png');

  /// File path: assets/images/showcase.png
  AssetGenImage get showcase =>
      const AssetGenImage('assets/images/showcase.png');

  /// File path: assets/images/students.png
  AssetGenImage get students =>
      const AssetGenImage('assets/images/students.png');

  /// File path: assets/images/task.png
  AssetGenImage get task => const AssetGenImage('assets/images/task.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [announcement, calender, classes, exams, showcase, students, task];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  $AssetsJsonsLangGen get lang => const $AssetsJsonsLangGen();
  $AssetsJsonsStudyGen get study => const $AssetsJsonsStudyGen();
}

class $AssetsJsonsLangGen {
  const $AssetsJsonsLangGen();

  /// File path: assets/jsons/lang/tr-TR.json
  String get trTR => 'assets/jsons/lang/tr-TR.json';

  /// List of all assets
  List<String> get values => [trTR];
}

class $AssetsJsonsStudyGen {
  const $AssetsJsonsStudyGen();

  /// File path: assets/jsons/study/lessons.json
  String get lessons => 'assets/jsons/study/lessons.json';

  /// File path: assets/jsons/study/subjects.json
  String get subjects => 'assets/jsons/study/subjects.json';

  /// List of all assets
  List<String> get values => [lessons, subjects];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
