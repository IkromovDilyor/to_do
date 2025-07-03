import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubits/task_cubit/task_cubit.dart';
import 'package:to_do/service/shared_preference_storage.dart';
import 'package:to_do/utils/constants/store_keys.dart';
import 'package:to_do/utils/enums/enums.dart';
import 'package:to_do/utils/theme/app_text_style.dart';
import 'package:to_do/widgets/task_item.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    SharedPreferenceStorage.setString(key: "test", value: "testtest");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          print(SharedPreferenceStorage.getString(StoreKeys.accessToken));
          print(SharedPreferenceStorage.getString("test"));
          var taskCubit = context.read<TaskCubit>();

          if (state.getTaskStatus == StateStatus.initial) {
            taskCubit.getTask();
          } else if (state.getTaskStatus == StateStatus.inProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state.getTaskStatus == StateStatus.failure) {
            return Center(child: Text("Fail"));
          } else if (state.getTaskStatus == StateStatus.success) {
            if (state.taskList.isEmpty) {
              return Center(child: Text("Hech narsa topilmadi"));
            }
            return RefreshIndicator(
              onRefresh: () {
                taskCubit.getTask();
                return Future.delayed(Duration(seconds: 2));
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  20 + mediaQuery.padding.top,
                  16,
                  20 + mediaQuery.padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("My tasks", style: AppTextStyle.size26Weight700),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => TaskItem(
                          taskCubit: taskCubit,
                          taskModel: state.taskList[index],
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12),
                        itemCount: state.taskList.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
