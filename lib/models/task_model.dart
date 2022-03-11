import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_app/models/item_model.dart';
import 'package:flutter/cupertino.dart';

class TaskModel extends ChangeNotifier {
  //item list
  List<Item> pitem = <Item>[];
  int? pending;
  int? complete;
  final Box box = Hive.box('Item');

  //fetching items
  void getAllUser() {
    final result = box.values.cast<Item>();
    if (result.isNotEmpty) {
      pitem.clear();
      pitem.addAll(result);
      pending = result.where((element) => !element.check).length;
      complete = result.where((element) => element.check).length;
      notifyListeners();
    } else {
      pitem = <Item>[];
      pending = 0;
      complete = 0;
      notifyListeners();
    }
  }

  //progres bar logic
  double progress() {
    if (complete == 0) {
      return 0.0;
    } else {
      double sum = ((complete!.toDouble()) / pitem.length.toDouble());
      if (sum == 0) {
        return 1.0;
      } else {
        return sum;
      }
    }
  }

  //filter result logic
  List<Item> fresult = <Item>[];
  void filterSearch(String query) {
    List<Item> result = <Item>[];
    if (query.isNotEmpty) {
      result = pitem
          .where((element) =>
              element.body.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    fresult.clear();
    fresult.addAll(result);
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
