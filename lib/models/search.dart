import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polls/event.dart';
import 'package:polls/variables.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({required this.onChanged, Key? key}) : super(key: key);

  final Function(String) onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width > 992 ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.8,
      child:         Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5, top: 6,bottom: 6 ),
        child: TextField(
          textAlign: TextAlign.left,
          minLines: 1,
          maxLines: 1,
          key: search,

          onChanged: widget.onChanged,
          controller: _textEditingController,
          autocorrect: false,
          cursorColor: Colors.red,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              constraints: const BoxConstraints(

              ),

              icon: const Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              onPressed: () {

                _textEditingController.clear();
                widget.onChanged(_textEditingController.text);
                FocusScope.of(context).unfocus();

              },
            ),
            hintText: 'Search Tasks . . . .',
            hintStyle: GoogleFonts.lato(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.normal),



            focusColor: Colors.grey,
            fillColor: Colors.white,
            hoverColor: Colors.grey,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),

            focusedBorder: OutlineInputBorder(


                borderRadius: BorderRadius.all(
                    Radius.circular(40.0)),

                borderSide:
                BorderSide.none
            ),
          ),
        ),
      ),


    );

  }
}
