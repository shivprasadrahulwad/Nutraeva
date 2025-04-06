// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'dart:math' as math;

// List<CameraDescription> cameras = [];

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
//   late CameraController _cameraController;
//   Future<void>? cameraValue;
//   bool flash = false;
//   double _minAvailableZoom = 1.0;
//   double _maxAvailableZoom = 1.0;
//   double _currentZoom = 1.0;

//   // Active scanning mode
//   String _activeMode = 'camera'; // 'camera', 'barcode', 'gallery', 'text'
//   bool _showTextInput = false;
//   final TextEditingController _textController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _initializeCamera();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _cameraController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!_cameraController.value.isInitialized) {
//       return;
//     }
//     if (state == AppLifecycleState.inactive) {
//       _cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       _initializeCamera();
//     }
//   }

//   Future<void> _initializeCamera() async {
//     if (cameras.isEmpty) {
//       try {
//         cameras = await availableCameras();
//       } catch (e) {
//         debugPrint('Error getting cameras: $e');
//       }
//     }

//     if (cameras.isNotEmpty) {
//       _cameraController = CameraController(
//         cameras[0],
//         ResolutionPreset.max,
//         enableAudio: false,
//         imageFormatGroup: ImageFormatGroup.jpeg,
//       );

//       cameraValue = _cameraController.initialize().then((_) async {
//         if (!mounted) return;

//         // Get zoom range
//         _maxAvailableZoom = await _cameraController.getMaxZoomLevel();
//         _minAvailableZoom = await _cameraController.getMinZoomLevel();

//         setState(() {});
//       });
//     } else {
//       debugPrint('No cameras found');
//     }
//   }

//   void _scanBarcode() async {
//     try {
//       String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.BARCODE
//       );

//       if (barcodeScanRes != '-1') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Barcode found: $barcodeScanRes'),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error scanning barcode: $e');
//     }
//   }

//   void _pickImageFromGallery() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Image selected: ${image.path}'),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error picking image: $e');
//     }
//   }

//   void _toggleTextInput() {
//     setState(() {
//       _showTextInput = !_showTextInput;
//       if (!_showTextInput) {
//         _textController.clear();
//       }
//     });
//   }

//   void _submitTextInput() {
//     if (_textController.text.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Text submitted: ${_textController.text}'),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//       setState(() {
//         _showTextInput = false;
//         _textController.clear();
//       });
//     }
//   }

//   void takePhoto(BuildContext context) async {
//     try {
//       XFile file = await _cameraController.takePicture();

//       // The captured image path is in file.path
//       debugPrint('Image captured: ${file.path}');

//       // Show a brief capture indication
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Image captured!'),
//           duration: Duration(seconds: 1),
//         ),
//       );
//     } catch (e) {
//       debugPrint('Error taking picture: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Camera Preview
//             FutureBuilder(
//               future: cameraValue,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return Container(
//                     width: double.infinity,
//                     height: double.infinity,
//                     child: CameraPreview(_cameraController),
//                   );
//                 } else {
//                   return Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           "Getting camera ready...",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               }
//             ),

//             // Square Framing Guide with Curved Corners
//             Center(
//               child: Container(
//                 width: 250,
//                 height: 250,
//                 child: CustomPaint(
//                   painter: CurvedFramingGuidePainter(),
//                 ),
//               ),
//             ),

//             // Top Bar with Flash Toggle
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 60,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.4),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Back button
//                     IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back,
//                         color: Colors.white,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),

//                     // Flash toggle button
//                     IconButton(
//                       icon: Icon(
//                         flash ? Icons.flash_on : Icons.flash_off,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           flash = !flash;
//                         });
//                         flash
//                           ? _cameraController.setFlashMode(FlashMode.torch)
//                           : _cameraController.setFlashMode(FlashMode.off);
//                       }
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Text input overlay - only shows when text input mode active
//             if (_showTextInput)
//               Positioned(
//                 bottom: 100,
//                 left: 16,
//                 right: 16,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _textController,
//                           decoration: const InputDecoration(
//                             hintText: 'Enter text...',
//                             border: InputBorder.none,
//                           ),
//                           onSubmitted: (_) => _submitTextInput(),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.send),
//                         onPressed: _submitTextInput,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             // Bottom Control Bar with Rounded Container
//             Positioned(
//               bottom: 20,
//               left: 20,
//               right: 20,
//               child: Container(
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Camera button
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _activeMode = 'camera';
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: _activeMode == 'camera' ? Colors.grey.withOpacity(0.2) : Colors.transparent,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.camera_alt,
//                               color: Colors.black87,
//                               size: 20,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               'Scan Food',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     // Divider
//                     Container(
//                       height: 30,
//                       width: 1,
//                       color: Colors.grey[300],
//                     ),

//                     // Barcode button
//                     GestureDetector(
//                       onTap: _scanBarcode,
//                       child: Icon(
//                         Icons.qr_code_scanner,
//                         color: Colors.black87,
//                         size: 24,
//                       ),
//                     ),

//                     // Divider
//                     Container(
//                       height: 30,
//                       width: 1,
//                       color: Colors.grey[300],
//                     ),

//                     // Gallery button
//                     GestureDetector(
//                       onTap: _pickImageFromGallery,
//                       child: Icon(
//                         Icons.photo_library,
//                         color: Colors.black87,
//                         size: 24,
//                       ),
//                     ),

//                     // Divider
//                     Container(
//                       height: 30,
//                       width: 1,
//                       color: Colors.grey[300],
//                     ),

//                     // Text input button
//                     GestureDetector(
//                       onTap: _toggleTextInput,
//                       child: Icon(
//                         Icons.edit,
//                         color: Colors.black87,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Camera Capture Button (now above the rounded container)
//             Positioned(
//               bottom: 100,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: GestureDetector(
//                   onTap: () => takePhoto(context),
//                   child: Container(
//                     height: 70,
//                     width: 70,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 3,
//                       ),
//                     ),
//                     child: Center(
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom Painter for Drawing the Curved Framing Guide
// class CurvedFramingGuidePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final double cornerSize = 35.0;
//     final double curveRadius = 8.0;

//     // Top-left corner
//     final Path topLeftPath = Path()
//       ..moveTo(curveRadius, 0)
//       ..lineTo(cornerSize, 0)
//       ..moveTo(0, curveRadius)
//       ..lineTo(0, cornerSize);
//     canvas.drawPath(topLeftPath, paint);

//     // Draw curved corner
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(curveRadius, curveRadius), radius: curveRadius),
//       math.pi,
//       math.pi/2,
//       false,
//       paint
//     );

//     // Top-right corner
//     final Path topRightPath = Path()
//       ..moveTo(size.width - curveRadius, 0)
//       ..lineTo(size.width - cornerSize, 0)
//       ..moveTo(size.width, curveRadius)
//       ..lineTo(size.width, cornerSize);
//     canvas.drawPath(topRightPath, paint);

//     // Draw curved corner
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(size.width - curveRadius, curveRadius), radius: curveRadius),
//       -math.pi/2,
//       math.pi/2,
//       false,
//       paint
//     );

//     // Bottom-left corner
//     final Path bottomLeftPath = Path()
//       ..moveTo(curveRadius, size.height)
//       ..lineTo(cornerSize, size.height)
//       ..moveTo(0, size.height - curveRadius)
//       ..lineTo(0, size.height - cornerSize);
//     canvas.drawPath(bottomLeftPath, paint);

//     // Draw curved corner
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(curveRadius, size.height - curveRadius), radius: curveRadius),
//       math.pi/2,
//       math.pi/2,
//       false,
//       paint
//     );

//     // Bottom-right corner
//     final Path bottomRightPath = Path()
//       ..moveTo(size.width - curveRadius, size.height)
//       ..lineTo(size.width - cornerSize, size.height)
//       ..moveTo(size.width, size.height - curveRadius)
//       ..lineTo(size.width, size.height - cornerSize);
//     canvas.drawPath(bottomRightPath, paint);

//     // Draw curved corner
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(size.width - curveRadius, size.height - curveRadius), radius: curveRadius),
//       0,
//       math.pi/2,
//       false,
//       paint
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/screens/models/product.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

import 'package:mobile_scanner/mobile_scanner.dart';

// Import your product model

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late CameraController _cameraController;
  Future<void>? cameraValue;
  bool flash = false;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoom = 1.0;

  // Active scanning mode
  String _activeMode = 'camera'; // 'camera', 'barcode', 'gallery', 'text'
  bool _showTextInput = false;
  final TextEditingController _textController = TextEditingController();

  // Loading state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    if (cameras.isEmpty) {
      try {
        cameras = await availableCameras();
      } catch (e) {
        debugPrint('Error getting cameras: $e');
      }
    }

    if (cameras.isNotEmpty) {
      _cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      cameraValue = _cameraController.initialize().then((_) async {
        if (!mounted) return;

        // Get zoom range
        _maxAvailableZoom = await _cameraController.getMaxZoomLevel();
        _minAvailableZoom = await _cameraController.getMinZoomLevel();

        setState(() {});
      });
    } else {
      debugPrint('No cameras found');
    }
  }

 Future<void> _scanBarcode() async {
  try {
    setState(() {
      _activeMode = 'barcode';
      _showTextInput = false; // Ensure text input UI is hidden
    });

    // Show overlay message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Aim at a barcode to scan'),
        duration: Duration(seconds: 2),
      ),
    );
  } catch (e) {
    setState(() {
      _activeMode = 'camera';
      _showTextInput = false; // Ensure text input UI is hidden
    });

    debugPrint('Error scanning barcode: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error scanning: $e'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

  Future<Product?> fetchProductByBarcode(String barcode) async {
    try {
      final response = await http.get(Uri.parse(
          'https://world.openfoodfacts.org/api/v0/product/$barcode.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 1) {
          return Product.fromOpenFoodFacts(barcode, data['product']);
        } else {
          debugPrint('Product not found');
          return null;
        }
      } else {
        debugPrint('Failed to load product data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching product data: $e');
      return null;
    }
  }

  void _showProductInfoSheet(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: ProductInfoWidget(product: product),
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image selected: ${image.path}'),
            duration: const Duration(seconds: 2),
          ),
        );
        // TODO: Implement image-based food recognition
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _toggleTextInput() {
    setState(() {
      _showTextInput = !_showTextInput;
      if (_showTextInput) {
        _activeMode = 'text';
      } else {
        _activeMode = 'camera';
        _textController.clear();
      }
    });
  }

  void _submitTextInput() {
    if (_textController.text.isNotEmpty) {
      // Process the food data - this would integrate with your app's food tracking system
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Food added: ${_textController.text}'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Return to camera mode
      setState(() {
        _showTextInput = false;
        _activeMode = 'camera';
        _textController.clear();
      });
    }
  }

  void takePhoto(BuildContext context) async {
    try {
      XFile file = await _cameraController.takePicture();

      // The captured image path is in file.path
      debugPrint('Image captured: ${file.path}');

      // Show a brief capture indication
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image captured!'),
          duration: Duration(seconds: 1),
        ),
      );

      // TODO: Implement image-based food recognition
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            FutureBuilder(
                future: cameraValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: CameraPreview(_cameraController),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Getting camera ready...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),

            // Square Framing Guide with Curved Corners
            Center(
              child: Container(
                width: 250,
                height: 250,
                child: CustomPaint(
                  painter: CurvedFramingGuidePainter(),
                ),
              ),
            ),

            // Loading overlay
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Loading product information...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Barcode Scanner Overlay
            if (_activeMode == 'barcode')
              Container(
                color: Colors.black.withOpacity(0.7),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: MobileScannerController(
                        facing: CameraFacing.back,
                        torchEnabled: flash,
                      ),
                      onDetect: (BarcodeCapture capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty &&
                            barcodes[0].rawValue != null) {
                          final String barcode = barcodes[0].rawValue!;

                          // Return to camera mode
                          setState(() {
                            _activeMode = 'camera';
                            _isLoading = true;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Scanning product information...'),
                              duration: Duration(seconds: 1),
                            ),
                          );

                          // Fetch product data
                          fetchProductByBarcode(barcode).then((product) {
                            setState(() {
                              _isLoading = false;
                            });

                            if (product != null) {
                              // Show product information
                              _showProductInfoSheet(product);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Product not found. Try another barcode.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          });
                        }
                      },
                    ),
                    // Barcode scanning guide and UI elements
                    Center(
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            _activeMode = 'camera';
                          });
                        },
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Scan Barcode',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Position the barcode within the frame',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    // Flash toggle button
                    Positioned(
                      top: 30,
                      right: 16,
                      child: IconButton(
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController.setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        },
                      ),
                    ),
                  ],
                ),
              ),

            // Top Bar with Flash Toggle'
            if (_activeMode == 'camera')
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),

                      // Flash toggle button
                      IconButton(
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          }),
                    ],
                  ),
                ),
              ),

            // Text input overlay - only shows when text input mode active
            // Text input overlay - redesigned to match the screenshot
            if (_showTextInput)
              Positioned.fill(
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Header with back button
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  setState(() {
                                    _showTextInput = false;
                                    _textController.clear();
                                  });
                                },
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                'Describe Meal',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Input field
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'Apple pineapple',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            autofocus: true,
                          ),
                        ),

                        // AI badge
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.auto_awesome, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'Created by AI',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Hint text
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Providing more context, including portion sizes, improves accuracy',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Add Food button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: ElevatedButton(
                            onPressed: () {
                              _submitTextInput();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              'Add Food',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // Keyboard suggestion strip (static representation)
                        Container(
                          height: 40,
                          color: Colors.grey.shade200,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('juice', style: TextStyle(fontSize: 14)),
                              Text('is', style: TextStyle(fontSize: 14)),
                              Text('and', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Bottom Control Bar with Rounded Container
            // Bottom Control Bar with Rounded Container
// Bottom Control Bar with Rounded Container
            // Positioned(
            //   bottom: 20,
            //   left: 20,
            //   right: 20,
            //   child: Container(
            //     height: 70,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         // Camera button
            //         GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               _activeMode = 'camera';
            //             });
            //           },
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 12, vertical: 8),
            //             decoration: BoxDecoration(
            //               color: _activeMode == 'camera'
            //                   ? Colors.grey.withOpacity(0.2)
            //                   : Colors.transparent,
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.camera_alt,
            //                   color: Colors.black87,
            //                   size: 20,
            //                 ),
            //                 const SizedBox(width: 4),
            //                 if (_activeMode != 'barcode' &&
            //                     _activeMode != 'text')
            //                   Text(
            //                     'Scan Food',
            //                     style: TextStyle(
            //                       color: Colors.black87,
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //               ],
            //             ),
            //           ),
            //         ),

            //         // Divider
            //         Container(
            //           height: 30,
            //           width: 1,
            //           color: Colors.grey[300],
            //         ),

            //         // Barcode button
            //         GestureDetector(
            //           onTap: _scanBarcode,
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 12, vertical: 8),
            //             decoration: BoxDecoration(
            //               color: _activeMode == 'barcode'
            //                   ? Colors.grey.withOpacity(0.2)
            //                   : Colors.transparent,
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.qr_code_scanner,
            //                   color: Colors.black87,
            //                   size: 20,
            //                 ),
            //                 const SizedBox(width: 4),
            //                 if (_activeMode == 'barcode')
            //                   Text(
            //                     'Scan Barcode',
            //                     style: TextStyle(
            //                       color: Colors.black87,
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //               ],
            //             ),
            //           ),
            //         ),

            //         // Divider
            //         Container(
            //           height: 30,
            //           width: 1,
            //           color: Colors.grey[300],
            //         ),

            //         // Gallery button
            //         GestureDetector(
            //           onTap: _pickImageFromGallery,
            //           child: Icon(
            //             Icons.photo_library,
            //             color: Colors.black87,
            //             size: 24,
            //           ),
            //         ),

            //         // Divider
            //         Container(
            //           height: 30,
            //           width: 1,
            //           color: Colors.grey[300],
            //         ),

            //         // Text input button
            //         GestureDetector(
            //           onTap: _toggleTextInput,
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 12, vertical: 8),
            //             decoration: BoxDecoration(
            //               color: _activeMode == 'text'
            //                   ? Colors.grey.withOpacity(0.2)
            //                   : Colors.transparent,
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.edit,
            //                   color: Colors.black87,
            //                   size: 20,
            //                 ),
            //                 const SizedBox(width: 4),
            //                 if (_activeMode == 'text')
            //                   Text(
            //                     'Describe Food',
            //                     style: TextStyle(
            //                       color: Colors.black87,
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Bottom Control Bar with Rounded Container
Positioned(
  bottom: 20,
  left: 20,
  right: 20,
  child: Container(
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Camera button
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       _activeMode = 'camera';
        //       _showTextInput = false;
        //     });
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(
        //         horizontal: 12, vertical: 8),
        //     decoration: BoxDecoration(
        //       color: _activeMode == 'camera'
        //           ? Colors.grey.withOpacity(0.2)
        //           : Colors.transparent,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Row(
        //       children: [
        //         Icon(
        //           Icons.camera_alt,
        //           color: Colors.black87,
        //           size: 20,
        //         ),
        //         const SizedBox(width: 4),
        //         if (_activeMode != 'barcode' &&
        //             _activeMode != 'text')
        //           Text(
        //             'Scan Food',
        //             style: TextStyle(
        //               color: Colors.black87,
        //               fontSize: 14,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),
        //       ],
        //     ),
        //   ),
        // ),

        // Camera button
GestureDetector(
  onTap: () {
    setState(() {
      _activeMode = 'camera';
      _showTextInput = false;
      _textController.clear(); // Optional: clear text when switching modes
    });
  },
  child: Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: _activeMode == 'camera' && !_showTextInput
          ? Colors.grey.withOpacity(0.2)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(
          Icons.camera_alt,
          color: Colors.black87,
          size: 20,
        ),
        const SizedBox(width: 4),
        if (_activeMode == 'camera' && !_showTextInput)
          Text(
            'Scan Food',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    ),
  ),
),

        // Divider
        Container(
          height: 30,
          width: 1,
          color: Colors.grey[300],
        ),

        // Barcode button
        // Barcode button
GestureDetector(
  onTap: () {
    setState(() {
      _activeMode = 'barcode';
      _showTextInput = false; // Ensure text input UI is hidden
      _textController.clear(); // Optional: clear text when switching modes
    });
    _scanBarcode(); // Call the existing scan barcode function
  },
  child: Container(
    padding: const EdgeInsets.symmetric(
        horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: _activeMode == 'barcode' && !_showTextInput
          ? Colors.grey.withOpacity(0.2)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(
          Icons.qr_code_scanner,
          color: Colors.black87,
          size: 20,
        ),
        const SizedBox(width: 4),
        if (_activeMode == 'barcode' && !_showTextInput)
          Text(
            'Scan Barcode',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    ),
  ),
),
        // Divider
        Container(
          height: 30,
          width: 1,
          color: Colors.grey[300],
        ),

        // Gallery button
        GestureDetector(
          onTap: _pickImageFromGallery,
          child: Icon(
            Icons.photo_library,
            color: Colors.black87,
            size: 24,
          ),
        ),

        // Divider
        Container(
          height: 30,
          width: 1,
          color: Colors.grey[300],
        ),

        // Text input button
        GestureDetector(
          onTap: () {
            setState(() {
              _activeMode = 'text';
              _showTextInput = true;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _activeMode == 'text'
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.black87,
                  size: 20,
                ),
                const SizedBox(width: 4),
                if (_activeMode == 'text')
                  Text(
                    'Describe Food',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
),
            // Camera Capture Button (now above the rounded container)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => takePhoto(context),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






















class ProductInfoWidget extends StatelessWidget {
  final Product product;

  const ProductInfoWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with drag indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Product image and basic info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: product.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.no_food),
                          ),
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.no_food, size: 50),
                        ),
                ),
              ),
              const SizedBox(width: 16),

              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.brand,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.qr_code, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            product.barcode,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Serving size: ${product.nutritionFacts.servingSize}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Nutrition facts header
          const Text(
            'Nutrition Facts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),

          // Quick nutrition summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNutritionSummaryItem(
                  'Calories',
                  '${product.nutritionFacts.calories.toStringAsFixed(0)} kcal',
                  Colors.orange,
                ),
                _buildNutritionSummaryItem(
                  'Proteins',
                  '${product.nutritionFacts.proteins.toStringAsFixed(1)}g',
                  Colors.green,
                ),
                _buildNutritionSummaryItem(
                  'Carbs',
                  '${product.nutritionFacts.carbohydrates.toStringAsFixed(1)}g',
                  Colors.blue,
                ),
                _buildNutritionSummaryItem(
                  'Fat',
                  '${product.nutritionFacts.fat.toStringAsFixed(1)}g',
                  Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Detailed nutrition facts
          _buildNutritionFactRow('Proteins',
              '${product.nutritionFacts.proteins.toStringAsFixed(1)}g'),
          _buildNutritionFactRow('Carbohydrates',
              '${product.nutritionFacts.carbohydrates.toStringAsFixed(1)}g'),
          _buildNutritionFactRow('  - Sugars',
              '${product.nutritionFacts.sugar.toStringAsFixed(1)}g'),
          _buildNutritionFactRow('  - Fiber',
              '${product.nutritionFacts.fiber.toStringAsFixed(1)}g'),
          _buildNutritionFactRow(
              'Fat', '${product.nutritionFacts.fat.toStringAsFixed(1)}g'),
          _buildNutritionFactRow(
              'Salt', '${product.nutritionFacts.salt.toStringAsFixed(2)}g'),
          const SizedBox(height: 20),

          // Nutritional chart
          const Text(
            'Macro Ratio',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: CustomPaint(
              size: const Size(double.infinity, 100),
              painter: MacroBarPainter(
                proteins: product.nutritionFacts.proteins,
                carbs: product.nutritionFacts.carbohydrates,
                fats: product.nutritionFacts.fat,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Proteins', Colors.green),
              const SizedBox(width: 20),
              _buildLegendItem('Carbs', Colors.blue),
              const SizedBox(width: 20),
              _buildLegendItem('Fats', Colors.red),
            ],
          ),
          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add to Diary'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    // TODO: Add to food diary
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to food diary'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.favorite_border),
                label: const Text('Save'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // TODO: Save to favorites
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saved to favorites'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getNutritionIcon(label),
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  IconData _getNutritionIcon(String nutrient) {
    switch (nutrient) {
      case 'Calories':
        return Icons.local_fire_department;
      case 'Proteins':
        return Icons.fitness_center;
      case 'Carbs':
        return Icons.grain;
      case 'Fat':
        return Icons.opacity;
      default:
        return Icons.info;
    }
  }

  Widget _buildNutritionFactRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

// Custom painter for macro ratio visualization
class MacroBarPainter extends CustomPainter {
  final double proteins;
  final double carbs;
  final double fats;

  MacroBarPainter({
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double total = proteins + carbs + fats;

    // If there's no data or all zeros, draw empty bars
    if (total <= 0) {
      _drawEmptyBars(canvas, size);
      return;
    }

    final double proteinWidth = (proteins / total) * size.width;
    final double carbWidth = (carbs / total) * size.width;
    final double fatWidth = (fats / total) * size.width;

    final double height = size.height * 0.6;
    final double top = (size.height - height) / 2;

    // Draw protein bar
    final paintProtein = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, top, proteinWidth, height),
        const Radius.circular(8),
      ),
      paintProtein,
    );

    // Draw carb bar
    final paintCarb = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(proteinWidth, top, carbWidth, height),
        const Radius.circular(8),
      ),
      paintCarb,
    );

    // Draw fat bar
    final paintFat = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(proteinWidth + carbWidth, top, fatWidth, height),
        const Radius.circular(8),
      ),
      paintFat,
    );

    // Draw percentages if there's enough space
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    if (proteinWidth > 30) {
      _drawTextCentered(
        canvas,
        '${(proteins / total * 100).toStringAsFixed(0)}%',
        textStyle,
        Offset(proteinWidth / 2, size.height / 2),
      );
    }

    if (carbWidth > 30) {
      _drawTextCentered(
        canvas,
        '${(carbs / total * 100).toStringAsFixed(0)}%',
        textStyle,
        Offset(proteinWidth + carbWidth / 2, size.height / 2),
      );
    }

    if (fatWidth > 30) {
      _drawTextCentered(
        canvas,
        '${(fats / total * 100).toStringAsFixed(0)}%',
        textStyle,
        Offset(proteinWidth + carbWidth + fatWidth / 2, size.height / 2),
      );
    }
  }

  void _drawEmptyBars(Canvas canvas, Size size) {
    final double height = size.height * 0.6;
    final double top = (size.height - height) / 2;

    final paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, top, size.width, height),
        const Radius.circular(8),
      ),
      paint,
    );

    // Draw "No data" text
    final textStyle = TextStyle(
      color: Colors.grey[600],
      fontSize: 14,
    );

    _drawTextCentered(
      canvas,
      'No nutritional data',
      textStyle,
      Offset(size.width / 2, size.height / 2),
    );
  }

  void _drawTextCentered(
      Canvas canvas, String text, TextStyle style, Offset position) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final dx = position.dx - textPainter.width / 2;
    final dy = position.dy - textPainter.height / 2;
    textPainter.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(MacroBarPainter oldDelegate) {
    return oldDelegate.proteins != proteins ||
        oldDelegate.carbs != carbs ||
        oldDelegate.fats != fats;
  }
}

// Curved framing guide painter (also add this since it's referenced in the original code)
class CurvedFramingGuidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final double cornerSize = 30;
    final double width = size.width;
    final double height = size.height;

    // Draw top-left corner
    canvas.drawLine(
      Offset(0, cornerSize),
      Offset(0, 0),
      paint,
    );
    canvas.drawLine(
      Offset(0, 0),
      Offset(cornerSize, 0),
      paint,
    );

    // Draw top-right corner
    canvas.drawLine(
      Offset(width - cornerSize, 0),
      Offset(width, 0),
      paint,
    );
    canvas.drawLine(
      Offset(width, 0),
      Offset(width, cornerSize),
      paint,
    );

    // Draw bottom-left corner
    canvas.drawLine(
      Offset(0, height - cornerSize),
      Offset(0, height),
      paint,
    );
    canvas.drawLine(
      Offset(0, height),
      Offset(cornerSize, height),
      paint,
    );

    // Draw bottom-right corner
    canvas.drawLine(
      Offset(width - cornerSize, height),
      Offset(width, height),
      paint,
    );
    canvas.drawLine(
      Offset(width, height - cornerSize),
      Offset(width, height),
      paint,
    );
  }

  @override
  bool shouldRepaint(CurvedFramingGuidePainter oldDelegate) => false;
}

class MobileScannerWidget extends StatelessWidget {
  final Function(BarcodeCapture) onDetect;
  final MobileScannerController controller;

  const MobileScannerWidget({
    Key? key,
    required this.onDetect,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MobileScanner(
          controller: controller,
          onDetect: onDetect,
        ),
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
