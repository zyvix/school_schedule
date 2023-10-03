import 'package:flutter/material.dart';
import 'package:school_schedule_app/models/room_model.dart';
import 'package:school_schedule_app/services/dbase.dart';

import 'classes.dart';
class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  List items = [];
  bool isLoading = false;

  _apiLoadRooms(){
    setState(() {
      isLoading = true;
    });
    DBase.loadRooms().then((value) => {
      _resLoadRooms(value)
    });
  }

  _resLoadRooms(List rooms) {
    setState(() {
      items = rooms;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiLoadRooms();
  }
  @override
  Widget build(BuildContext context) {

    Widget _itemOfList(RoomModel room){
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            const Divider(),
            GestureDetector(
              child: Text(room.name,
                style: const TextStyle(color: Colors.black, fontSize: 25),),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Classes(room: room),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Classrooms',
          style: TextStyle(color: Colors.black, fontSize: 30,
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
