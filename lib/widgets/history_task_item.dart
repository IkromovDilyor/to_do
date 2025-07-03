import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/cubits/task_cubit/task_cubit.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/utils/colors/app_colors.dart';
import 'package:to_do/utils/theme/app_text_style.dart';
import 'package:to_do/widgets/dialogs.dart';
import 'package:to_do/widgets/task_item.dart';

class HistoryTaskItem extends StatelessWidget {
  final TaskModel taskModel;

  const HistoryTaskItem({required this.taskModel, super.key});

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
                showCupertinoDeleteDialog(context, () {
                  context.read<TaskCubit>().deleteTask(taskModel.id);
                });
              } else {
                showMaterialDeleteDialog(context, () {
                  context.read<TaskCubit>().deleteTask(taskModel.id);
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
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatDateTime(taskModel.createdAt.toIso8601String()),
                  style: AppTextStyle.size12Weight600.copyWith(
                    color: AppColors.secondaryText,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              taskModel.description,
              style: AppTextStyle.size12Weight500.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
