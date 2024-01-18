import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'item.dart';


/// tax and tip
class ExtraExpenses {
  /// Name of expense
  final String name;

  /// Amount of expense
  final double amount;

  /// List of people that are splitting this expense
  final List<String> payers;

  const ExtraExpenses(this.name, this.amount, this.payers);
}

class AddTaxTip extends StatefulWidget {
  const AddTaxTip({super.key, required this.peopleList, required this.itemList});

  final List<String> peopleList;
  final List<Item> itemList;

  @override
  State<AddTaxTip> createState() => _AddTaxTipState();
}

class _AddTaxTipState extends State<AddTaxTip> {
  /// Controller for tax TextField.
  final taxController = TextEditingController();

  /// Controller for tip TextField.
  final tipController = TextEditingController();

  /// List of expenses containing tax and tip.
  List<ExtraExpenses> extraExpenseList = [ExtraExpenses("Tax", 0, []), ExtraExpenses("Tip", 0, [])];

  /// Final split hidden until user clicks Billibuddy.
  bool showSplit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Column(
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
                        // TextSpan(
                        //   text: "Billibuddy ",
                        //   style: TextStyle(
                        //     fontStyle: FontStyle.italic,
                        //   ),
                        // ),
                        TextSpan(
                          text: "tax and tip on receipt?",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final numPaying = extraExpenseList[index].payers.length;
                        var addButtonText = "Add people";
                        if (numPaying == 1) {
                          addButtonText = "1 person";
                        } else if (numPaying > 1) {
                          addButtonText = "$numPaying people";
                        }
                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            child: Text(
                              "${extraExpenseList[index].name}:",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              //textAlign: TextAlign.right,
                            ),
                          ),
                          title: TextField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              //tax
                              hintText: "${extraExpenseList[index].name} amount",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            controller:
                            index == 0 ? taxController : tipController,
                            showCursor: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[.0-9]")),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Colors.blue,
                                title: const Text(
                                  "Add people",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 20,
                                  bottom: 20,
                                ),
                                content: Container(
                                  height: 220,
                                  width: 200,
                                  child: Scrollbar(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                        top: 0,
                                      ),
                                      itemCount: widget.peopleList.length,
                                      itemBuilder: (context, index2) {
                                        if (widget.peopleList.isEmpty) {
                                          return const ListTile();
                                        }
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                            StateSetter setState) {
                                          return CheckboxListTile(
                                            title: Text(
                                              widget.peopleList[index2],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            value: extraExpenseList[index]
                                                .payers
                                                .contains(
                                                widget.peopleList[index2]),
                                            onChanged: (bool? val) {
                                              setState(() {
                                                _addPersonChecked(
                                                    val, index, index2);
                                              });
                                            },
                                            selectedTileColor:
                                            const Color.fromRGBO(
                                                33, 128, 243, 1),
                                            side: const BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          );
                                        });
                                      },
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          const Color.fromRGBO(
                                              33, 128, 243, 1)),
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
                                  const Color.fromRGBO(33, 128, 243, 1)),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(1)),
                            ),
                            child:
                            Text(
                              addButtonText,
                              style: const TextStyle(
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
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ElevatedButton(
                    onPressed: () => _verifyTaxTip(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(33, 128, 243, 1)),
                      shadowColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(1)),
                    ),
                    child: const Text(
                      "Billibuddy!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      itemCount: showSplit ? widget.peopleList.length + 1: 0,
                      itemBuilder: (context, index) {
                        // Check if it's the last item
                        if (index == widget.peopleList.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                String textToCopy= "";
                                //list of string
                                for (int i = 0; i < widget.peopleList.length; i++) {

                                  textToCopy += widget.peopleList[i];

                                  textToCopy += " owes ";
                                  textToCopy += _calcPersonTotal(widget.peopleList[i]);
                                  textToCopy += "\n";
                                  // Accessing each element by index and printing it.
                                }
                                // copies bill split to plain text to copy
                                Clipboard.setData(ClipboardData(text: textToCopy));

                              },
                              child: Text('Copy Bill Splits'),
                            ),
                          );
                        }
                        //example to copy past
                        return ListTile(
                          title: Text(
                            widget.peopleList[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          trailing: Text(
                            _calcPersonTotal(widget.peopleList[index]),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        );
                      },

                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  /// Add a new person to an extra.
  void _addPersonChecked(bool? val, int index1, int index2) {
    // Check for null first.
    if (val == null) {
      return;
    }
    setState(() {
      if (val) {
        extraExpenseList[index1].payers.add(widget.peopleList[index2]);
      } else {
        extraExpenseList[index1].payers.remove(widget.peopleList[index2]);
      }
    });
  }

  void _verifyTaxTip() {
    var tax = double.tryParse(taxController.text);
    var tip = double.tryParse(tipController.text);
    if (tax == null || tip == null) {
      setState(() {
        tax = 0;
        tip = 0;
        showSplit = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a valid tax and tip!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 2500),
        ),
      );
    } else if ((tax != 0 && extraExpenseList[0].payers.isEmpty) ||
        (tip != 0 && extraExpenseList[1].payers.isEmpty)) {
      setState(() {
        tax = 0;
        tip = 0;
        showSplit = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "You must add at least 1 person to tax and tip!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 3000),
        ),
      );
    } else {
      setState(() {
        showSplit = true;
      });
    }
  }

// Function to calculate the total amount for a specific person.
  String _calcPersonTotal(String name) {
    // Parse tax and tip values from the text input fields.
    var tax = double.tryParse(taxController.text);
    var tip = double.tryParse(tipController.text);
    //if tax and tip not entered dont do split
    if (tax == null || tip == null) {
      setState(() {
        tax = 0;
        tip = 0;
        showSplit = false;
      });
      return "";
    }
    double total = 0;
    for (var item in widget.itemList) {
      for (var person in item.payers) {
        if (name == person) {
          total += (item.price / (item.payers.length));
          break;
        }
      }
    }
    for (var extra in extraExpenseList) {
      for (var person in extra.payers) {
        if (name == person && extra.name == "Tax") {
          total += (tax / (extra.payers.length));
          break;
        } else if (name == person && extra.name == "Tip") {
          total += (tip / (extra.payers.length));
          break;
        }
      }
    }
    //returns
    return "\$"+total.toStringAsFixed(2);
  }
}