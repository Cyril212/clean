import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/job/Job.dart';
import 'package:flutter/material.dart';

import 'CommonLabelWidget.dart';

class JobTypeLabelWidget extends StatelessWidget {
  final JobType jobType;
  final String? header;

  const JobTypeLabelWidget({this.jobType = JobType.general, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) CommonLabelWidget(header!),
        Text(
          JobTypeMap[jobType],
          style: TextStyle(fontSize: 11, height: 1.36, color: kColorTextPrimary),
        ),
      ],
    );
  }
}
