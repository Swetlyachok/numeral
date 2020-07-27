import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Нумерологический портрет"))),
      body: Container(
        padding: const EdgeInsets.all(24.0), //отступ данных слева
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              //прокрутка списка
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [ListView()],
                ),
              ),
            ),
            //Минимальное расстрояние между последним полем и кнопкой
            SizedBox(height: 16),
            //кнопка
            RaisedButton(
              child: Text(
                'Новый портрет'.toUpperCase(),
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Нумерологический портрет"),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Новый портрет'.toUpperCase(),
//               style: TextStyle(color: Colors.blue, fontSize: 16)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }
