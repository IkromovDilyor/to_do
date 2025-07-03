import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubits/task_cubit/task_cubit.dart';
import 'package:to_do/utils/enums/enums.dart';
import 'package:to_do/utils/theme/app_text_style.dart';
import 'package:to_do/widgets/history_task_item.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.getTaskStatus == StateStatus.inProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state.getTaskStatus == StateStatus.failure) {
            return Center(child: Text("Fail"));
          } else if (state.getTaskStatus == StateStatus.success) {
            if (state.historyTaskList.isEmpty) {
              return Center(child: Text("Hech narsa topilmadi"));
            } else {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  20 + mediaQuery.padding.top,
                  16,
                  20 + mediaQuery.padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "History",
                      style: AppTextStyle.size26Weight700.copyWith(),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => HistoryTaskItem(
                          taskModel: state.historyTaskList[index],
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12),
                        itemCount: state.historyTaskList.length,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
