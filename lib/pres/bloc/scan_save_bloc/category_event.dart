abstract class CategoryEvent {}

class InitCategories extends CategoryEvent {}

class LoadCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final String name;
  AddCategory(this.name);
}
