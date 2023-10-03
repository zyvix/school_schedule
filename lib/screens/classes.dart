import 'package:flutter/material.dart';
import 'package:school_schedule_app/models/class_model.dart';

import '../models/room_model.dart';
import '../services/dbase.dart';
class Classes extends StatefulWidget {
  final ClassModel? group;
  final RoomModel? room;
  const Classes({Key? key, this.group, this.room}) : super(key: key);

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  List items = [];
  bool isLoading = false;

  _apiLoadClass(){
    setState(() {
      isLoading = true;
    });
    DBase.loadClasses(room: widget.room).then((value) => {
      _resLoadClass(value)
    });
  }

  _resLoadClass(List rooms) {
    setState(() {
      items = rooms;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiLoadClass();
  }

  @override
  Widget build(BuildContext context) {

    Widget _itemOfList(ClassModel group){
      return Container(
        height: 60,
        color: group.group.contains("Green") ? Colors.green : group.group.contains("Blue") ? Colors.blue : Colors.purple,
        child: Column(
          children: [
            const Divider(thickness: 5, color: Colors.white, height: 0,),
            Row(
              children: [
                SizedBox(height: 50,),
                SizedBox(width: 10,),
                Text(group.id,
                  style: TextStyle(color: Colors.white, fontSize: 25),),
                Expanded(
                  child: Text(group.group,
                    style: const TextStyle(color: Colors.white,
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Classes", style: TextStyle(color: Colors.black, fontSize: 30,
            fontWeight: FontWeight.bold),),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            reverse: false,
            itemBuilder: (ctx, index){
              return _itemOfList(items[index]);
            },
          ),
          isLoading ? const Center(
            child: CircularProgressIndicator(),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
