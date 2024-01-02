import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  Future<bool> signUpUser() async {
    String apiUrl = 'https://artistvibes.000webhostapp.com/signup.php';

    Map<String, String> data = {
      'Email': _controllerEmail.text,
      'Password': _controllerPassword.text,
      'ConfirmPassword': _controllerConfirmPassword.text,
    };

    try {
      final response = await http.post(Uri.parse(apiUrl), body: data);

      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.contains('success')) {
          // Signup successful
          return true;
        } else if (response.body
            .contains(' Email already exists.')) {
          _showErrorSnackBar(' Email already exists.');
        } else if (response.body.contains('Passwords do not match.')) {
          _showErrorSnackBar('Passwords do not match.');
        } else if (response.body.contains('Invalid email format.')) {
          _showErrorSnackBar('Invalid email format.');
        } else if (response.body.contains('Password must be strong')) {
          _showErrorSnackBar(
              'Password must be strong (minimum 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character).');
        } else {
          _showErrorSnackBar('Registration failed. Please try again.');
        }
      } else {
        print('Error: ${response.reasonPhrase}');
        _showErrorSnackBar('Network error: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Network error: $e');
      _showErrorSnackBar('Network error: $e');
      return false;
    }
    return false;
  }

  bool isObscure1 = true;
  bool isObscure2 = true;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  // Helper method to show a SnackBar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.black,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 0.3])),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            bottom: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius as needed
                            ),
                          ),
                          const Positioned(
                            bottom: -60,
                            child: Text(
                              "Register Account",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                            width: 300,
                            height: 60,
                            child: TextFormField(
                              controller: _controllerEmail,
                              validator: (value) =>
                              ((value == null || value.isEmpty)
                                  ? 'Please Enter Email'
                                  : null),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                hintText: 'Enter Email',
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide:
                                  const BorderSide(color: Colors.grey),
                                ),
                              ),
                            )),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 350,
                            height: 65,
                            child: TextFormField(
                              obscureText: isObscure1,
                              controller: _controllerPassword,
                              validator: (value) =>
                              ((value == null || value.isEmpty)
                                  ? 'Please Enter Password'
                                  : null),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure1 = !isObscure1;
                                      });
                                    },
                                    icon: isObscure1
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                filled: true,
                                fillColor: Colors.black,
                                hintText: 'Enter Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  const BorderSide(color: Colors.purple),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: 300,
                            height: 60,
                            child: TextFormField(
                              obscureText: isObscure2,
                              controller: _controllerConfirmPassword,
                              validator: (value) =>
                              ((value == null || value.isEmpty)
                                  ? 'Please Enter Password Confirmation'
                                  : null),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure2 = !isObscure2;
                                      });
                                    },
                                    icon: isObscure2
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                filled: true,
                                fillColor: Colors.black,
                                hintText: 'Enter Confirm Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  const BorderSide(color: Colors.purple),
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          if (await signUpUser()) {
                            Navigator.pushReplacementNamed(context, '/LoginScreen');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(350, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: const Text("Create Account",
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                      child: const Text(
                        "Already have an Account.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}