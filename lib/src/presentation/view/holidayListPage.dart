import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leave_tracker_application/src/presentation/providers/holidaysProvider.dart';

import '../../domain/models/holiday.dart';

class HolidayListPage extends ConsumerWidget {
  const HolidayListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<int, List<Holiday>> holidaysByMonth =
        ref.read(holidaysProvider.notifier).getSortedState();

    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.blue.shade900,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, right: 20, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Holiday List",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(top: 80),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView.builder(
              itemCount: holidaysByMonth.length,
              itemBuilder: (context, index) {
                int month = holidaysByMonth.keys.elementAt(index);
                String monthName = DateFormat('MMMM')
                    .format(DateTime(DateTime.now().year, month));
                List<Holiday> monthHolidays = holidaysByMonth[month]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Text(
                        monthName,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: monthHolidays.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              Text(
                                monthHolidays[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  monthHolidays[index].holidayTypeId == 2
                                      ? "(${monthHolidays[index].holidayTypeId})"
                                      : "",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          subtitle: Text(
                            DateFormat('dd MMMM yyyy')
                                .format(monthHolidays[index].date),
                            style: const TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8),
                      child: Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.blue.shade900,
                      ),
                    ), // Optional: Add a divider between months
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
