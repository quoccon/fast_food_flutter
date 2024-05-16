import 'package:flutter/material.dart';
import 'package:food_client/blocs/auth/auth_cubit.dart';
import 'package:food_client/page/auth/register_page.dart';
import 'package:food_client/page/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AuthCubit authCubit;
  bool isLogin = false;
  bool showError = false;
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    authCubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Auththenticated) {
          setState(() {
            isLogin = true;
          });
        }else if(state is AuthError){
          setState(() {
            isLogin = false;
            showError = true;
            errorMessage = state.error;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: const Color(0xffFFC529),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    "assets/images/background_fastfood.png",
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Login to FastFood",
                              style: GoogleFonts.abhayaLibre(fontSize: 30),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.email),
                              prefixIconConstraints: const BoxConstraints(
                                  minHeight: 40, minWidth: 40),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Visibility(visible: state is AuthError,child: Text((state as AuthError).error,style: TextStyle(color: Colors.red),)),
                          const SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.lock),
                              prefixIconConstraints: const BoxConstraints(
                                  minHeight: 40, minWidth: 40),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          Visibility(
                            visible: showError,
                            child: Text(errorMessage,style: const TextStyle(color: Colors.red),),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text("Forgot password?",
                                style: TextStyle(fontSize: 15)),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              authCubit.login(emailController.text,
                                  passwordController.text, (user) {
                                    Future.delayed(const Duration(seconds: 2), () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => HomePage(user:user)));
                                    });
                                  });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Color(0xffFFC529),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              child: Center(
                                  child: isLogin
                                      ? _buildLoadingAnimation()
                                      : Text(
                                          "Login",
                                          style: GoogleFonts.abhayaLibre(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Don't have acount?",
                                style: TextStyle(fontSize: 15),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Color(0xffFFC529)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingAnimation() {
    return Center(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.linear,
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
    );
  }
}
