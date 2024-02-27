import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart' as path;

Future<String> get destinationFileVideo async {
  late String directory;
  final String videoName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
  if (Platform.isAndroid) {
    final List<Directory>? dir = await path.getExternalStorageDirectories(type: path.StorageDirectory.movies);
    directory = dir!.first.path;
    return File('$directory/$videoName').path;
  } else {
    final Directory dir = await path.getLibraryDirectory();
    directory = dir.path;
    return File('$directory/$videoName').path;
  }
}

Future<String> get destinationFileImage async {
  late String directory;
  final String imageName = '${DateTime.now().millisecondsSinceEpoch}.jpeg';
  if (Platform.isAndroid) {
    final List<Directory>? dir = await path.getExternalStorageDirectories(type: path.StorageDirectory.movies);
    directory = dir!.first.path;
    return File('$directory/$imageName').path;
  } else {
    final Directory dir = await path.getLibraryDirectory();
    directory = dir.path;
    return File('$directory/$imageName').path;
  }
}

int getQuality(dynamic fileLength) {
  int quality = 0;
  if (fileLength < 500000) {
    quality = 100;
  } else if (fileLength < 2000000) {
    quality = 96;
  } else if (fileLength < 4000000) {
    quality = 86;
  } else if (fileLength < 6000000) {
    quality = 76;
  } else {
    quality = 100 ~/ (fileLength / 500000);
    if (quality < 50) quality = 50;
  }
  return quality;
}

Future<File> writeToFile(Uint8List data, String path) {
  final buffer = data.buffer;
  return new File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

double getScaleRatio(BuildContext context) {
  var pixRatio = MediaQuery.of(context).devicePixelRatio;
  print("Corrected size W is ${MediaQuery.of(context).size.width * pixRatio}");
  print("Corrected size H is ${MediaQuery.of(context).size.height * pixRatio}");
  return 0.0;
}
