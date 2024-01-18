import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'addpeople.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  //home with create bill button
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Billibuddy",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 65,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.none,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPeople()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(33, 236, 243, 1.0)),
                  shadowColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(1)),
                ),
                 child: Text('Create a Bill'),
                // const Icon(Icons.keyboard_arrow_right_sharp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}