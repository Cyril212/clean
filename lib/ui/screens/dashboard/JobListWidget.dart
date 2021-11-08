import 'package:clean/model/dataRequest/JobListRequest.dart';
import 'package:clean/model/job/Job.dart';
import 'package:clean/ui/widgets/listTiles/JobItemWidget.dart';
import 'package:clean/ui/widgets/lists/CleanListDataWidget.dart';
import 'package:clean/ui/widgets/loaders/SliverLoadingWidget.dart';
import 'package:flutter/material.dart';

import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'JobsEmptyStateWidget.dart';

enum JobListType { available, ongoing, completed }

class JobListWidget extends StatelessWidget {
  final JobListRequest listRequest;

  JobListWidget({required this.listRequest});

  final bool error = false;
  final bool loading = false;

  @override
  Widget build(BuildContext context) {
    //TODO implement error state
    // if (error) {
    //   return JobsErrorStateWidget(
    //     onTap: () {
    //       //TODO retry
    //     },
    //   );
    // }

    return CleanListDataWidget(
      dataRequest: listRequest,
      emptyState: JobsEmptyStateWidget(
        onTap: () {
          //TODO retry
        },
      ),
      buildItem: (BuildContext context, int position, Job item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16, left: 24, right: 24, top: position == 0 ? 20 : 0),
          child: JobItemWidget(job: item),
        );
      },
      processResult: (JobListRequest dataRequest) {
        return dataRequest.result!.jobList;
      },
      buildLoadingItemWithGlobalKey: (BuildContext context, GlobalKey<State<StatefulWidget>> globalKey) {
       return SliverLoadingWidget(containerKey: globalKey,);
      },

    );
  }
}
