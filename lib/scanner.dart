import 'dart:io';

import 'package:camera/camera.dart';
import 'package:edge_detection/edge_detection.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:path_provider/path_provider.dart';

CameraController? _cameraController;
XFile? _capturedImage;
List<File> _scannedImages = [];

class ScannerPage extends StatefulWidget {
  const ScannerPage({
    super.key,
  });
  // final CameraDescription camera;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

enum ScannerState { CAPTURE, WARNING, ERROR }

class _ScannerPageState extends State<ScannerPage> {
  List<XFile> images = [];
  var state = ScannerState.CAPTURE;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    print(cameras);
    print('hoalaaaaaaa');
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _cameraController!.startImageStream((image) {
    //   print(image);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset(
          //   "assets/scanner.jpg",
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          FutureBuilder(
              future: _initializeCamera(),
              builder: (context, _) {
                return SizedBox(
                    height: double.infinity,
                    child: CameraPreview(_cameraController!));
              }),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: state == ScannerState.WARNING
                ? Container(
                    color: Color(0x40FBC000),
                    padding: EdgeInsets.all(24),
                    child:
                        Center(child: SvgPicture.asset("assets/warning.svg")),
                  )
                : SizedBox(),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: state == ScannerState.ERROR
                ? Container(
                    color: Color(0x50981F2B),
                    padding: EdgeInsets.all(24),
                    child: Center(child: SvgPicture.asset("assets/error.svg")),
                  )
                : SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    images.isNotEmpty
                        ? Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Transform.translate(
                                offset: const Offset(8, -8),
                                child: Transform.rotate(
                                  angle: -20,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: FutureBuilder(
                                        future: images.length > 1
                                            ? images.reversed
                                                .take(2)
                                                .last
                                                .readAsBytes()
                                            : images.last.readAsBytes(),
                                        builder: (context, snapshot) {
                                          return snapshot.data != null
                                              ? Image.memory(
                                                  snapshot.data!,
                                                  fit: BoxFit.cover,
                                                  width: 64,
                                                  height: 64,
                                                  color:
                                                      const Color(0x60981F2B),
                                                  colorBlendMode:
                                                      BlendMode.multiply,
                                                )
                                              : CircularProgressIndicator();
                                        }),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: FutureBuilder(
                                    future: images.last.readAsBytes(),
                                    builder: (context, snapshot) {
                                      return snapshot.data != null
                                          ? Image.memory(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                              width: 64,
                                              height: 64,
                                            )
                                          : CircularProgressIndicator();
                                    }),
                              ),
                              Positioned(
                                bottom: -6,
                                right: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF981F2B),
                                      shape: BoxShape.circle),
                                  child: Text(
                                    images.length.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    InkWell(
                      onTap: () async {
                        String name =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Directory directory =
                            await getApplicationDocumentsDirectory();
                        XFile capture = await _cameraController!.takePicture();
                        await capture.saveTo(directory.path + '$name.jpeg');
                        images.add(capture);
                        setState(() {});
                        // final interpreter = Tflite.loadModel(
                        //     model: 'assets/model.tflite',
                        //     labels: 'assets/labels.txt');
                        // final result = await Tflite.runModelOnImage(
                        //     path: directory.path + '$name.jpeg');
                        // print(result);
                        // final options = LocalLabelerOptions(
                        //     modelPath: 'flutter_assets/assets/model.tflite');
                        // final imagelabeler = ImageLabeler(options: options);
                        // final prediction = imagelabeler.processImage(
                        //     InputImage.fromBytes(
                        //         bytes: await capture.readAsBytes(),
                        //         metadata: InputImageMetadata(
                        //             size: Size.fromWidth(
                        //                 MediaQuery.of(context).size.width),
                        //             rotation: InputImageRotation.rotation0deg,
                        //             format: InputImageFormat.bgra8888,
                        //             bytesPerRow:
                        //                 (await capture.readAsBytes()).length)));
                        // print(prediction);
                      },
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5),
                            border: Border.all(
                                width: 4,
                                color: Colors.white.withOpacity(0.5),
                                strokeAlign: BorderSide.strokeAlignOutside)),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //Implement the syncfusion image to pdf
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          FeatherIcons.check,
                          color: Color(0x80202023),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///A method to show the warning state when no document can be identified in the screen
  void showWarning() {
    state = ScannerState.WARNING;
    setState(() {});
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        state = ScannerState.CAPTURE;
      });
    });
  }

  ///A method to show the error state when the taken page was unsuccessful
  void showError() {
    state = ScannerState.ERROR;
    setState(() {});
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        state = ScannerState.CAPTURE;
      });
    });
  }
}
