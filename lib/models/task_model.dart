import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_app/models/item_model.dart';
import 'package:flutter/cupertino.dart';

class TaskModel extends ChangeNotifier {
  //item list
  List<Item> pitem = <Item>[];
  int? pending;
  int complete = 0;
  double sum = 0;
  final Box box = Hive.box('Item');

  //fetching items
  void getAllUser() {
    final result = box.values.cast<Item>();
    if (result.isNotEmpty) {
      pitem.clear();
      pitem.addAll(result);
      pending = result.where((element) => !element.check).length;
      complete = result.where((element) => element.check).length;
      if (pitem.isEmpty || complete == 0) {
        sum = 0.0;
      } else {
        double a = (complete.toDouble() / result.length.toDouble());
        if (a == 0) {
          sum = 0.0;
        } else {
          sum = a;
        }
      }
      notifyListeners();
    } else {
      pitem = <Item>[];
      pending = 0;
      complete = 0;
      sum = 0;
      notifyListeners();
    }
  }

  //filter result logic
  List<Item> fresult = <Item>[];
  void filterSearch(String query) {
    fresult.clear();
    if (query.isEmpty) {
      notifyListeners();
      return;
    }
    for (var element in pitem) {
      if (element.body.contains(query)) {
        fresult.add(element);
      }
    }
    notifyListeners();
  }

  //add Item
  void addItem(Item item) {
    box.add(item);
    notifyListeners();
  }

  //remove Item
  void removeItem(int index) {
    box.deleteAt(index);
    notifyListeners();
  }

  //toogle item
  void toogleTask(Item item, int index) {
    //final itemIndex = pitem.indexOf(item);
    item.toogleCompleted();
    var itm = Item(body: item.body, check: item.check);
    box.putAt(index, itm);
    notifyListeners();
  }

  //update Item
  void updateItem(Item itm, int index) async {
    var item = Item(body: itm.body, check: itm.check);
    box.putAt(index, item);
    notifyListeners();
  }
}
