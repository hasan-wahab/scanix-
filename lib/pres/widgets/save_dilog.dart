import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/histrory.dart';
import 'package:scan_app/data/storage/recent_history.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_bloc.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_event.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_event.dart';

import '../bloc/scan_save_bloc/category_bloc.dart';
import '../bloc/scan_save_bloc/category_event.dart';
import '../bloc/scan_save_bloc/category_state.dart';

class ScanSaveDialog extends StatefulWidget {
  final String? scanName;
  final String? scanedData;
  final int? index;

  const ScanSaveDialog({super.key, this.scanName, this.scanedData, this.index});

  @override
  State<ScanSaveDialog> createState() => _ScanSaveDialogState();

  static Widget inputField({
    required String hint,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _ScanSaveDialogState extends State<ScanSaveDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(InitCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Center(
                child: Text(
                  widget.scanName ?? 'Scan Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Scan name input
              ScanSaveDialog.inputField(
                hint: 'Scan Name',
                controller: nameController,
              ),

              const SizedBox(height: 16),

              const Text(
                'Optional Category',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 8),

              /// CATEGORY DROPDOWN
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  // ✅ FIX: agar selected value list me nahi hai
                  if (selectedCategory != null &&
                      !state.categories.contains(selectedCategory)) {
                    selectedCategory = null;
                  }

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedCategory,
                        hint: const Text(
                          'Select category',
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: [
                          ...state.categories.map(
                            (cat) =>
                                DropdownMenuItem(value: cat, child: Text(cat)),
                          ),
                          const DropdownMenuItem(
                            value: '__add_new__',
                            child: Row(
                              children: [
                                Icon(Icons.add, size: 18),
                                SizedBox(width: 8),
                                Text('Add new category'),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == '__add_new__') {
                            _showAddCategoryDialog(context);
                          } else {
                            setState(() => selectedCategory = value);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveScan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveScan() async {
    final scanName = nameController.text.isNotEmpty
        ? nameController.text
        : 'No Name';

    final model = HistoryModel(
      scanType: scanName,
      data: widget.scanedData,
      dateTime: DateTime.now().toString(),
      category: selectedCategory,
      productName: scanName,
      isSaved: true,
    );

    final result = await History.saveData(key: 'data', model: model);

    if (!mounted) return;

    context.read<HistoryBloc>().add(SaveDataEvent(isSaveInHistory: result));
    if (widget.index != null) {
      await RecentHistoryStorage.updateRecentHistory(
        isSaved: true,
        index: widget.index!,
      );
      if (!mounted) return;
      context.read<HomePageBloc>().add(HomeGetHistoryEvent());
    }
    Navigator.pop(context);
  }

  // Future<void> _updateScan() async {
  //   final scanName = nameController.text.isNotEmpty
  //       ? nameController.text
  //       : 'No Name';
  //
  //   final model = HistoryModel(
  //     scanType: scanName,
  //     data: widget.scanedData,
  //     dateTime: DateTime.now().toString(),
  //     category: selectedCategory,
  //     productName: scanName,
  //     isSaved: true,
  //   );
  //
  //   final result = await History.saveData(key: 'data', model: model);
  //
  //   if (!mounted) return;
  //
  //   context.read<HistoryBloc>().add(SaveDataEvent(isSaveInHistory: result));
  //   Navigator.pop(context);
  // }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Category'),
        content: TextField(
          controller: newCategoryController,
          decoration: const InputDecoration(hintText: 'Category name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              newCategoryController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = newCategoryController.text.trim();
              if (name.isNotEmpty) {
                context.read<CategoryBloc>().add(AddCategory(name));
                setState(() => selectedCategory = name);
              }
              newCategoryController.clear();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
