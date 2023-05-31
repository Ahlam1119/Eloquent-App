import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  const DropDownList(
      {super.key,
      required this.title,
      required this.data,
      required this.name,
      required this.id});
  final String title;
  final List<SelectedListItem> data;
  final TextEditingController name;
  final TextEditingController id;

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        data: widget.data,
        selectedItems: (List<dynamic> selectedList) {
          SelectedListItem selectedListItem = selectedList[0];
          widget.name.text = selectedListItem.name;
          widget.id.text = selectedListItem.value!;
        },
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.name,
      cursorColor: Colors.black,
      onTap: () {
        FocusScope.of(context).unfocus();
        onTextFieldTap();
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(right: 10),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 254, 254),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff385a4a),
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff385a4a),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: widget.name.text == "" ? widget.title : widget.name.text,
      ),
    );
  }
}
