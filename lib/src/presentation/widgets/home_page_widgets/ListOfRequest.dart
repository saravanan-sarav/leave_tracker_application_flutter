import 'package:flutter/material.dart';

class ListOfRequestWidget extends StatefulWidget {
  const ListOfRequestWidget({super.key});

  @override
  State<ListOfRequestWidget> createState() => _ListOfRequestWidgetState();
}

class _ListOfRequestWidgetState extends State<ListOfRequestWidget> {
  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.white;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "List Of Requests",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: containerColor,
                  // Container background color
                  borderRadius: BorderRadius.circular(15),
                  // Adjust border radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200, // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 5, // Blur radius
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Created By Me...",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            height: 25,
                            width: 30,
                            child: Center(
                                child: Text(
                              "21",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
