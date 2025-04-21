import 'package:fitness/screens/models/product.dart';
import 'package:fitness/screens/product_info_screen.dart';
import 'package:fitness/widgets/camera_frame.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  void _scanBarcode() async {
    try {
      setState(() {
        _activeMode = 'barcode';
        _showTextInput = false;
      });
    } catch (e) {
      setState(() {
        _activeMode = 'camera';
        _showTextInput = false;
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

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.white,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.black,
          size: 28,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTopBar(String title) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close button with consistent styling
          _buildIconButton(
            icon: Icons.close,
            onPressed: () {
              if (_activeMode == 'barcode') {
                setState(() {
                  _activeMode = 'camera';
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),

          // Mode title
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Flash toggle with consistent styling
          _buildIconButton(
            icon: flash ? Icons.flash_on : Icons.flash_off,
            onPressed: () {
              setState(() {
                flash = !flash;
              });
              flash
                  ? _cameraController.setFlashMode(FlashMode.torch)
                  : _cameraController.setFlashMode(FlashMode.off);
            },
          ),
        ],
      ),
    );
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

                          // Return to camera mode and ensure camera is reinitialized
                          setState(() {
                            _activeMode = 'camera';
                            _isLoading = true;
                          });

                          // Reinitialize camera to ensure it works properly after barcode scanning
                          _initializeCamera();

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
                    // Barcode scanning guide
                    // Barcode scanning frame with transparent cutout
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Full screen semi-transparent overlay
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          // Transparent cutout for the scanner
                          // Container(
                          //   width: 280,
                          //   height: 140,
                          //   decoration: BoxDecoration(
                          //     color: Colors.transparent,
                          //     border: Border.all(
                          //       color: Colors.white,
                          //       width: 2.5,
                          //     ),
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          //   // Create transparent hole by using a ClipRect + stack
                          //   child: ClipRect(
                          //     child: Container(
                          //       color: Colors.transparent,
                          //     ),
                          //   ),
                          // ),
                          // // Corner markers for the scan area
                          SizedBox(
                            width: 280,
                            height: 140,
                            child: Stack(
                              children: [
                                // Top-left corner
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 3),
                                        left: BorderSide(
                                            color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                                // Top-right corner
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 3),
                                        right: BorderSide(
                                            color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                                // Bottom-left corner
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 3),
                                        left: BorderSide(
                                            color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                                // Bottom-right corner
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 3),
                                        right: BorderSide(
                                            color: Colors.white, width: 3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Consistent top bar with title, close and flash buttons
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Close button with consistent styling
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _activeMode = 'camera';
                                  });
                                },
                              ),
                            ),
                            // Title
                            Text(
                              'Scan Barcode',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Flash toggle with consistent styling
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  flash ? Icons.flash_on : Icons.flash_off,
                                  color: Colors.black,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    flash = !flash;
                                  });
                                  flash
                                      ? _cameraController
                                          .setFlashMode(FlashMode.torch)
                                      : _cameraController
                                          .setFlashMode(FlashMode.off);
                                },
                              ),
                            ),
                          ],
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
                  ],
                ),
              ),
            // Top Bar with Flash Toggle'
            if (_activeMode == 'camera')
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _buildTopBar('Scan Food'),
              ),
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
                                    _activeMode = 'camera';
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
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _showTextInput
                  ? SizedBox()
                  : Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Camera button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeMode = 'camera';
                                _showTextInput = false;
                                _textController
                                    .clear(); // Optional: clear text when switching modes
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color:
                                    _activeMode == 'camera' && !_showTextInput
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
                                  if (_activeMode == 'camera' &&
                                      !_showTextInput)
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

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeMode = 'barcode';
                                _showTextInput = false;
                                _textController.clear();
                              });
                              _scanBarcode();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color:
                                    _activeMode == 'barcode' && !_showTextInput
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
                                  if (_activeMode == 'barcode' &&
                                      !_showTextInput)
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
              child: _showTextInput
                  ? SizedBox()
                  : Center(
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
