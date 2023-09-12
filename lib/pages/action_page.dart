import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:keep_notes_lite/main.dart';
import 'package:keep_notes_lite/model_class/user_model.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  // ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController titletext = TextEditingController();
    TextEditingController subtitletext = TextEditingController();
    var time = DateTime.now();
    var hour = time.hour.toString();
    var min = time.minute.toString();
    DateTime selectedDate = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff212126),
                  Color.fromRGBO(33, 33, 38, 0.4),
                  Color.fromRGBO(33, 33, 38, 0),
                  // const Color(0xff212126).withOpacity(1),
                  // const Color(0xff212126).withOpacity(0.4),
                  // const Color(0xff212126).withOpacity(0)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.push_pin_outlined,
              color: Colors.grey,
            ),
          ),
          _buildbox(20),
          const Icon(
            Icons.add_alert_outlined,
            color: Colors.grey,
          ),
          _buildbox(20),
          const Icon(
            Icons.archive_outlined,
            color: Colors.grey,
          ),
          _buildbox(20),
        ],
        leading: GestureDetector(
            onTap: () {
              var title = titletext.text;
              var subtitle = subtitletext.text;
              UserModel model = UserModel(content: subtitle, title: title);
              objectbox.insertUser(
                model,
              );
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          _buildtextformfield(titletext, 'Title', 24, 24),
          _buildtextformfield(subtitletext, 'Note', 20, 20),
          const SizedBox(height: 20),
          const Spacer(),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                _buildbox(10),
                const Icon(
                  Icons.add_box_outlined,
                  color: Colors.grey,
                ),
                _buildbox(20),
                const Icon(
                  Icons.color_lens_outlined,
                  color: Colors.grey,
                ),
                const Spacer(),
                Text(
                  'Edited $hour : $min',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                const Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildtextformfield(TextEditingController inputtext, String title,
      double fsize, double fsize1) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20),
      child: SizedBox(
        height: 30,
        child: TextFormField(
          controller: inputtext,
          style: TextStyle(color: Colors.white, fontSize: fsize1),
          decoration: InputDecoration(
              hintText: title,
              hintStyle: TextStyle(color: Colors.grey, fontSize: fsize),
              border: InputBorder.none),
        ),
      ),
    );
  }

  SizedBox _buildbox(double wid) {
    return SizedBox(
      width: wid,
    );
  }
}
