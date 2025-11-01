import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Square extends StatefulWidget {
  const Square({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SquareState();
  }
}

class _SquareState extends State {
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _widthController.addListener(() => setState(() {}));
    _heightController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Square")),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              controller: _widthController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Width"),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Height"),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              width: double.tryParse(_widthController.text) ?? 100,
              height: double.tryParse(_heightController.text) ?? 100,
              color: Color(0xff12b7a9),
              // curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
            )
          ])),
    );
  }
}
