import 'package:flutter/material.dart';
import 'package:teknofest_todo_app_demo/models/to_do.dart';

class ToDoTile extends StatefulWidget {
  final ToDoModel toDoModel;
  final Function(ToDoModel, String) onPressAddNewTitle;
  final Function(ToDoModel) onPressTile;
  final Function(ToDoModel) onSwipe;

  const ToDoTile({
    Key? key,
    required this.toDoModel,
    required this.onPressAddNewTitle,
    required this.onPressTile,
    required this.onSwipe,
  }) : super(key: key);

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  final TextEditingController _controller = TextEditingController(text: '');
  String _title = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      _title = widget.toDoModel.title;
      _controller.text = widget.toDoModel.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.remove_circle, color: Colors.white),
      ),
      onDismissed: (direction) {
        widget.onSwipe(widget.toDoModel);
      },
      child: GestureDetector(
        onTap: () {
          if (widget.toDoModel.mode == ToDoMode.normal) {
            widget.onPressTile(widget.toDoModel);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                widget.toDoModel.checked
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
                color: widget.toDoModel.checked ? Colors.green : Colors.grey,
              ),
              const SizedBox(width: 8),
              widget.toDoModel.mode == ToDoMode.edit
                  ? Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              autocorrect: false,
                              onChanged: (value) {
                                setState(() {
                                  _title = value;
                                  _controller.text = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Add Title...',
                                fillColor: Colors.green,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    widget.onPressAddNewTitle(
                                      widget.toDoModel,
                                      _title,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      widget.toDoModel.title,
                      style: TextStyle(
                        decoration: widget.toDoModel.checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
