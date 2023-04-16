import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> jsonList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final response =
      await http.get(Uri.parse('http://192.168.29.55:3000/product'));
      if (response.statusCode == 200) {
        setState(() {
          jsonList = json.decode(response.body)["productData"] as List<dynamic>;
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
    setState(() {
      _isLoading = true;
    });

    await getData();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: Column(
            children: [
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: getData,
                      child: GridView.builder(
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
                                            image: jsonList[index]['image'] !=
                                                null
                                                ? NetworkImage(
                                                jsonList[index]['image'])
                                                : const AssetImage(
                                                'assets/images/placeholder.png')
                                            as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
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
                                                fontSize: 0,
                                                fontWeight: FontWeight.bold),
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
                          })
                  )
              )
            ]
        ));
  }
}

class ProductDetails extends StatefulWidget {
   dynamic productData;





  ProductDetails({Key? key, this.productData}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

String? name;
List<dynamic> jsonList = [];
List<Product> products=[];
  Future<void> login() async {
    Map<String, dynamic> data = {'category': name};
    String jsonBody = json.encode(data);

    var response = await http.post(
      Uri.parse('http://192.168.29.55:3000/product/s'),
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      String? jsonString=response.body.toString();
      setState(() {

        jsonList = json.decode(response.body)["productData"] as List<dynamic>;
         products = (jsonDecode(jsonString)['productData'] as List)
            .map((data) => Product.fromJson(data))
            .toList();
      });

    } else {
      print("error");

      // setState(() {
      //
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
     name = widget.productData['category'] ?? '';
   return Scaffold(
     body: SingleChildScrollView(
       // physics: BouncingScrollPhysics(),
       child: SafeArea(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               height: 500,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: widget.productData['image'] != null
                       ? NetworkImage(widget.productData['image'])
                       : const AssetImage('assets/images/placeholder.png')
                   as ImageProvider,
                   fit: BoxFit.cover,
                 ),
               ),
             ),
             Row(

               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 60),
                   child: Text(

                     widget.productData['name'] ?? '',
                     style: const TextStyle(
                         fontSize: 24, fontWeight: FontWeight.bold),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 10
                   ),
                   child: Text(
                     widget.productData['category'] ?? '',
                     style: const TextStyle(
                         fontSize: 24, fontWeight: FontWeight.bold),
                   ),
                 // ),Padding(
                 //   padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 10
                 //   ),
                 //   child: Text(
                 //     widget.productData['category'] ?? '',
                 //     style: const TextStyle(
                 //         fontSize: 24, fontWeight: FontWeight.bold),
                 //   ),
                 ),
               ],
             ),
             Container(
               color: Colors.transparent,
               height: 40,
               width: double.infinity,
               child: TextButton(
                 onPressed: () {
                   //_showSheet(context);
                   login();
                 },
                 child: Text('show more'),
               ),
             ),
             Container(
             child:  GridView.builder(
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               itemCount: products.length,
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 crossAxisSpacing: 10,
                 mainAxisSpacing: 10,
               ),
               itemBuilder: (BuildContext context, int index) {
                 return GridTile(
                   child: Image.network(products[index].image),
                   footer: GridTileBar(
                     backgroundColor: Colors.black54,
                     title: Text(products[index].name),
                     subtitle: Text("\$${products[index].price}"),
                   ),
                 );
               },
             ),)
               ],
    )
    ),

             )
   );

  }
}


class Product {
  final String id;
  final String name;
  final String price;
  final String image;
  final String category;

  Product({required this.id, required this.name, required this.price, required this.image, required this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      category: json['category'],
    );
  }
}
class Sd extends StatefulWidget {
  const Sd({Key? key}) : super(key: key);

  @override
  State<Sd> createState() => _SdState();
}

class _SdState extends State<Sd> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

