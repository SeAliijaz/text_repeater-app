import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:text_repeater_app/MediaQuery/mediaquery.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  ///Vars
  final _formKey = GlobalKey<FormState>();
  String? title;
  int? repeatCount;
  String repeatedText = "";

  ///function to generateRepeated Text
  void _generateRepeatedText() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        repeatedText = '';
        for (int i = 1; i <= repeatCount!; i++) {
          repeatedText += "${title!}\n";
        }
      });
    }
  }

  ///This will clear everyhting on screen
  void _clearAll() {
    setState(() {
      repeatedText = '';
      title = '';
      repeatCount = null;
      _formKey.currentState!.reset();
    });
    Fluttertoast.showToast(msg: "Data is Removed!");
  }

  ///function to copy text
  _copy(String text) {
    FlutterClipboard.copy(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Repeater"),
      ),
      body: SizedBox(
        height: Sizer(context).height,
        width: Sizer(context).width,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ///1st TextField
              Padding(
                padding: const EdgeInsets.all(5.5),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.title),
                    labelText: 'Enter Text',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) => title = value,
                ),
              ),

              ///2nd TextField
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        "How Much Time you want to repeat?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.repeat),
                        labelText: 'Repeat Count',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter repeat count';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) => repeatCount = int.parse(value!),
                    ),
                  ),
                ],
              ),

              ///Divider
              Divider(),

              ///Action Buttons
              Padding(
                padding: const EdgeInsets.all(5.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _clearAll();
                      },
                      child: Text("Clear All"),
                    ),
                    ElevatedButton(
                      onPressed: _generateRepeatedText,
                      child: Text("Generate"),
                    ),
                  ],
                ),
              ),

              ///Divider
              Divider(),

              ///Repeated Text
              Expanded(
                child: SizedBox(
                  height: Sizer(context).height,
                  width: Sizer(context).width,
                  child: Card(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          repeatedText.isEmpty
                              ? SizedBox(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.5),
                                      child: Text(
                                        repeatedText.isEmpty ? "No Data!" : "",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Repeated text",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              _copy(repeatedText);
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Text Copied Successfully!",
                                              );
                                            },
                                            icon: Icon(Icons.copy),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.5),
                                        child: Text(
                                          repeatedText,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
