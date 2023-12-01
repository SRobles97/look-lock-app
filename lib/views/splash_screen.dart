import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:look_lock_app/services/storage_services.dart';
import 'package:look_lock_app/views/logged/home_screen.dart';
import 'package:look_lock_app/views/welcome_screen.dart';
import 'package:look_lock_app/widgets/look_lock_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool _showShadow = false;
  String? token;

  @override
  void initState() {
    super.initState();
    _initializeSplashScreen();
    _initializeToken();
  }

  void _initializeToken() async {
    token = await StorageServices.getToken();
  }

  Future<void> _initializeSplashScreen() async {
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _controller!.forward().whenComplete(() {
      setState(() {
        _showShadow = true;
      });
      _controller!.reverse().whenComplete(() {
        _performPostAnimationActions();
      });
    });
  }

  void _performPostAnimationActions() {
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AnimatedBuilder(
          animation: _animation!,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: _animation!.value *
                        MediaQuery.of(context).size.height *
                        0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: _animation!.value *
                        MediaQuery.of(context).size.height *
                        0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Center(
                  child: _showShadow
                      ? Animate(
                          effects: const [
                              ShakeEffect(
                                  duration: Duration(milliseconds: 500)),
                            ],
                          child: LookLockLogo(
                            name: 'Logo',
                            width: 250,
                            shadow: _showShadow,
                          ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const LookLockLogo(
                              name: 'Logo2',
                              width: 200,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            );
          }),
    );
  }
}
