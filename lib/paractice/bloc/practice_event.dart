class PracticeEvent {}

class AddInitCate extends PracticeEvent {}

class AddPracticeCategoryEvent extends PracticeEvent {
  final String newCate;
  AddPracticeCategoryEvent({required this.newCate});
}
class GetPracticeListEvent extends PracticeEvent{}