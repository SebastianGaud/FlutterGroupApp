import 'dart:async';
import 'package:flutter/material.dart';
import 'package:triptaptoe_app/models/TripDTO.dart';
import 'package:triptaptoe_app/screens/profile_screen.dart';
import 'package:triptaptoe_app/widgets/Exchange_body.dart';
import 'package:triptaptoe_app/services/readJson.dart';
import 'package:triptaptoe_app/widgets/home_screen_bottom_navigation_bar.dart';
import 'package:triptaptoe_app/widgets/trip_card.dart';
import 'trip_details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TripDTO>> tripArrayFuture;
  List<TripDTO> tripArray = [];
  bool isHome = true;
  Widget _screenBody = HomeScreenBody();
  bool _isInHOme = true;

  void setScreenBody(index) {
    setState(() {
      switch (index) {
        case 0:
          _screenBody = const ExchangeBody();
          isHome = false;
          break;
        case 1:
          _screenBody = const HomeScreenBody();
          isHome = true;
          break;
        case 2:
          _screenBody = const ProfileScreen();
          isHome = false;
        default:
          _screenBody = const HomeScreenBody();
          isHome = true;
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    tripArrayFuture = readJson();
    tripArrayFuture.then((value) {
      setState(() {
        tripArray = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //readJson();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(53, 16, 79, 1),
          toolbarHeight: 64,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/logo.png",
                ))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: isHome
            ? FloatingActionButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripDetailsScreen()),
                  )
                },
                hoverColor: Color.fromRGBO(99, 31, 147, 1),
                backgroundColor: Color.fromRGBO(53, 16, 79, 1),
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              )
            : null,
        bottomNavigationBar: HomeScreenBottomNavigationBar(
            onPressed: (index) => {setScreenBody(index)}),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _screenBody,
        ));
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<TripDTO>>(
            future: readJson(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print({'sn': snapshot.data});
                if (snapshot.data!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: (snapshot.data!).length,
                      itemBuilder: (context, index) {
                        print("snapsht data" + (snapshot.data!).toString());
                        return TripCard(
                          trip: snapshot.data![index],
                          index: index,
                          onPressedDelete: () => setState(() {}),
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 240,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "There are no trips yet.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(45, 45, 45, 1)),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "You can add a trip by clicking on the '+' button",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(45, 45, 45, 1)),
                            )
                          ],
                        ),
                      )
                    ],
                  ));
                }
              } else {
                return Container();
              }
            },
          )
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: tripArray.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return TripCard(
          //         trip: tripArray[index],
          //         index: index,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
