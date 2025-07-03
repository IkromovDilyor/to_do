import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/cubits/create_task/create_task_cubit.dart';
import 'package:to_do/models/task_params.dart';
import 'package:to_do/utils/enums/enums.dart';
import 'package:to_do/widgets/custom_text_field.dart';
import 'package:to_do/widgets/cutom_button.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  const CreateTaskBottomSheet({super.key});

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return BlocProvider(
      create: (_) => CreateTaskCubit(),
      child: BlocConsumer<CreateTaskCubit, CreateTaskState>(
        listener: (context, state) {
          if (state.createStatus == StateStatus.success ||
              state.createStatus == StateStatus.failure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop(state.createStatus);
            });
          }
        },
        builder: (context, state) {
          var cubit = context.read<CreateTaskCubit>();
          return Padding(
            padding: EdgeInsets.only(bottom: viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header row
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Create a new task",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: titleController,
                    hintText: "Task name",
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: "Description",
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    isLoading: state.createStatus == StateStatus.inProgress,
                    text: "Save",
                    onTap: () {
                      cubit.createTask(
                        TaskParams(
                          description: descriptionController.text.trim(),
                          title: titleController.text.trim(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<dynamic> showCreateTaskBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const CreateTaskBottomSheet(),
  );
}
