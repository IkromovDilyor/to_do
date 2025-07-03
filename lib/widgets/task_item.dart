import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:to_do/cubits/task_cubit/task_cubit.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/utils/colors/app_colors.dart';
import 'package:to_do/utils/theme/app_text_style.dart';
import 'package:to_do/widgets/custom_check_box.dart';
import 'package:to_do/widgets/dialogs.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;
  final TaskCubit taskCubit;

  const TaskItem({required this.taskModel, required this.taskCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) {
              if (Platform.isIOS) {
                showCupertinoDeleteDialog(context,(){
                  taskCubit.deleteTask(taskModel.id);
                } );
              } else {
                showMaterialDeleteDialog(context, () {
                  taskCubit.deleteTask(taskModel.id);
                });
              }
            },
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomCheckBox(
            isChecked: taskModel.isDone,
            onTap: () {
              if (taskModel.isDone) {
                taskCubit.updateTask(taskModel.id, false);
              } else if (!taskModel.isDone) {
                taskCubit.updateTask(taskModel.id, true);
              }
            },
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.lightGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          taskModel.title,
                          style: AppTextStyle.size16Weight700.copyWith(
                            color: AppColors.black,
                            decoration: taskModel.isDone? TextDecoration.lineThrough:TextDecoration.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatDateTime(taskModel.createdAt.toIso8601String()),
                        style: AppTextStyle.size12Weight600.copyWith(
                          color: AppColors.secondaryText,
                          decoration: taskModel.isDone? TextDecoration.lineThrough:TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    taskModel.description,
                    style: AppTextStyle.size12Weight500.copyWith(
                      decoration: taskModel.isDone? TextDecoration.lineThrough:TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDateTime(String isoString) {
  final date = Jiffy.parse(isoString);
  return date.format(pattern: 'dd.MM.yyyy • HH:mm');
}
