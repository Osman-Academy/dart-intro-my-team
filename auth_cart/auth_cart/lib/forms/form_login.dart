import 'package:flutter/material.dart';

class FormLogin extends StatefulWidget {
  final GlobalKey? formKey;
  final Function()? onSubmit;
  final Function(String username, String email, String password)? onRegister;
  final TextEditingController? lognController;
  final TextEditingController? passwordController;

  const FormLogin({
    super.key,
    this.onSubmit,
    this.onRegister,
    this.lognController,
    this.passwordController,
    this.formKey,
  });

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
          children: [
            TextFormField(
              controller: widget.lognController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The username field cannot be empty";
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text("username"), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: widget.passwordController,
              decoration: const InputDecoration(
                  label: Text("password"), border: OutlineInputBorder()),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The password field cannot be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                  onPressed: () {
                    _showRegisterDialog(context);
                  },
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

  void _showRegisterDialog(BuildContext context) {
    final registerUsernameCtrl = TextEditingController();
    final registerEmailCtrl = TextEditingController();
    final registerPasswordCtrl = TextEditingController();
    final registerFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create Account"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: registerFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: registerUsernameCtrl,
                      decoration: const InputDecoration(
                        label: Text("Username"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: registerEmailCtrl,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!value.contains('@')) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: registerPasswordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (registerFormKey.currentState!.validate()) {
                if (widget.onRegister != null) {
                  widget.onRegister!(
                    registerUsernameCtrl.text,
                    registerEmailCtrl.text,
                    registerPasswordCtrl.text,
                  );
                }
                registerUsernameCtrl.clear();
                registerEmailCtrl.clear();
                registerPasswordCtrl.clear();
                Navigator.of(context).pop();
              }
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
