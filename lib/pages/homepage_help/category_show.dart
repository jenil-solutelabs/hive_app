import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/application/text.dart';
import 'package:hive_app/models/task_model.dart';

//catogery model
class Catogery {
  final int? numOfTask;
  final String title;
  Catogery({required this.numOfTask, required this.title});
}

//Showing to
class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //calculate size of the grid
    var size = MediaQuery.of(context).size;
    final double itemheight = (size.height - kToolbarHeight - 24) / 3;
    final double itemwidth = size.width;
    var pro = Provider.of<TaskModel>(context);
    //list for category
    List<Catogery> cat = [
      Catogery(numOfTask: pro.complete, title: ApplicationText.completeTask),
      Catogery(numOfTask: pro.pending, title: ApplicationText.pendingTask)
    ];
    //grid view builder
    return GridView.builder(
        controller: ScrollController(keepScrollOffset: true),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cat.length,
        itemBuilder: (context, index) {
          return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 33, 71, 1),
                  borderRadius: BorderRadius.circular(25)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                      cat[index].numOfTask.toString() + ApplicationText.task,
                      style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.w100)),
                ),
                subtitle: Text(cat[index].title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: (itemwidth / itemheight)));
  }
}
