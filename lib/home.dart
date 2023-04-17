// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
//
// import 'ProductDetails.dart';
//
//
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<dynamic> jsonList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     try {
//       final response =
//       await http.get(Uri.parse('http://192.168.29.55:3000/product'));
//       if (response.statusCode == 200) {
//         setState(() {
//           jsonList = json.decode(response.body)["productData"] as List<dynamic>;
//         });
//       } else {
//         print(response.statusCode);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   bool _isLoading = false;
//
//   Future<void> _refresh() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     await getData();
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery
//         .of(context)
//         .size;
//     return Scaffold(
//         body: Column(
//             children: [
//               Expanded(
//                   child: RefreshIndicator(
//                       onRefresh: getData,
//                       child: GridView.builder(
//                           itemCount: jsonList.length,
//                           padding: const EdgeInsets.all(8.0),
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 30,
//                             childAspectRatio: 0.6,
//                           ),
//                           itemBuilder: (BuildContext context, int index) {
//                             return GestureDetector(
//                               onTap: () {
//
//
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         ProductDetails(productData: jsonList[index],
//                                           onProductDetailsPage: true,
//                                         ),
//
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       offset: Offset(0, 3),
//                                       blurRadius: 3,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                             image: jsonList[index]['image'] !=
//                                                 null
//                                                 ? NetworkImage(
//                                                 jsonList[index]['image'])
//                                                 : const AssetImage(
//                                                 'assets/images/placeholder.png')
//                                             as ImageProvider,
//                                             fit: BoxFit.cover,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                               10),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 20, vertical: 5),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment
//                                             .spaceBetween,
//                                         children: [
//                                           Text(
//                                             jsonList[index]['name'] ?? '',
//                                             style: const TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Text(
//                                             "₹",
//                                             style: const TextStyle(
//                                                 fontSize: 0,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Text(
//                                             jsonList[index]['price'] ?? '',
//                                             style: const TextStyle(
//                                                 fontSize: 30,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           })
//                   )
//               )
//             ]
//         ));
//   }
// }


import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import 'ProductDetails.dart';
// import 'package:ui/Screens/product_details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> gradient = const [
    Colors.white,
    Colors.white,
    Color.fromARGB(176, 255, 255, 255),
    Color.fromARGB(92, 255, 255, 255),
    Color.fromARGB(0, 255, 255, 255),
  ];

  final List<String> imageList = [
    'https://images.unsplash.com/photo-1519681393784-d120267933ba',
    'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79',
    'https://images.unsplash.com/photo-1519710164239-da123dc03ef4',
  ];

  List<dynamic> jsonList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      final response = await http.Client()
          .get(Uri.parse('http://192.168.29.55:3000/product'));
      if (response.statusCode == 200) {
        setState(() {
          jsonList = json.decode(response.body)["productData"] as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  bool _isLoading = false;

  Future<void> _refresh() async {
    // TODO: Add your refresh logic here
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay to show the refresh indicator
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imageList.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                body: Center(
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await getData();
              },
              child: GridView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemCount: jsonList.length,
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 30,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(productData: jsonList[index]),
                        ),
                      );
                    },

                    ///API Call
                    ///API Call

                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 3),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: jsonList[index]['image'] != null
                                        ? NetworkImage(jsonList[index]['image'])
                                        : const AssetImage(
                                        'assets/images/placeholder.png')
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  jsonList[index]['name'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "₹",
                                  style: const TextStyle(
                                      fontSize: 0, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  jsonList[index]['price'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
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
        ],
      ),
    );
  }
}