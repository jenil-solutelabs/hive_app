import 'package:hive/hive.dart';
part 'item_model.g.dart';

@HiveType(typeId: 2)
class Item {
  @HiveField(0)
  final String body;
  @HiveField(1)
  bool check;
  Item({required this.body, required this.check});
  void toogleCompleted() {
    check = !check;
  }
}
