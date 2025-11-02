import 'package:flutter/material.dart';

class FormLogin extends StatefulWidget {
  final GlobalKey? formKey;
  final Function()? onSubmit;
  final TextEditingController? lognController;
  final TextEditingController? passwordController;
  const FormLogin(
      {super.key,
      this.onSubmit,
      this.lognController,
      this.passwordController,
      this.formKey});
  @override
  State<FormLogin> createState() => FormLoginState();
}

class FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            TextFormField(
              controller: widget.lognController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The username filed cannot be empty";
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text("username"), border: OutlineInputBorder()),
            ),
            TextFormField(
              controller: widget.passwordController,
              decoration: const InputDecoration(
                  label: Text("password"), border: OutlineInputBorder()),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The password filed cannot be empty";
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: widget.onSubmit,
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.blueAccent)),
                      child: const Text("Sign in",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(child: Divider(height: 1)),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  child: const Text("OR"),
                ),
                const Expanded(child: Divider(height: 1)),
              ],
            ),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                    textAlign: TextAlign.center,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
