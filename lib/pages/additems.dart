import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'item.dart';
import 'addtaxtip.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key, required this.peopleList});

  final List<String> peopleList;

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  //item list
  List<Item> itemList = [];
  //item name input
  final itemNameController = TextEditingController();
  //item price input
  final itemPriceController = TextEditingController();

  //adding items
  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    //if keyboard si open
    //final double autoPadding = isKeyboardOpen ? (keyboardHeight - 160) : 510;
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
                        TextSpan(
                          text: "Billibuddy ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextSpan(
                          text: "for what?",
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
                        onPressed: () => addItemPressed(),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Item name",
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              onEditingComplete: () => addItemPressed(),
                              controller: itemNameController,
                              showCursor: false,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            TextField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Item Price",
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              onEditingComplete: () => addItemPressed(),
                              controller: itemPriceController,
                              showCursor: false,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[.0-9]")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 510,
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        final numPaying = itemList[index].payers.length;
                        var addButtonText = "Add people";
                        if (numPaying == 1) {
                          addButtonText = "1 person";
                        } else if (numPaying > 1) {
                          addButtonText = "$numPaying people";
                        }
                        if (itemList.isEmpty) {
                          return const ListTile();
                        }
                        return ListTile(
                          leading: IconButton(
                            onPressed: () => removePressed(index),
                            icon: const Icon(
                              Icons.remove_circle_outline_sharp,
                              color: Colors.white,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemList[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                itemList[index].price.toStringAsFixed(2),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
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
                                            value: itemList[index]
                                                .payers
                                                .contains(
                                                widget.peopleList[index2]),
                                            onChanged: (bool? val) {
                                              setState(() {
                                                newPersonAdded(
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
                            child: Text(
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () => nextPressed(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(33, 128, 243, 1)),
                        shadowColor: MaterialStateProperty.all(
                            Colors.white),
                      ),
                      child: Text('Tax and Tip'),
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

  /// Add a new item to the list.
  void addItemPressed() {
    final newItemPrice = double.tryParse(itemPriceController.text);

    // Check if newItemPrice is null, meaning price is in an invalid format.
    if (newItemPrice == null) {
      // Raise an error.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a valid price!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        final newItem = Item(itemNameController.text, newItemPrice, []);
        itemList.add(newItem);
        itemNameController.text = "";
        itemPriceController.text = "";
      });
    }
  }

  /// Add a new person to an item.
  void newPersonAdded(bool? val, int index1, int index2) {
    // Check for null first.
    if (val == null) {
      return;
    }
    setState(() {
      if (val) {
        itemList[index1].payers.add(widget.peopleList[index2]);
      } else {
        itemList[index1].payers.remove(widget.peopleList[index2]);
      }
    });
  }

  /// Remove an item from the list.
  void removePressed(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }

  /// Proceed to AddTax widget.
  void nextPressed() {
    // Check if there is at least 1 item added.
    if (itemList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "You must add at least 1 item!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else if (hasEmptyPayers(itemList)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "You must add at least 1 person to each item!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 2500),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTaxTip(
              peopleList: widget.peopleList,
              itemList: itemList,
            )),
      );
    }
  }

  /// Check if any items don't have payers assigned.
  bool hasEmptyPayers(List<Item> items) {
    for (var item in items) {
      if (item.payers.isEmpty) {
        return true;
      }
    }
    return false;
  }
}
