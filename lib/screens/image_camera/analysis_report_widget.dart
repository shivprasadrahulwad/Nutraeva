// import 'package:flutter/material.dart';

// // New separate widget for analysis results
// class AnalysisReportWidget extends StatelessWidget {
//   final VoidCallback onTryAnother;
//   final Map<String, String> nutritionData;
//   final String foodName;
  
//   const AnalysisReportWidget({
//     Key? key,
//     required this.onTryAnother,
//     required this.nutritionData,
//     required this.foodName,
//   }) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.green.shade50,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.analytics_outlined,
//                       color: Colors.green.shade700),
//                   const SizedBox(width: 8),
//                   Text(
//                     "Analysis Results",
//                     style: TextStyle(
//                       color: Colors.green.shade700,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//               Icon(Icons.edit, color: Colors.green.shade700, size: 20),
//             ],
//           ),
//           const SizedBox(height: 16),
          
//           // Nutrition data (non-scrollable)
//           _buildNutritionRow("Food:", foodName),
//           ...nutritionData.entries.map((entry) => 
//             _buildNutritionRow(entry.key, entry.value)
//           ).toList(),
          
//           const SizedBox(height: 16),
          
//           // Footer buttons
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add to daily log logic
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.fastfood, size: 18),
//                       SizedBox(width: 8),
//                       Text(
//                         "Add to Daily Log",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: onTryAnother,
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     side: BorderSide(color: Colors.grey.shade300),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     "Try Another",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNutritionRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.green.shade900,
//               fontSize: 14,
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Updated Response Model for Chat API
class ResponseModel {
  final List<Choice> choices;

  ResponseModel({required this.choices});

  factory ResponseModel.fromJSON(String jsonStr) {
    print("Parsing response JSON: ${jsonStr.substring(0, jsonStr.length > 100 ? 100 : jsonStr.length)}...");
    final Map<String, dynamic> json = jsonDecode(jsonStr);
    final List<dynamic> choicesJson = json['choices'];
    final choices = choicesJson.map((choice) => Choice.fromJson(choice)).toList();
    return ResponseModel(choices: choices);
  }
}

class Choice {
  final String text;

  Choice({required this.text});

  factory Choice.fromJson(Map<String, dynamic> json) {
    // For newer Chat API format
    if (json.containsKey('message')) {
      print("Using Chat API response format");
      return Choice(text: json['message']['content'] ?? '');
    }
    // For older Completions API format
    print("Using Completions API response format");
    return Choice(text: json['text'] ?? '');
  }
}

class AnalysisReportWidget extends StatefulWidget {
  final VoidCallback onTryAnother;
  final String foodInput;
  final bool isLoading;
  
  const AnalysisReportWidget({
    Key? key,
    required this.onTryAnother,
    required this.foodInput,
    this.isLoading = false,
  }) : super(key: key);
  
  @override
  State<AnalysisReportWidget> createState() => _AnalysisReportWidgetState();
}

class _AnalysisReportWidgetState extends State<AnalysisReportWidget> {
  bool _isLoading = false;
  Map<String, String> _nutritionData = {};
  String _foodName = "";
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    
    print("AnalysisReportWidget initialized with foodInput: ${widget.foodInput}");
    print("isLoading: ${widget.isLoading}");
    
    if (!_isLoading && widget.foodInput.isNotEmpty) {
      _fetchAnalysisFromOpenAI();
    }
  }

  Future<void> _fetchAnalysisFromOpenAI() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      print("Starting API request process for text analysis");
      
      // Check if token exists in environment variables
      final apiToken = dotenv.env['token'];
      print("API Token exists: ${apiToken != null && apiToken.isNotEmpty}");
      
      if (apiToken == null || apiToken.isEmpty) {
        print("API token is missing");
        setState(() {
          _errorMessage = "API token is missing. Please add it to your .env file.";
          _isLoading = false;
        });
        return;
      }

      // Prepare the prompt for OpenAI
      final prompt = "Analyze the nutritional content of this meal: ${widget.foodInput}. "
          "Format your response as JSON with the following fields: "
          "foodName, calories, protein, carbs, fat, fiber, sugar. "
          "Include units (g, kcal) with the values.";
      
      print("Sending request to OpenAI API");
      print("Using Chat API endpoint instead of Completions API");
      
      // Using the more current Chat API instead of the deprecated Completions API
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiToken',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo', // Modern model
          'messages': [
            {'role': 'system', 'content': 'You are a nutrition analysis assistant. Respond only with JSON.'},
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 300,
          'temperature': 0,
        })
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print("Request timed out");
          throw Exception("Request timed out. Please try again.");
        },
      );

      print("Response status code: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        print("API request successful, processing response");
        final responseModel = ResponseModel.fromJSON(response.body);
        final text = responseModel.choices[0].text.trim();
        print("Extracted content: ${text.substring(0, text.length > 100 ? 100 : text.length)}...");
        
        try {
          // Try to parse the JSON from the response
          // Extract JSON if the response contains non-JSON text
          final jsonStr = _extractJsonFromText(text);
          print("Extracted JSON: ${jsonStr.substring(0, jsonStr.length > 100 ? 100 : jsonStr.length)}...");
          
          final Map<String, dynamic> data = jsonDecode(jsonStr);
          print("JSON decoded successfully. Keys: ${data.keys.toList()}");
          
          setState(() {
            _foodName = data['foodName'] ?? widget.foodInput;
            _nutritionData = {
              "Calories:": data['calories'] ?? "N/A",
              "Protein:": data['protein'] ?? "N/A",
              "Carbs:": data['carbs'] ?? "N/A",
              "Fat:": data['fat'] ?? "N/A",
              "Fiber:": data['fiber'] ?? "N/A",
              "Sugar:": data['sugar'] ?? "N/A",
            };
            _isLoading = false;
          });
        } catch (e) {
          print("JSON parsing failed: $e");
          // If JSON parsing fails, try to extract nutrition data using patterns
          _extractNutritionFromText(text);
        }
      } else {
        print("API request failed with status ${response.statusCode}: ${response.reasonPhrase}");
        print("Response body: ${response.body}");
        setState(() {
          _errorMessage = "Error ${response.statusCode}: ${response.reasonPhrase}";
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Exception caught in _fetchAnalysisFromOpenAI: $e");
      setState(() {
        _errorMessage = "Error: $e";
        _isLoading = false;
      });
    }
  }

  // Extract JSON from text that might contain additional content
  String _extractJsonFromText(String text) {
    // Try to find JSON data between curly braces
    final RegExp jsonRegex = RegExp(r'{.*}', dotAll: true);
    final match = jsonRegex.firstMatch(text);
    if (match != null) {
      return match.group(0) ?? text;
    }
    return text;
  }

  // Extract nutrition data using patterns if JSON parsing fails
  void _extractNutritionFromText(String text) {
    print("Attempting to extract nutrition data from text using regex patterns");
    setState(() {
      _foodName = widget.foodInput;
      
      // Define regex patterns for common nutrition information
      final caloriesPattern = RegExp(r'calories:?\s*(\d+(?:\.\d+)?(?:\s*kcal)?)', caseSensitive: false);
      final proteinPattern = RegExp(r'protein:?\s*(\d+(?:\.\d+)?(?:\s*g)?)', caseSensitive: false);
      final carbsPattern = RegExp(r'carbs:?\s*(\d+(?:\.\d+)?(?:\s*g)?)', caseSensitive: false);
      final fatPattern = RegExp(r'fat:?\s*(\d+(?:\.\d+)?(?:\s*g)?)', caseSensitive: false);
      final fiberPattern = RegExp(r'fiber:?\s*(\d+(?:\.\d+)?(?:\s*g)?)', caseSensitive: false);
      final sugarPattern = RegExp(r'sugar:?\s*(\d+(?:\.\d+)?(?:\s*g)?)', caseSensitive: false);
      
      // Extract values using regex patterns
      final calories = _extractValue(text, caloriesPattern);
      final protein = _extractValue(text, proteinPattern);
      final carbs = _extractValue(text, carbsPattern);
      final fat = _extractValue(text, fatPattern);
      final fiber = _extractValue(text, fiberPattern);
      final sugar = _extractValue(text, sugarPattern);
      
      print("Extracted values - Calories: $calories, Protein: $protein, Carbs: $carbs, Fat: $fat, Fiber: $fiber, Sugar: $sugar");
      
      _nutritionData = {
        "Calories:": calories ?? "N/A",
        "Protein:": protein ?? "N/A",
        "Carbs:": carbs ?? "N/A",
        "Fat:": fat ?? "N/A",
        "Fiber:": fiber ?? "N/A",
        "Sugar:": sugar ?? "N/A",
      };
      
      _isLoading = false;
    });
  }

  // Helper method to extract values using regex
  String? _extractValue(String text, RegExp pattern) {
    final match = pattern.firstMatch(text);
    return match?.group(1);
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          children: [
            CircularProgressIndicator(color: Colors.green),
            SizedBox(height: 16),
            Text("Analyzing nutritional content...", 
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
          ],
        ),
      );
    }
    
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(_errorMessage, style: TextStyle(color: Colors.red)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.onTryAnother,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text("Try Again"),
            ),
          ],
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.analytics_outlined,
                      color: Colors.green.shade700),
                  const SizedBox(width: 8),
                  Text(
                    "Analysis Results",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Icon(Icons.edit, color: Colors.green.shade700, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          
          // Nutrition data (non-scrollable)
          _buildNutritionRow("Food:", _foodName),
          ...(_nutritionData.entries.map((entry) => 
            _buildNutritionRow(entry.key, entry.value)
          ).toList()),
          
          const SizedBox(height: 16),
          
          // Footer buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Add to daily log logic
                    print("Add to Daily Log clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fastfood, size: 18, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Add to Daily Log",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onTryAnother,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Try Another",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}