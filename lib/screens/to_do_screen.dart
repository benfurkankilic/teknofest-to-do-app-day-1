import 'package:flutter/material.dart';
import 'package:teknofest_todo_app_demo/models/to_do.dart';
import 'package:teknofest_todo_app_demo/widgets/tiles/to_do_tile.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<ToDoModel> _toDoList = <ToDoModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _onPressFloatingActionButton,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _toDoList.isNotEmpty
            ? ListView.builder(
                itemCount: _toDoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ToDoTile(
                    toDoModel: _toDoList[index],
                    onPressAddNewTitle: _onPressAddNewTitle,
                    onPressTile: _onPressTile,
                    onSwipe: _onSwipe,
                  );
                },
              )
            : Center(
                child: Image.asset(
                  'assets/noData.jpg',
                  width: 300,
                  height: 300,
                ),
              ),
      ),
    );
  }

  void _onPressFloatingActionButton() {
    setState(() {
      _toDoList.insert(
        0,
        ToDoModel(key: UniqueKey()),
      );
    });
  }

  void _onPressAddNewTitle(ToDoModel model, String newTitle) {
    model.newTitle = newTitle;
    model.newMode = ToDoMode.normal;

    _updateList(model);
  }

  void _onPressTile(ToDoModel model) {
    model.newChecked = !model.checked;

    _updateList(
      model,
      sendItemToStart: !model.checked,
      sendItemToEnd: model.checked,
    );
  }

  void _updateList(
    ToDoModel model, {
    bool sendItemToStart = false,
    bool sendItemToEnd = false,
    bool remove = false,
  }) {
    List<ToDoModel> _list = [..._toDoList];
    int itemIndex = _list.indexWhere((element) => element.key == model.key);

    if (itemIndex != -1) {
      _list.removeAt(itemIndex);
    }

    if (sendItemToEnd) {
      _list.add(model);
    } else if (sendItemToStart) {
      _list.insert(0, model);
    } else if (!remove) {
      _list.insert(itemIndex, model);
    }

    setState(() {
      _toDoList.clear();
      _toDoList.addAll(_list);
    });
  }

  void _onSwipe(ToDoModel model) {
    _updateList(model, remove: true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${model.title} removed')),
    );
  }
}
