import 'dart:async';
import 'dart:typed_data';

import 'package:clean/ui/widgets/dialogs/DialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:ui' as ui;


class Utils {

  ///Open url in the default browser
  static navigateToUrl(String url) {
    canLaunch(url).then((can) {
      if (can) {
        return launch(url);
      } else {
        throw 'Could not launch $url';
      }
    });
  }

  static showDefaultError(BuildContext context, int httpStatus){
    String _description = 'Něco se pokazilo\n Prosím zkuste to znovu';

    //TODO no internet connection error message
    // else if (loginTask.error?.originalException == 7) {
    //   _description = 'Please check your internet connection!';
    // }

    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: 'Chyba',
        description: _description,
      ),
    );
  }

  static Future<Uint8List> getBytesFromCanvas(int width, int height, urlAsset) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final ByteData datai = await rootBundle.load(urlAsset);
    var imaged = await loadImage(new Uint8List.view(datai.buffer));
    canvas.drawImageRect(
      imaged,
      Rect.fromLTRB(
          0.0, 0.0, imaged.width.toDouble(), imaged.height.toDouble()),
      Rect.fromLTRB(0.0, 0.0, width.toDouble(), height.toDouble()),
      new Paint(),
    );

    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  static Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

}