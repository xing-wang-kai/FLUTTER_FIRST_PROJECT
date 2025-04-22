import 'package:flutter/material.dart';
import 'package:my_frist_flutter_project/data/task_dao.dart';
import 'package:my_frist_flutter_project/widgets/show_my_dialog.dart';

import 'level_stars.dart';

class TaskCardContainer extends StatefulWidget {
  final String taskName;
  final String imageSource;
  final int star;

  const TaskCardContainer(this.taskName, this.imageSource, this.star, {super.key});
  bool isNetWork(){
    if(imageSource.contains("http")){
      return true;
    }
    return false;
  }
  @override
  State<TaskCardContainer> createState() => _TaskCardContainerState();
}

class _TaskCardContainerState extends State<TaskCardContainer> {
  int level = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key("Padding"),
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors. white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.black38,
                      width: 90,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.isNetWork()? Image.network(
                            widget.imageSource,
                            fit: BoxFit.cover,
                            errorBuilder: (
                                BuildContext context,
                                Object exception,
                                StackTrace? stackTrace,
                                ) {
                              return Container();
                            },
                          ): Image.asset(
                            "assets/images/${widget.imageSource}",
                            fit: BoxFit.cover,
                            errorBuilder: (
                                BuildContext context,
                                Object exception,
                                StackTrace? stackTrace,
                                ) {
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.taskName,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        LevelStars(star: widget.star,),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                level++;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add),
                                Text(
                                  "UP!",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onLongPress: (){TaskDao().delete(widget.taskName);},
                            onPressed: () {
                              showMyDialog(context, widget.taskName);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.remove_circle_outlined, color: Colors.red),
                                Text(
                                  "DEL",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        value: (widget.star == 0) ? level/10 : (level/widget.star) / 10,
                        color: Colors.black,
                        backgroundColor: Colors.white38,
                      ),
                    ),
                    Text(
                      "Level -> $level",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}