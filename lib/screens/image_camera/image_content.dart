import 'package:fitness/screens/image_camera/analysis_report_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


// class FoodContent extends StatefulWidget {
//   final Function(ImageSource?) onPickImage;  // Modified to accept null for reset
//   final File? imageFile;
//   final bool showAnalysis;
//   final String selectedMeal;
//   final Function(String) onMealSelected;
  
//   const FoodContent({
//     Key? key,
//     required this.onPickImage,
//     required this.imageFile,
//     required this.showAnalysis,
//     required this.selectedMeal,
//     required this.onMealSelected,
//   }) : super(key: key);

//   @override
//   State<FoodContent> createState() => _FoodContentState();
// }

// class _FoodContentState extends State<FoodContent> {
//   // Add state to track the selected input method
//   String _selectedInput = "Image"; // Default to Image
//   bool _showTextAnalysis = false;
//   TextEditingController _textController = TextEditingController();

//   // Reset function to restore the initial state
//   void _resetState() {
//     setState(() {
//       _showTextAnalysis = false;
//       _textController.clear();
//     });
    
//     // Notify parent to reset image
//     if (_selectedInput == "Image") {
//       widget.onPickImage(null); // Passing null signals reset
//     }
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildMealOption("Breakfast"),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _buildMealOption("Lunch"),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildMealOption("Dinner"),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _buildMealOption("Snack"),
//                   ),
//                 ],
//               ),
//             ),
            
//             const SizedBox(height: 20),
            
//             // New container with Image/Text toggle buttons
//             Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   // Image button
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedInput = "Image";
//                           _showTextAnalysis = false; // Reset text analysis when switching tabs
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: _selectedInput == "Image" ? Colors.green : Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(7),
//                             bottomLeft: Radius.circular(7),
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Image",
//                             style: TextStyle(
//                               color: _selectedInput == "Image" ? Colors.white : Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
                  
//                   // Text button
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedInput = "Text";
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: _selectedInput == "Text" ? Colors.green : Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(7),
//                             bottomRight: Radius.circular(7),
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Text",
//                             style: TextStyle(
//                               color: _selectedInput == "Text" ? Colors.white : Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             const SizedBox(height: 20),
            
//             // Conditional content based on selected input method
//             if (_selectedInput == "Image")
//               _buildImageContent()
//             else
//               _buildTextContent(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextContent() {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "What did you eat?",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Icon(Icons.info_outline, size: 16,color: Colors.blueGrey,),
//                   SizedBox(width: 5,),
//                   Text('I have had chapati, dal, rice, and aloo bhaji.',style: TextStyle(color: Colors.blueGrey),)
//                 ],
//               ),
//               if (!_showTextAnalysis)
//               SizedBox(height: 16,),
//               if (!_showTextAnalysis)
//               TextField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   hintText: "Type food name or description",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: Colors.green),
//                   ),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 16),
//               if (!_showTextAnalysis)
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Show analysis results when Analyze is clicked
//                       setState(() {
//                         _showTextAnalysis = true;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Analyze",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               if (_showTextAnalysis)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: _buildAnalysisResults(),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // New method to contain image content (previously in build method)
//   Widget _buildImageContent() {
//     return Column(
//       children: [
//         // Image preview
//         if (widget.imageFile != null)
//           Container(
//             height: 180,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               image: DecorationImage(
//                 image: FileImage(widget.imageFile!),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           )
//         else
//           Container(
//             height: 180,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.grey.shade200,
//             ),
//             child: const Center(
//               child: Icon(
//                 Icons.image,
//                 size: 80,
//                 color: Colors.grey,
//               ),
//             ),
//           ),

//         const SizedBox(height: 16),

//         // Analysis results or image source options
//         if (widget.showAnalysis)
//           _buildAnalysisResults()
//         else if (widget.imageFile != null)
//           const Center(
//             child: CircularProgressIndicator(
//               color: Colors.green,
//             ),
//           )
//         else
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildImageSourceButton(
//                   icon: Icons.photo_library,
//                   label: "Gallery",
//                   onPressed: () => widget.onPickImage(ImageSource.gallery),
//                 ),
//                 _buildImageSourceButton(
//                   icon: Icons.camera_alt,
//                   label: "Camera",
//                   onPressed: () => widget.onPickImage(ImageSource.camera),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildMealOption(String meal) {
//     bool isSelected = widget.selectedMeal == meal;
//     return GestureDetector(
//       onTap: () {
//         widget.onMealSelected(meal);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green : Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.green : Colors.grey.shade300,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             meal,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAnalysisResults() {
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
//           _buildNutritionRow("Food:", "Steak with Butter"),
//           _buildNutritionRow("Calories:", "700 kcal"),
//           _buildNutritionRow("Protein:", "60g"),
//           _buildNutritionRow("Carbs:", "0g"),
//           _buildNutritionRow("Fat:", "50g"),
//           _buildNutritionRow("Fiber:", "0g"),
//           _buildNutritionRow("Sugar:", "0g"),
          
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
//                   onPressed: () {
//                     // Reset the state
//                     _resetState();
//                   },
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

//   Widget _buildImageSourceButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Colors.green.shade100,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               size: 30,
//               color: Colors.green,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
















// class FoodContent extends StatefulWidget {
//   final Function(ImageSource?) onPickImage;  // Modified to accept null for reset
//   final File? imageFile;
//   final bool showAnalysis;
//   final String selectedMeal;
//   final Function(String) onMealSelected;
  
//   const FoodContent({
//     Key? key,
//     required this.onPickImage,
//     required this.imageFile,
//     required this.showAnalysis,
//     required this.selectedMeal,
//     required this.onMealSelected,
//   }) : super(key: key);

//   @override
//   State<FoodContent> createState() => _FoodContentState();
// }

// class _FoodContentState extends State<FoodContent> {
//   // Add state to track the selected input method
//   String _selectedInput = "Image"; // Default to Image
//   bool _showTextAnalysis = false;
//   TextEditingController _textController = TextEditingController();

//   // Sample nutrition data - in a real app this would come from an API or database
//   final Map<String, String> _nutritionData = {
//     "Calories:": "700 kcal",
//     "Protein:": "60g",
//     "Carbs:": "0g",
//     "Fat:": "50g",
//     "Fiber:": "0g",
//     "Sugar:": "0g",
//   };
  
//   final String _foodName = "Steak with Butter";

//   // Reset function to restore the initial state
//   void _resetState() {
//     setState(() {
//       _showTextAnalysis = false;
//       _textController.clear();
//     });
    
//     // Notify parent to reset image
//     if (_selectedInput == "Image") {
//       widget.onPickImage(null); // Passing null signals reset
//     }
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildMealOption("Breakfast"),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _buildMealOption("Lunch"),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildMealOption("Dinner"),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _buildMealOption("Snack"),
//                   ),
//                 ],
//               ),
//             ),
            
//             const SizedBox(height: 20),
            
//             // New container with Image/Text toggle buttons
//             Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   // Image button
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedInput = "Image";
//                           _showTextAnalysis = false; // Reset text analysis when switching tabs
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: _selectedInput == "Image" ? Colors.green : Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(7),
//                             bottomLeft: Radius.circular(7),
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Image",
//                             style: TextStyle(
//                               color: _selectedInput == "Image" ? Colors.white : Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
                  
//                   // Text button
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedInput = "Text";
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: _selectedInput == "Text" ? Colors.green : Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(7),
//                             bottomRight: Radius.circular(7),
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "Text",
//                             style: TextStyle(
//                               color: _selectedInput == "Text" ? Colors.white : Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             const SizedBox(height: 20),
            
//             // Conditional content based on selected input method
//             if (_selectedInput == "Image")
//               _buildImageContent()
//             else
//               _buildTextContent(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextContent() {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "What did you eat?",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Icon(Icons.info_outline, size: 16, color: Colors.blueGrey),
//                   SizedBox(width: 5),
//                   Text('I have had chapati, dal, rice, and aloo bhaji.', style: TextStyle(color: Colors.blueGrey))
//                 ],
//               ),
//               if (!_showTextAnalysis)
//                 SizedBox(height: 16),
//               if (!_showTextAnalysis)
//                 TextField(
//                   controller: _textController,
//                   decoration: InputDecoration(
//                     hintText: "Type food name or description",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.green),
//                     ),
//                   ),
//                   maxLines: 3,
//                 ),
//               SizedBox(height: 16),
//               if (!_showTextAnalysis)
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Show analysis results when Analyze is clicked
//                       setState(() {
//                         _showTextAnalysis = true;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Analyze",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               if (_showTextAnalysis)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: AnalysisReportWidget(
//                     onTryAnother: _resetState,
//                     nutritionData: _nutritionData,
//                     foodName: _foodName,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // New method to contain image content (previously in build method)
//   Widget _buildImageContent() {
//     return Column(
//       children: [
//         // Image preview
//         if (widget.imageFile != null)
//           Container(
//             height: 180,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               image: DecorationImage(
//                 image: FileImage(widget.imageFile!),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           )
//         else
//           Container(
//             height: 180,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.grey.shade200,
//             ),
//             child: const Center(
//               child: Icon(
//                 Icons.image,
//                 size: 80,
//                 color: Colors.grey,
//               ),
//             ),
//           ),

//         const SizedBox(height: 16),

//         // Analysis results or image source options
//         if (widget.showAnalysis)
//           AnalysisReportWidget(
//             onTryAnother: _resetState,
//             nutritionData: _nutritionData,
//             foodName: _foodName,
//           )
//         else if (widget.imageFile != null)
//           const Center(
//             child: CircularProgressIndicator(
//               color: Colors.green,
//             ),
//           )
//         else
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildImageSourceButton(
//                   icon: Icons.photo_library,
//                   label: "Gallery",
//                   onPressed: () => widget.onPickImage(ImageSource.gallery),
//                 ),
//                 _buildImageSourceButton(
//                   icon: Icons.camera_alt,
//                   label: "Camera",
//                   onPressed: () => widget.onPickImage(ImageSource.camera),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildMealOption(String meal) {
//     bool isSelected = widget.selectedMeal == meal;
//     return GestureDetector(
//       onTap: () {
//         widget.onMealSelected(meal);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green : Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? Colors.green : Colors.grey.shade300,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             meal,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImageSourceButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Colors.green.shade100,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               size: 30,
//               color: Colors.green,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
























class FoodContent extends StatefulWidget {
  final Function(ImageSource?) onPickImage;  // Modified to accept null for reset
  final File? imageFile;
  final bool showAnalysis;
  final String selectedMeal;
  final Function(String) onMealSelected;
  
  const FoodContent({
    Key? key,
    required this.onPickImage,
    required this.imageFile,
    required this.showAnalysis,
    required this.selectedMeal,
    required this.onMealSelected,
  }) : super(key: key);

  @override
  State<FoodContent> createState() => _FoodContentState();
}

class _FoodContentState extends State<FoodContent> {
  // Add state to track the selected input method
  String _selectedInput = "Image"; // Default to Image
  bool _showTextAnalysis = false;
  bool _isAnalyzing = false;
  TextEditingController _textController = TextEditingController();

  // Reset function to restore the initial state
  void _resetState() {
    setState(() {
      _showTextAnalysis = false;
      _isAnalyzing = false;
      _textController.clear();
    });
    
    // Notify parent to reset image
    if (_selectedInput == "Image") {
      widget.onPickImage(null); // Passing null signals reset
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildMealOption("Breakfast"),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildMealOption("Lunch"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildMealOption("Dinner"),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildMealOption("Snack"),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // New container with Image/Text toggle buttons
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  // Image button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedInput = "Image";
                          _showTextAnalysis = false; // Reset text analysis when switching tabs
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedInput == "Image" ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Image",
                            style: TextStyle(
                              color: _selectedInput == "Image" ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Text button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedInput = "Text";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedInput == "Text" ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Text",
                            style: TextStyle(
                              color: _selectedInput == "Text" ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Conditional content based on selected input method
            if (_selectedInput == "Image")
              _buildImageContent()
            else
              _buildTextContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What did you eat?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.blueGrey),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'I have had chapati, dal, rice, and aloo bhaji.',
                      style: TextStyle(color: Colors.blueGrey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (!_showTextAnalysis)
                SizedBox(height: 16),
              if (!_showTextAnalysis)
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: "Type food name or description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    // Trigger rebuild to update button state
                    setState(() {});
                  },
                ),
              SizedBox(height: 16),
              if (!_showTextAnalysis)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _textController.text.isEmpty 
                      ? null  // Disable button if text is empty
                      : () {
                          // Show analysis results when Analyze is clicked
                          setState(() {
                            _showTextAnalysis = true;
                            _isAnalyzing = true;
                          });
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Analyze",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (_showTextAnalysis)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: AnalysisReportWidget(
                    onTryAnother: _resetState,
                    foodInput: _textController.text,
                    isLoading: _isAnalyzing,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // New method to contain image content (previously in build method)
  Widget _buildImageContent() {
    return Column(
      children: [
        // Image preview
        if (widget.imageFile != null)
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: FileImage(widget.imageFile!),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 80,
                color: Colors.grey,
              ),
            ),
          ),

        const SizedBox(height: 16),

        // Analysis results or image source options
        if (widget.showAnalysis)
          AnalysisReportWidget(
            onTryAnother: _resetState,
            foodInput: "Food from image", // In a real app, we'd pass the image analysis result
            isLoading: false,
          )
        else if (widget.imageFile != null)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceButton(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  onPressed: () => widget.onPickImage(ImageSource.gallery),
                ),
                _buildImageSourceButton(
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onPressed: () => widget.onPickImage(ImageSource.camera),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildMealOption(String meal) {
    bool isSelected = widget.selectedMeal == meal;
    return GestureDetector(
      onTap: () {
        widget.onMealSelected(meal);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            meal,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}