import 'package:junior_tools/pages/ActivityAnalyticsView.dart';
import 'package:junior_tools/pages/CredSummaryAnalytics.dart';
import 'package:junior_tools/pages/contact.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart'; // Update with the correct import for FadeInDown

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<dynamic> _services = [
    ['Transfer', Iconsax.export_1, Colors.blue],
    ['Top-up', Iconsax.import, Colors.pink],
    ['Bill', Iconsax.wallet_3, Colors.orange],
    ['More', Iconsax.more, Colors.green],
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 115,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _services.length,
                    itemBuilder: (context, index) {
                      return FadeInDown(
                        duration: Duration(milliseconds: (index + 1) * 100),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: GestureDetector(
                            onTap: () {
                              if (_services[index][0] == 'Transfer') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactPage(),
                                  ),
                                );
                              } else if (_services[index][0] == 'Top-up') {
                                print("Top-up");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CredSummaryAnalyticsView(context: context),
                                  ),
                                );
                              }  
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _services[index][1],
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _services[index][0],
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            );
  }
}