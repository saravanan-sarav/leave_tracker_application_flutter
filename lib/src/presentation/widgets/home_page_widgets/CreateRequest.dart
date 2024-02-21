import 'package:flutter/material.dart';

class CreateRequestWidget extends StatelessWidget {
  const CreateRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.37,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create Request",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5),
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius:
                              BorderRadius.circular(20)),
                        ),
                      ),
                      Container(
                        height: 110,
                        width:MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, right: 20, left: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                "Leave Of Absence",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5),
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width *
                              0.4,
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius:
                              BorderRadius.circular(20)),
                        ),
                      ),
                      Container(
                        height: 110,
                        width:
                        MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: const Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, right: 20, left: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0, left: 20),
                              child: Text(
                                "Arrive Late/\nLeave Early",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5),
                        child: Container(
                          height: 120,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius:
                              BorderRadius.circular(20)),
                        ),
                      ),
                      Container(
                        height: 110,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, right: 20, left: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.lock_clock,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                "Remaining Leaves",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width:MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5),
                        child: Container(
                          height: 120,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius:
                              BorderRadius.circular(20)),
                        ),
                      ),
                      Container(
                        height: 110,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: const Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, right: 20, left: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons
                                        .format_list_bulleted_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0, left: 20),
                              child: Text(
                                "Holiday List",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
