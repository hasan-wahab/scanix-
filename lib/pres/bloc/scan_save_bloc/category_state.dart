class CategoryState {
  final List<String> categories;
  final bool loading;

  CategoryState({required this.categories, required this.loading});

  factory CategoryState.initial() {
    return CategoryState(categories: [], loading: true);
  }

  CategoryState copyWith({List<String>? categories, bool? loading}) {
    return CategoryState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
    );
  }
}
