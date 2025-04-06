// import 'package:fitness/screens/image_camera/image_content.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class ImageScreen extends StatefulWidget {
//   const ImageScreen({Key? key}) : super(key: key);

//   @override
//   State<ImageScreen> createState() => _ImageScreenState();
// }

// class _ImageScreenState extends State<ImageScreen> {
//   final ImagePicker _picker = ImagePicker();
//   File? _imageFile;
//   bool _showAnalysis = false;
//   String _selectedMeal = "Lunch";
//   int _selectedDateIndex = 3;
//   final List<DateTime> _allDates = [];

//   String _getDayOfWeek(int weekday) {
//     switch (weekday) {
//       case 1:
//         return "M";
//       case 2:
//         return "T";
//       case 3:
//         return "W";
//       case 4:
//         return "T";
//       case 5:
//         return "F";
//       case 6:
//         return "S";
//       case 7:
//         return "S";
//       default:
//         return "";
//     }
//   }

//   String _getMonthName(int month) {
//     const months = [
//       "January",
//       "February",
//       "March",
//       "April",
//       "May",
//       "June",
//       "July",
//       "August",
//       "September",
//       "October",
//       "November",
//       "December"
//     ];
//     return months[month - 1];
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Generate dates for 3 months before and after current date
//     final DateTime now = DateTime.now();
//     final DateTime startDate = DateTime(now.year, now.month - 3, 1);
//     for (int i = 0; i < 180; i++) {
//       _allDates.add(startDate.add(Duration(days: i)));
//     }
//   }

//   // Updated to match the expected signature in FoodContent
//   void _handleImagePick(ImageSource? source) {
//     if (source == null) {
//       // Handle reset case
//       setState(() {
//         _imageFile = null;
//         _showAnalysis = false;
//       });
//     } else {
//       // Handle image picking
//       _pickImage(source);
//     }
//   }

//   // Keep this as a separate method for actual image picking
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _imageFile = File(pickedFile.path);
//           // In a real app, this would trigger image analysis
//           // For now, we'll just simulate showing analysis after a delay
//           Future.delayed(const Duration(seconds: 1), () {
//             setState(() {
//               _showAnalysis = true;
//             });
//           });
//         });
//       }
//     } catch (e) {
//       // Handle any errors
//       print("Error picking image: $e");
//     }
//   }

//   void _onMealSelected(String meal) {
//     setState(() {
//       _selectedMeal = meal;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Quick Add Food",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Non-scrollable section: Header with date and meal selection
//           Column(
//             children: [
//               // Date indicator with fixed date
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: Column(
//                   children: [
//                     Text(
//                       "${_getMonthName(_allDates[_selectedDateIndex].month)} ${_allDates[_selectedDateIndex].day}",
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     // Fixed date selection row
//                     SizedBox(
//                       height: 62,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: List.generate(7, (index) {
//                           // Show 7 dates centered around the selected date
//                           final adjustedIndex = _selectedDateIndex - 3 + index;
//                           if (adjustedIndex < 0 || adjustedIndex >= _allDates.length) {
//                             return SizedBox(width: 40); // Empty space for out of range dates
//                           }
                          
//                           final date = _allDates[adjustedIndex];
//                           final isToday = date.year == DateTime.now().year &&
//                               date.month == DateTime.now().month &&
//                               date.day == DateTime.now().day;
//                           final isSelected = adjustedIndex == _selectedDateIndex;

//                           return GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _selectedDateIndex = adjustedIndex;
//                               });
//                             },
//                             child: Column(
//                               children: [
//                                 Text(
//                                   _getDayOfWeek(date.weekday),
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: isSelected ? Colors.black : Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Container(
//                                   width: 40,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: isSelected
//                                         ? Colors.grey.shade300
//                                         : isToday
//                                             ? Colors.pink
//                                             : Colors.transparent,
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       date.day.toString(),
//                                       style: TextStyle(
//                                         color: isToday && !isSelected
//                                             ? Colors.white
//                                             : Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: FoodContent(
//               imageFile: _imageFile,
//               showAnalysis: _showAnalysis,
//               selectedMeal: _selectedMeal,
//               onPickImage: _handleImagePick, // Pass the updated handler
//               onMealSelected: _onMealSelected,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:async';

import 'package:fitness/screens/image_camera/image_content.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  bool _showAnalysis = false;
  String _selectedMeal = "Lunch";
  int _selectedDateIndex = 3;
  final List<DateTime> _allDates = [];
  bool _isAnalyzing = false;

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return "M";
      case 2:
        return "T";
      case 3:
        return "W";
      case 4:
        return "T";
      case 5:
        return "F";
      case 6:
        return "S";
      case 7:
        return "S";
      default:
        return "";
    }
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  @override
  void initState() {
    super.initState();
    // Generate dates for 3 months before and after current date
    final DateTime now = DateTime.now();
    final DateTime startDate = DateTime(now.year, now.month - 3, 1);
    for (int i = 0; i < 180; i++) {
      _allDates.add(startDate.add(Duration(days: i)));
    }
    
    // Debug: Check if .env was loaded correctly at initialization
    _checkEnvLoading();
  }
  
  // Debug function to check environment variables
  void _checkEnvLoading() {
    print("===== ENV LOADING CHECK =====");
    try {
      final apiToken = dotenv.env['token'];
      print("API Token exists: ${apiToken != null && apiToken.isNotEmpty}");
      if (apiToken != null) {
        print("Token length: ${apiToken.length}");
        print("Token first 5 chars: ${apiToken.substring(0, apiToken.length > 5 ? 5 : apiToken.length)}...");
      } else {
        print("Token is null. Make sure .env file exists and has 'token=YOUR_API_KEY'");
      }
    } catch (e) {
      print("Error checking token: $e");
    }
    print("===========================");
  }

  // Updated to match the expected signature in FoodContent
  void _handleImagePick(ImageSource? source) {
    print("_handleImagePick called with source: $source");
    if (source == null) {
      // Handle reset case
      print("Resetting image and analysis state");
      setState(() {
        _imageFile = null;
        _showAnalysis = false;
      });
    } else {
      // Handle image picking
      _pickImage(source);
    }
  }

  // Keep this as a separate method for actual image picking
  Future<void> _pickImage(ImageSource source) async {
    try {
      print("Starting image pick from source: $source");
      final XFile? pickedFile = await _picker.pickImage(source: source);
      
      if (pickedFile != null) {
        print("Image picked successfully: ${pickedFile.path}");
        setState(() {
          _imageFile = File(pickedFile.path);
          _isAnalyzing = true;
          _showAnalysis = false;
        });
        
        // Actual image analysis
        await _analyzeImage(File(pickedFile.path));
      } else {
        print("No image was selected");
      }
    } catch (e) {
      // Handle any errors
      print("Error picking image: $e");
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  // Update the _analyzeImage method in your _ImageScreenState class
Future<void> _analyzeImage(File imageFile) async {
  print("Starting image analysis");
  try {
    // Check if API token exists
    final apiToken = dotenv.env['token'];
    if (apiToken == null || apiToken.isEmpty) {
      print("API token is missing from environment variables");
      setState(() {
        _isAnalyzing = false;
        // Add error dialog or message here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("API token is missing. Please check your .env file."),
            backgroundColor: Colors.red,
          ),
        );
      });
      return;
    }

    // Convert image to base64
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print("Image converted to base64, length: ${base64Image.length}");
    
    // Use chat completions API with vision capabilities
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
      body: jsonEncode({
        'model': 'gpt-4o',  // Using GPT-4o with vision capabilities
        'messages': [
          {
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text': 'Analyze the nutritional content of this food image. Return only a JSON with the following fields: foodName, calories, protein, carbs, fat, fiber, sugar. Include units (g, kcal) with the values.'
              },
              {
                'type': 'image_url',
                'image_url': {
                  'url': 'data:image/jpeg;base64,$base64Image'
                }
              }
            ]
          }
        ],
        'max_tokens': 300
      }),
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw TimeoutException("Request timed out. Please try again.");
      },
    );
    
    print("Response status code: ${response.statusCode}");
    
    if (response.statusCode == 200) {
      print("API request successful, processing response");
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print("Response parsed successfully");
      
      // Complete analysis and show results
      setState(() {
        _isAnalyzing = false;
        _showAnalysis = true;
      });
    } else {
      // Handle API error responses with more detailed feedback
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = _getReadableErrorMessage(response.statusCode, errorResponse);
      
      print("API request failed: ${response.statusCode}, ${response.reasonPhrase}");
      print("Response body: ${response.body}");
      
      setState(() {
        _isAnalyzing = false;
        // Show error message to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Details',
              textColor: Colors.white,
              onPressed: () {
                _showErrorDialog(context, errorMessage, errorResponse.toString());
              },
            ),
          ),
        );
      });
    }
  } catch (e) {
    print("Error during image analysis: $e");
    setState(() {
      _isAnalyzing = false;
      // Show user-friendly error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error analyzing image: ${e is TimeoutException ? "Request timed out" : "Please try again"}"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}


String _getReadableErrorMessage(int statusCode, Map<String, dynamic> errorResponse) {
  // Extract error details if available
  final errorType = errorResponse['error']?['type'];
  
  switch (statusCode) {
    case 401:
      return "Authentication error: Please check your API key";
    case 429:
      if (errorType == "insufficient_quota") {
        return "You've exceeded your OpenAI API quota. Please check your billing details.";
      }
      return "Too many requests. Please try again later.";
    case 500:
    case 502:
    case 503:
    case 504:
      return "OpenAI service is currently unavailable. Please try again later.";
    default:
      // For other status codes, return generic message or specific message from API
      final message = errorResponse['error']?['message'];
      return message ?? "Error processing request (${statusCode}). Please try again.";
  }
}

// Show a detailed error dialog
void _showErrorDialog(BuildContext context, String title, String details) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Error Details"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text("Technical details:"),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(details, style: TextStyle(fontFamily: 'monospace')),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close"),
        ),
      ],
    ),
  );
}

  void _onMealSelected(String meal) {
    setState(() {
      _selectedMeal = meal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quick Add Food",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Non-scrollable section: Header with date and meal selection
          Column(
            children: [
              // Date indicator with fixed date
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Text(
                      "${_getMonthName(_allDates[_selectedDateIndex].month)} ${_allDates[_selectedDateIndex].day}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Fixed date selection row
                    SizedBox(
                      height: 62,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(7, (index) {
                          // Show 7 dates centered around the selected date
                          final adjustedIndex = _selectedDateIndex - 3 + index;
                          if (adjustedIndex < 0 || adjustedIndex >= _allDates.length) {
                            return SizedBox(width: 40); // Empty space for out of range dates
                          }
                          
                          final date = _allDates[adjustedIndex];
                          final isToday = date.year == DateTime.now().year &&
                              date.month == DateTime.now().month &&
                              date.day == DateTime.now().day;
                          final isSelected = adjustedIndex == _selectedDateIndex;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDateIndex = adjustedIndex;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  _getDayOfWeek(date.weekday),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? Colors.grey.shade300
                                        : isToday
                                            ? Colors.pink
                                            : Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                        color: isToday && !isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: FoodContent(
              imageFile: _imageFile,
              showAnalysis: _showAnalysis,
              selectedMeal: _selectedMeal,
              onPickImage: _handleImagePick, // Pass the updated handler
              onMealSelected: _onMealSelected,
            ),
          ),
        ],
      ),
    );
  }
}