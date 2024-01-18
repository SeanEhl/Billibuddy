import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'additems.dart';

class AddPeople extends StatefulWidget {
  const AddPeople({Key? key}) : super(key: key);

  @override
  State<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  /// List of people's names.
  List<String> peopleList = [];

  /// peopleList with all names lowercase in case of repeats
  List<String> peopleListLower = [];

  /// Controller for name TextField.
  final addController = TextEditingController();

  /// Controller for name editing TextField.
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    //if keyboard si open
    final double buttonBottomPadding = isKeyboardOpen ? (keyboardHeight - 270) : 20;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.cyan,
        //DIRECTIONALITY
        child: Directionality(
          textDirection: TextDirection.ltr,
          //STACK AFTER CHILD
          child: Stack(
            children: [
              SingleChildScrollView(

            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                    bottom: 20,
                  ),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      children: [
                        TextSpan(
                          text: "Bill ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextSpan(
                          text: "with what buddies?",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: IconButton(
                        onPressed: () => _addPressed(),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter new name",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          onEditingComplete: () => _addPressed(),
                          controller: addController,
                          showCursor: false,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 319,
                  child: Scrollbar(

                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      itemCount: peopleList.length,
                      itemBuilder: (context, index) {
                        if (peopleList.isEmpty) {
                          return const ListTile();
                        }
                        return ListTile(
                          leading: IconButton(
                            onPressed: () => removeTapped(index),
                            icon: const Icon(
                              Icons.remove_circle_outline_sharp,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            peopleList[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Colors.blue,
                                title: const Text(
                                  "Edit name",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  top: 20,
                                  bottom: 10,
                                ),
                                content: Container(
                                  height: 50,
                                  width: 200,
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter new name",
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 20,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    controller: editController,
                                    showCursor: false,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      editController.text = "";
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          const Color.fromRGBO(
                                              33, 243, 187, 0.7137254901960784)),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.grey.withOpacity(1)),
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => editOkTapped(index),
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          const Color.fromRGBO(
                                              33, 243, 131, 1.0)),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.grey.withOpacity(1)),
                                    ),
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(33, 243, 117, 1.0)),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(1)),
                            ),
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    ),

                  ),
                ),

            ]),


              ),//AFTER HERE
              Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: buttonBottomPadding,
                ),
                child: ElevatedButton(
                  onPressed: () => nextTapped(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(33, 243, 92, 1.0)),
                    shadowColor: MaterialStateProperty.all(
                        Colors.grey.withOpacity(1)),
                  ),
                  child: Text('Tax and Tip Next'),
                  ),
                ),
              ),

        ]),
        ),
      ),
    );
  }

  /// Add a new person to the list.
  void _addPressed() {
    final name = addController.text.trim();
    setState(() {
      // Check if name is empty or all spaces.
      if (name.isEmpty) {
        // Raise an error.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Name cannot be empty!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1500),
          ),
        );
      } else if (peopleListLower.contains(name.toLowerCase())) {
        // Check if name already exists in the list.
        // Raise an error.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Person is already added!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1500),
          ),
        );
      } else {
        peopleList.add(name);
        peopleListLower.add(name.toLowerCase());
        addController.text = "";
      }
    });
  }

  /// Remove a person from the list.
  void removeTapped(int index) {
    setState(() {
      peopleList.removeAt(index);
      peopleListLower.removeAt(index);
    });
  }

  void editOkTapped(int index) {
    final name = editController.text.trim();
    setState(() {
      // Check if name is empty or all spaces.
      if (name.isEmpty) {
        // Raise an error.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "New name cannot be empty!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1500),
          ),
        );
      } else if (peopleListLower.contains(name.toLowerCase())) {
        // Check if name already exists in the list.
        // Raise an error.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Person is already added!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 1500),
          ),
        );
      } else {
        peopleList[index] = name;
        peopleListLower[index] = name.toLowerCase();
        Navigator.pop(context);
        editController.text = "";
      }
    });
  }

  /// Proceed to AddItems widget.
  void nextTapped() {
    /// Check if at least two people have been added.
    if (peopleList.length < 2) {
      // Raise an error.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "You must add at least 2 people!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddItems(peopleList: peopleList)),
      );
    }
  }
}