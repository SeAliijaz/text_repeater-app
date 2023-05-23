import 'package:flutter/material.dart';
import 'package:text_repeater_app/MediaQuery/mediaquery.dart';
import '../Constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  int? repeatCount;
  String repeatedText = "";
  bool _isVertical = false;
  bool isLoading = false;

  void _generateRepeatedText() {
    repeatedText = '';
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_isVertical) {
        setState(() {
          for (int i = 1; i <= repeatCount!; i++) {
            repeatedText += "${title!}\n";
          }
        });
      } else {
        setState(() {
          for (int i = 1; i <= repeatCount!; i++) {
            repeatedText += " ${title!.trim()}";
          }
        });
      }
    }
  }

  void _clearAll() {
    setState(() {
      repeatedText = '';
      title = '';
      repeatCount = null;
      _formKey.currentState!.reset();
      _isVertical = false;
    });
    showToast("Data Removed!");
  }

  _toggleDirection(bool value) {
    setState(() {
      _isVertical = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Repeater"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
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
                            Padding(
                              padding: EdgeInsets.all(5.5),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.title_outlined),
                                  labelText: 'Enter Text',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a title';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  title = value;
                                },
                              ),
                            ),
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
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
                                  padding: EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon:
                                          const Icon(Icons.repeat_outlined),
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
                                      if (int.parse(value) < 1 ||
                                          int.parse(value) > 5000) {
                                        return "Number should be between (1 To 5,000)";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      repeatCount = int.parse(value!);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CheckboxListTile(
                                      title: Text(
                                        _isVertical == true
                                            ? "Vertical"
                                            : "Horizontal",
                                      ),
                                      value: _isVertical,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          _toggleDirection(value);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _actionButtons(context),
                            _repeatedTextDiv(context, constraints),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _repeatedTextDiv(BuildContext context, BoxConstraints constraints) {
    return Expanded(
      child: SizedBox(
        height: constraints.maxHeight,
        width: double.infinity,
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  if (repeatedText.isEmpty)
                    SizedBox(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(5.5),
                          child: Center(
                            child: Text(
                              "Your Text Will Show Here",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
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
                                      showToast("Text Copied Successfully!");
                                    },
                                    icon: const Icon(Icons.copy_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      send(repeatedText);
                                      showToast("Sharing Your Text");
                                    },
                                    icon: const Icon(Icons.share_outlined),
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
                              style: const TextStyle(fontSize: 20),
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
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Padding(
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
                onPressed: _clearAll,
                child: const Text("Clear All"),
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
                child: const Text("Generate"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
