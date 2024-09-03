import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool rollCan = true;
  List<String> images = [
    "assets/back.jpeg",
    "assets/side.jpeg",
    "assets/front.jpeg"
  ];
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void startRoll(){
    _pageController.animateToPage(2, duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut,);
  }
  void reverseRoll(){
    _pageController.animateToPage(0, duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut,);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          rollCan = !rollCan;
          if(rollCan){
            reverseRoll();
          }else{
            startRoll();
          }
        });
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              right: rollCan ? -150: MediaQuery.sizeOf(context).width / 3,
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 400,
                      width: 150,
                      foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Stack(
                        alignment: Alignment.center,
                        children:[
                          PageView.builder(
                          controller: _pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin:const  EdgeInsets.only(left: 10),
                              width: 5,
                              height: double.infinity,
                            decoration:const  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5
                                )
                              ]
                            ),

                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin:const  EdgeInsets.only(right: 10),
                              width: 5,
                              height: double.infinity,
                              decoration:const  BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10
                                    )
                                  ]
                              ),

                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin:const  EdgeInsets.only(right: 10),
                              width: 10,
                              height: double.infinity,
                              decoration:const  BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 30
                                    )
                                  ]
                              ),

                            ),
                          ),
                          ]
                      ),
                    ),
                  ),
                  Container(
                    height: 6,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
