import 'package:flutter/material.dart';
import 'package:text_repeater_app/MediaQuery/mediaquery.dart';
import '../Constants/constants.dart';

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
/*
  * We Can do this using List.builder
  ListView.builder(
  itemCount: repeatCount,
  itemBuilder: (context, index) {
    return Text(title);
  },
);
  * We Can do this using List.generate
  List<String> repeatedTextList = List.generate(repeatCount, (index) => title);
  String repeatedText = repeatedTextList.join('\n');
*/
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
    showSnackBar(context, "Data Removed Successfully!");
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
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter Title you want to repeat?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              ///1st TextField
              Padding(
                padding: const EdgeInsets.all(5.5),
                child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.title_outlined),
                      labelText: 'Enter Text',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      } else if (value.length <= 3) {
                        return "title should be more than 3";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      title = value;
                    }),
              ),

              ///2nd text field
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "How Much Time you want to repeat?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.repeat_outlined),
                          labelText: 'Repeat Count',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter repeat count';
                          }
                          if (int.parse(value) == null ||
                              int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          if (int.parse(value) < 1 || int.parse(value) > 5000) {
                            return "Number should be between (1 To 5,000)";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          repeatCount = int.parse(value!);
                        }),
                  ),
                ],
              ),

              ///Action Buttons
              Padding(
                padding: const EdgeInsets.all(5.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: MaterialButton(
                          height: Sizer(context).height * 0.05,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            _clearAll();
                          },
                          child: Text("Clear All"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: MaterialButton(
                          height: Sizer(context).height * 0.05,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: _generateRepeatedText,
                          child: Text("Generate"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///Repeated Text
              Expanded(
                child: SizedBox(
                  height: Sizer(context).height,
                  width: Sizer(context).width,
                  child: Card(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            repeatedText.isEmpty
                                ? SizedBox(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.5),
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
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
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    copy(repeatedText);
                                                    showSnackBar(context,
                                                        "Text Copied Successfully!");
                                                  },
                                                  icon:
                                                      Icon(Icons.copy_outlined),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    send(repeatedText);
                                                    showSnackBar(
                                                        context, "Sharing");
                                                  },
                                                  icon: Icon(
                                                      Icons.share_outlined),
                                                ),
                                              ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
