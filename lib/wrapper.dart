import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late Future<List<ui.Image>> images;
  final List<Offset> touchPoints = [];

  @override
  initState() {
    super.initState();
    images = loadImages();
  }

  Future<List<ui.Image>> loadImages() async {
    String image1 = 'assets/gift.png';
    String image2 = 'assets/wrapper.png';

    var dataImage1 = await loadImage(image1);
    var dataImage2 = await loadImage(image2);

    return [dataImage1, dataImage2];
  }

  // Helper function to load the image
  Future<ui.Image> loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else {
          return GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                // Store the touch position relative to the widget
                touchPoints.add(details.localPosition);
              });
            },
            child: CustomPaint(
              painter: WrapperPainter(
                giftImage: snapshot.data!.first,
                wrapperImage: snapshot.data!.last,
                touchPoints: touchPoints,
              ),
            ),
          );
        }
      },
    );
  }
}

class WrapperPainter extends CustomPainter {
  final ui.Image giftImage;
  final ui.Image wrapperImage;
  final List<Offset> touchPoints;

  WrapperPainter({
    required this.giftImage,
    required this.wrapperImage,
    required this.touchPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Wrapper Image background
    canvas.drawImageRect(
      wrapperImage,
      Rect.fromLTWH(0, 0, size.width, size.height),
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );

    // Cross Painter
    Paint paint = Paint()..color = const Color.fromARGB(255, 20, 104, 173);
    Path path = Path();
    double distance = 105;

    path.moveTo(0, distance);
    path.lineTo(0, size.height - distance);
    path.lineTo(distance, size.height - distance);
    path.lineTo(distance, size.height);
    path.lineTo(size.width - distance, size.height);
    path.lineTo(size.width - distance, size.height - distance);
    path.lineTo(size.width, size.height - distance);
    path.lineTo(size.width, distance);
    path.lineTo(size.width - distance, distance);
    path.lineTo(size.width - distance, 0);
    path.lineTo(distance, 0);
    path.lineTo(distance, distance);
    path.lineTo(0, distance);
    canvas.drawPath(path, paint);

    // Circle Painter
    Paint circlePainter = Paint()
      ..color = const Color.fromARGB(255, 48, 134, 205);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      80,
      circlePainter,
    );

    // Gift Image Painter
    double x = (size.width - giftImage.width) / 2;
    double y = (size.height - giftImage.height) / 2;
    canvas.drawImage(giftImage, Offset(x, y), Paint());

    // Eraser
    // Draw a mask over touch points to simulate erasing
    for (Offset point in touchPoints) {
      // Erasing area is simulated by clipping or drawing a transparent circle
      canvas.drawCircle(point, 20, Paint()..blendMode = BlendMode.clear);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
