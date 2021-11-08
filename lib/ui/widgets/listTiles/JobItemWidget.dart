import 'dart:convert';

import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/job/Job.dart';
import 'package:clean/ui/screens/jobDetail/JobDetailScreen.dart';
import 'package:clean/ui/widgets/lables/PlaceLabelWidget.dart';
import 'package:clean/ui/widgets/lables/TimeSpanLabelWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

class JobItemWidget extends StatelessWidget {
  final Job job;

  const JobItemWidget({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Container(
          width: 44,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    job.startDate.day.toString(),
                    style: TextStyle(color: kColorTextPrimary, fontSize: 19, height: 1.4, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.MMM().format(job.startDate).toUpperCase(),
                    style: TextStyle(color: kColorTextPrimary, fontSize: 11, height: 1.4, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              onTap: () {
                pushNamed(context, JobDetailScreen.ROUTE, arguments: {'job': jsonEncode(job)});
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: kCardBoxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.serviceName,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kColorTextPrimary),
                    ),
                    SizedBox(height: 6),
                    Text(
                      job.place!.address.fullAddress,
                      style: TextStyle(fontSize: 11, color: kColorTextPrimary),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        PlaceLabelWidget(type: job.place!.placeType),
                        SizedBox(width: 20),
                        TimeSpanLabelWidget(startTime: job.startDate, endTime: job.endDate)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
