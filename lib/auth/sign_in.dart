// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'sign_up.dart'; // ← for SignUpForm
import '../home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _loginObscure = true;
  final PageController _pageController = PageController(initialPage: 0);
  int _tab = 0; // 0 = Login, 1 = Register
  
  // put near top of your State
  static const double _loginFormHeight = 300;    // was 360
  static const double _registerFormHeight = 360; // was 420
  static const _anim = Duration(milliseconds: 250);
  static const Curve _curve = Curves.easeOutCubic;



  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topH = size.height * 0.36;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ----- hero -----
          Container(
            height: topH,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 9, 85, 74), Color(0xFF171B22)],
              ),
            ),
          ),

          // ----- title/subtitle -----
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/icon.png',
                      width: 60, height: 60, color: Colors.white, colorBlendMode: BlendMode.srcIn),
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'sans-serif',
                          color: Colors.white,
                          height: 1.2,
                          shadows: [Shadow(offset: Offset(0.5, 0.5), blurRadius: 6, color: Colors.black45)],
                        ),
                        children: [
                          TextSpan(text: 'C', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500)),
                          TextSpan(text: 'rag\n', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400)),
                          TextSpan(text: 'T', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500)),
                          TextSpan(text: 'ag', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Snap it, Tag it, Rate it... Conquer the Climb!',
                      style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'sans-serif'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ----- white sheet -----
          Positioned(
            top: topH - 75,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                border: const Border(top: BorderSide(color: Colors.white, width: 1)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 24, offset: const Offset(0, -6))],
              ),
              child: SafeArea(
                top: false,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  children: [
                    // segmented control
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                setState(() => _tab = 0);
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOutCubic,
                                );
                              },
                              child: _SegmentChip(label: 'Login', selected: _tab == 0),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                setState(() => _tab = 1);
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOutCubic,
                                );
                              },
                              child: _SegmentChip(label: 'Register', selected: _tab == 1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // sliding forms
                    AnimatedSize(
                      duration: _anim,
                      curve: _curve,
                      child: SizedBox(
                        height: _tab == 0 ? _loginFormHeight : _registerFormHeight,
                        child: PageView(
                          controller: _pageController,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (i) => setState(() => _tab = i),
                          children: [
                            _LoginForm(
                              obscure: _loginObscure,
                              onToggleObscure: () => setState(() => _loginObscure = !_loginObscure),
                            ),
                            const SignUpForm(),
                          ],
                        ),
                      ),
                    ),


                    const SizedBox(height: 0),

                    // divider
                    Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Or', style: TextStyle(color: Colors.black))),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 35),

                    // social
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.asset('assets/images/google.png', height: 24, width: 24, fit: BoxFit.contain),
                      label: const Text('Continue with Google',
                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                      style: _socialStyle(),
                    ),

                    const SizedBox(height: 28),

                    // footer switch
                    Builder(
                      builder: (context) {
                        final bool isLogin = _tab == 0; // 0 = Login, 1 = Register
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLogin ? "Don't have an account? " : "Already have an account? ",
                              style: const TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                final target = isLogin ? 1 : 0;       // go to the other tab
                                setState(() => _tab = target);
                                _pageController.animateToPage(
                                  target,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutCubic,
                                );
                              },
                              child: Text(
                                isLogin ? 'Sign up' : 'Sign in',       // CTA text switches too
                                style: const TextStyle(
                                  color: Color(0xFF178E79),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- subwidgets & helpers ----------
  static InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE8EDF2), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color.fromARGB(255, 62, 116, 108), width: 1.4),
      ),
    );
  }

  static ButtonStyle _socialStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(vertical: 14),
      side: BorderSide(color: Colors.grey.shade300),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _SegmentChip({required this.label, this.selected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: selected
            ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2))]
            : [],
      ),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: selected ? Colors.black : Colors.grey[600])),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final bool obscure;
  final VoidCallback onToggleObscure;
  const _LoginForm({required this.obscure, required this.onToggleObscure, super.key});

  @override
  Widget build(BuildContext context) {
    InputDecoration deco(String l, IconData i) => _SignInPageState._inputDecoration(l, i);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        TextField(keyboardType: TextInputType.emailAddress, style: const TextStyle(color: Colors.black, fontSize: 15), decoration: deco('Email', Icons.email_outlined)),
        const SizedBox(height: 16),
        TextField(
          obscureText: obscure,
          style: const TextStyle(color: Colors.black, fontSize: 15),
          decoration: deco('Password', Icons.lock_outline).copyWith(
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey[700]),
              onPressed: onToggleObscure,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [Checkbox(value: true, onChanged: (_) {}, activeColor: const Color(0xFF09554A)), const Text('Remember me', style: TextStyle(color: Colors.black, fontSize: 15))]),
            TextButton(onPressed: () {}, child: const Text('Forgot password?', style: TextStyle(color: Colors.black, fontSize: 15))),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF178E79),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: const Text('Sign in', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
