import 'package:flutter/material.dart';

// class FoodDetailScreen extends StatefulWidget {
//   const FoodDetailScreen({Key? key}) : super(key: key);

//   @override
//   State<FoodDetailScreen> createState() => _FoodDetailScreenState();
// }

// class _FoodDetailScreenState extends State<FoodDetailScreen> {
//   int quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               color: Colors.black.withOpacity(0.05),
//               child: Stack(
//                 children: [
//                   // Background Image
//                   Positioned.fill(
//                       child: Image.network(
//                     'https://images.unsplash.com/photo-1639667870713-5f5724b0f098?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//                     fit: BoxFit.cover,
//                   )),

//                   // Top Bar
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       padding:
//                           const EdgeInsets.only(top: 40, left: 8, right: 8),
//                       child: SizedBox(
//                         height: 56, // Standard AppBar height
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             // Centered title
//                             const Text(
//                               'Cal AI',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),

//                             // Row with icons on sides
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.7),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: IconButton(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.black),
//                                     onPressed: () {},
//                                   ),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.7),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: IconButton(
//                                     icon: const Icon(Icons.more_horiz,
//                                         color: Colors.black),
//                                     onPressed: () {},
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.save_outlined),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           '15:39',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Food name
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Eggs and',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Text(
//                               'Cheese in a Pan',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Quantity selector
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.remove),
//                                 onPressed: () {
//                                   if (quantity > 1) {
//                                     setState(() {
//                                       quantity--;
//                                     });
//                                   }
//                                 },
//                                 padding: EdgeInsets.zero,
//                                 constraints: const BoxConstraints(),
//                                 iconSize: 24,
//                               ),
//                               const SizedBox(width: 16),
//                               Text(
//                                 '$quantity',
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               IconButton(
//                                 icon: const Icon(Icons.add),
//                                 onPressed: () {
//                                   setState(() {
//                                     quantity++;
//                                   });
//                                 },
//                                 padding: EdgeInsets.zero,
//                                 constraints: const BoxConstraints(),
//                                 iconSize: 24,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 16),

//                     // Nutrition info grid with borders
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: Colors.grey.shade300, width: 1),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   blurRadius: 6,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.local_fire_department,
//                                   color: Colors.orange,
//                                   size: 35,
//                                 ),
//                                 const SizedBox(width: 20),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Calories',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     SizedBox(height: 2),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '500',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 25,
//                                         ),
//                                         Icon(
//                                           Icons.edit_outlined,
//                                           color: Colors.grey.shade600,
//                                           size: 18,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(width: 16),
//                         // Expanded(
//                         //   child: Container(
//                         //     padding: const EdgeInsets.all(8),
//                         //     decoration: BoxDecoration(
//                         //       border: Border.all(
//                         //           color: Colors.grey.shade300, width: 1),
//                         //       borderRadius: BorderRadius.circular(8),
//                         //     ),
//                         //     child: const Row(
//                         //       children: [
//                         //         Icon(
//                         //           Icons.grain,
//                         //           color: Colors.amber,
//                         //           size: 20,
//                         //         ),
//                         //         SizedBox(width: 8),
//                         //         Column(
//                         //           crossAxisAlignment: CrossAxisAlignment.start,
//                         //           children: [
//                         //             Text(
//                         //               'Carbs',
//                         //               style: TextStyle(
//                         //                 color: Colors.grey,
//                         //                 fontSize: 14,
//                         //               ),
//                         //             ),
//                         //             Text(
//                         //               '3g',
//                         //               style: TextStyle(
//                         //                 fontWeight: FontWeight.bold,
//                         //                 fontSize: 16,
//                         //               ),
//                         //             ),
//                         //           ],
//                         //         ),
//                         //         Spacer(),
//                         //         Icon(
//                         //           Icons.edit,
//                         //           color: Colors.grey,
//                         //           size: 16,
//                         //         ),
//                         //       ],
//                         //     ),
//                         //   ),
//                         // ),

//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: Colors.grey.shade300, width: 1),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   blurRadius: 6,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.grain,
//                                   color: Colors.amber,
//                                   size: 35,
//                                 ),
//                                 const SizedBox(width: 20),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Carbs',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 2),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           '3g',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 25),
//                                         Icon(
//                                           Icons.edit_outlined,
//                                           color: Colors.grey.shade600,
//                                           size: 18,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 16),

//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: Colors.grey.shade300, width: 1),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   blurRadius: 6,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.fitness_center,
//                                   color: Colors.red,
//                                   size: 35,
//                                 ),
//                                 const SizedBox(width: 20),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Protein',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 2),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           '35g',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 25),
//                                         Icon(
//                                           Icons.edit_outlined,
//                                           color: Colors.grey.shade600,
//                                           size: 18,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: Colors.grey.shade300, width: 1),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   blurRadius: 6,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.opacity,
//                                   color: Colors.blue,
//                                   size: 35,
//                                 ),
//                                 const SizedBox(width: 20),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Fat',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 2),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           '40g',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 25),
//                                         Icon(
//                                           Icons.edit_outlined,
//                                           color: Colors.grey.shade600,
//                                           size: 18,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 16),

//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Row(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.center, // Center icon vertically
//                         children: [
//                           const Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                             size: 28, // Slightly larger for better balance
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Text(
//                                       'Health Score',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       '8/10',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Container(
//                                   height: 8,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade200,
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: FractionallySizedBox(
//                                         widthFactor: 0.8, // 80% filled
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.green,
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Bottom buttons
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () {},
//                             style: OutlinedButton.styleFrom(
//                               side: BorderSide(color: Colors.grey.shade300),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(24),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.tune,
//                                   color: Colors.black,
//                                   size: 16,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   'Fix Results',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.black,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(24),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                             ),
//                             child: const Text(
//                               'Save',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               // Overlapping share container
//               Positioned(
//                 top: -20, // half above the main container
//                 right: 16, // adjust to position it properly
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: const [
//                       Icon(Icons.share, color: Colors.white, size: 16),
//                       SizedBox(width: 6),
//                       Text(
//                         'Share',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MealTrackerScreen(),
    );
  }
}

class MealTrackerScreen extends StatefulWidget {
  const MealTrackerScreen({Key? key}) : super(key: key);

  @override
  State<MealTrackerScreen> createState() => _MealTrackerScreenState();
}

class _MealTrackerScreenState extends State<MealTrackerScreen> {
  String mealTitle = "Meal title...";
  DateTime selectedDate = DateTime(2024, 8, 24); // Fixed date to match image
  int servingCount = 1;
  List<MealItem> mealItems = [
    MealItem(
        name: "grilled steak", amount: "6 ounces", calories: 430, protein: 38),
    MealItem(
        name: "boiled potatoes", amount: "3 count", calories: 210, protein: 5),
    MealItem(
        name: "sauteed\nmushrooms", amount: "1 cups", calories: 35, protein: 3),
    MealItem(name: "mixed salad", amount: "1 cups", calories: 50, protein: 0),
  ];

  @override
  Widget build(BuildContext context) {
    int totalCalories = mealItems.fold(0, (sum, item) => sum + item.calories);
    int totalProtein = mealItems.fold(0, (sum, item) => sum + item.protein);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.purple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _editMealTitle();
                        },
                        child: Text(
                          mealTitle,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Menu functionality
                      },
                    ),
                  ],
                ),
              ),

              // Meal image and stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.restaurant,
                          size: 40, color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "837",
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "calories",
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    "31",
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "protein",
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    "137",
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "fiber",
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Aug 24, 2024 7:37pm",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Date selector and serving counter in a row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    // Date selector
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12.0),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat("yyyy-MM-dd").format(selectedDate),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Serving counter
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.grey.shade700),
                          onPressed: () {
                            if (servingCount > 1) {
                              setState(() {
                                servingCount--;
                              });
                            }
                          },
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${servingCount}x",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.grey.shade700),
                          onPressed: () {
                            setState(() {
                              servingCount++;
                            });
                          },
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Make changes button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 16, color: Colors.blue.shade600),
                    const SizedBox(width: 8),
                    Text(
                      "Make changes",
                      style: TextStyle(color: Colors.blue.shade600),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Header
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                    left: BorderSide(color: Colors.grey.shade300),
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: const [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Ingredient",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Amount",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Calories",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Protein",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Meal items
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.grey.shade300),
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: mealItems.length,
                    itemBuilder: (context, index) {
                      final item = mealItems[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(item.name),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(item.amount),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${item.calories}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${item.protein}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Totals
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(
                    left: BorderSide(color: Colors.grey.shade300),
                    right: BorderSide(color: Colors.grey.shade300),
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Σ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "$totalCalories",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${totalProtein}g",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          selectedDate.isAfter(DateTime.now()) ? DateTime.now() : selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(), // This restricts to today and before
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _editMealTitle() {
    showDialog(
      context: context,
      builder: (context) {
        String newTitle = mealTitle;
        return AlertDialog(
          title: const Text("Edit Meal Title"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter meal title"),
            onChanged: (value) {
              newTitle = value;
            },
            controller: TextEditingController(text: mealTitle),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  mealTitle = newTitle;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}

class MealItem {
  final String name;
  final String amount;
  final int calories;
  final int protein;

  MealItem({
    required this.name,
    required this.amount,
    required this.calories,
    required this.protein,
  });
}
