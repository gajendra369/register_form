import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<TextEditingController> controllers = List.generate(10, (i) => TextEditingController());//initialize the lists
  final List<FocusNode> _focusNodes = List.generate(10, (i) => FocusNode());
  final List<bool> _focusState = List.filled(10,false);

  final List<String> fieldNames = [
    "Name",
    "Email",
    "Phone Number",
    "DOB",
    "Address",
    "City",
    "State",
    "User Name",
    "Password",
    "Confirm Password"
  ];
  bool _isValidEmail = true, _issamepass = true;
  DateTime selectedDate = DateTime.now();
  late String d;
  bool _isPasswordVisible = false, _isPasswordVisible1 = false;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      _focusNodes[i].addListener(() {
        setState(() {
          _focusState[i] = _focusNodes[i].hasFocus;
        });
      });
    }
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("REGISTARTION"),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView( //allow scrolling of the window
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: _focusState[0] ? const EdgeInsets.all(18) : const EdgeInsets.all(10), //check for focus to change padding
                child: ListTile(
                  leading: !_focusState[0] ? const Icon(Icons.person) : null, //check focus for change icon
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[0] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: fieldNames[0],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controllers[0].clear();
                        },
                      ),
                    ),
                    maxLength: 20,
                    focusNode: _focusNodes[0],
                    controller: controllers[0],
                  ),
                ),
              ),
              Padding(
                padding: _focusState[1] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading:
                      !_focusState[1] ? const Icon(Icons.email_outlined) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[1] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: fieldNames[1],
                      errorText: _isValidEmail ? null : "Invalid email format",//validation of email
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controllers[1].clear();
                        },
                      ),
                    ),
                    focusNode: _focusNodes[1],
                    controller: controllers[1],
                    onEditingComplete: () {
                      setState(() {
                        _isValidEmail = isValidEmail(controllers[1].text);
                      });
                    },
                    onChanged: (text) {
                      setState(() {
                        _isValidEmail = true;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: _focusState[2] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading: !_focusState[2] ? const Icon(Icons.phone) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[2] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: fieldNames[2],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controllers[2].clear();
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    focusNode: _focusNodes[2],
                    controller: controllers[2],
                  ),
                ),
              ),
              Padding(
                padding: _focusState[3] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading: !_focusState[3]
                      ? const Icon(Icons.calendar_month_sharp)
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[3] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: DateTimePicker( //to pic the date of birth from calendar
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    dateLabelText: 'Date of Birth',
                    //controller: controllers[3],
                    focusNode: _focusNodes[3],
                    onChanged: (val) => d = val,
                    validator: (val) {
                      d = val!;
                      return null;
                    },
                    onSaved: (val) => d = val!,
                  ),
                ),
              ),
              Padding(
                padding: _focusState[4] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading: !_focusState[4] ? const Icon(Icons.home) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[4] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: fieldNames[4],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controllers[4].clear();
                        },
                      ),
                    ),
                    focusNode: _focusNodes[4],
                    controller: controllers[4],
                  ),
                ),
              ),
              Padding(
                padding: _focusState[5] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading:
                      !_focusState[5] ? const Icon(Icons.location_city) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[5] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: fieldNames[5],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controllers[5].clear();
                        },
                      ),
                    ),
                    focusNode: _focusNodes[5],
                    controller: controllers[5],
                  ),
                ),
              ),
              Padding(
                padding: _focusState[6] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading: !_focusState[6]
                      ? const Icon(Icons.holiday_village_rounded)
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[6] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: fieldNames[6],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controllers[6].clear();
                        },
                      ),
                    ),
                    focusNode: _focusNodes[6],
                    controller: controllers[6],
                  ),
                ),
              ),
              Padding(
                padding: _focusState[7] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading: !_focusState[7]
                      ? const Icon(Icons.verified_user_outlined)
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[7] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: fieldNames[7],
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controllers[7].clear();
                        },
                      ),
                    ),
                    focusNode: _focusNodes[7],
                    controller: controllers[7],
                  ),
                ),
              ),
              Padding(
                padding: _focusState[8] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading: !_focusState[8] ? const Icon(Icons.password) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[8] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    focusNode: _focusNodes[8],
                    controller: controllers[8],
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: fieldNames[8],
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: _focusState[9] ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
                child: ListTile(
                  leading: !_focusState[9] ? const Icon(Icons.password) : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: _focusState[9] ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  title: TextField(
                    focusNode: _focusNodes[9],
                    controller: controllers[9],
                    obscureText: !_isPasswordVisible1,
                    onEditingComplete: () {
                      setState(() {
                        _issamepass =
                            controllers[8].text == controllers[9].text;
                      });
                    },
                    onChanged: (text) {
                      setState(() {
                        _issamepass = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: fieldNames[9],
                      errorText: _issamepass ? null : "Password not matching",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible1 = !_isPasswordVisible1;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: saveData,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(80, 40)),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void saveData() {
    setState(() {
      _isValidEmail = isValidEmail(controllers[1].text);
      _issamepass = controllers[8].text == controllers[9].text;
    });
    if (_isValidEmail && _issamepass) {
      for (int i = 0; i < fieldNames.length; i++) {
        if (i == 3) {
          print("${fieldNames[i]} : $d");
          continue;
        }
        print("${fieldNames[i]}: ${controllers[i].text}");
      }
      Fluttertoast.showToast(
          msg: "Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      for (int i = 0; i < fieldNames.length; i++) {
        controllers[i].clear();
      }
    }
  }

  bool isValidEmail(String email) {
    // Use a regular expression to validate the email format
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}
