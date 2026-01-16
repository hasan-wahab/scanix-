import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_app/pres/bloc/scan_save_bloc/category_event.dart';
import 'package:scan_app/pres/bloc/scan_save_bloc/category_state.dart';
import '../../../data/storage/category_storage.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState.initial()) {
    on<InitCategories>(_init);
    on<AddCategory>(_add);
  }

  /// 🔹 First time init + load
  Future<void> _init(InitCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(loading: true));

    await CategoryStorage.initIfNeeded();

    final list = await CategoryStorage.getList();

    emit(state.copyWith(categories: list, loading: false));
  }

  /// 🔹 Add new category
  Future<void> _add(AddCategory event, Emitter<CategoryState> emit) async {
    final name = event.name.trim();

    if (name.isEmpty) return;
    if (state.categories.contains(name)) return;

    await CategoryStorage.add(name);

    final updatedList = List<String>.from(state.categories)..add(name);

    emit(state.copyWith(categories: updatedList));
  }
}
