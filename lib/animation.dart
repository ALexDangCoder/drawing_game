import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({super.key});

  @override
  AnimationTestState createState() => AnimationTestState();
}

class AnimationTestState extends State<AnimationTest>
    with TickerProviderStateMixin {
  double _opacity1 = 0.0;
  double _opacity2 = 0.0;
  double _opacity3 = 0.0;
  double _opacity4 = 0.0;

  final Offset _offset1 = const Offset(0, 1);
  final Offset _offset2 = const Offset(0, 1);
  final Offset _offset3 = const Offset(0, 1);

  bool _isMovingStar = false;

  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late AnimationController _floatingController;

  late Animation<double> _floatingAnimation;

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  final GlobalKey startKey = GlobalKey();
  var _cartQuantityItems = 0;

  @override
  void initState() {
    super.initState();

    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationController3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _startAnimation();
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _opacity1 = 1.0;
      _animationController1.forward();
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _opacity2 = 1.0;
      _animationController2.forward();
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _opacity3 = 1.0;
      _animationController3.forward();
    });

    await Future.delayed(const Duration(seconds: 1));

    await _startStarAnimation(startKey);

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isMovingStar = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _opacity4 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass through the the global key of the image as parameter
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.network(
                'https://picsum.photos/800/1200',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.8),
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: _opacity1,
                      duration: const Duration(seconds: 1),
                      child: SlideTransition(
                        position: _animationController1.drive(
                          Tween<Offset>(begin: _offset1, end: Offset.zero)
                              .chain(
                            CurveTween(curve: Curves.easeInOut),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Intro page"),
                            Text("Design 4"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: _opacity4,
                      duration: const Duration(seconds: 1),
                      child: const Text(
                        "Fantastic progress",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: _opacity2,
                      duration: const Duration(seconds: 1),
                      child: SlideTransition(
                        position: _animationController2.drive(
                          Tween<Offset>(begin: _offset2, end: Offset.zero)
                              .chain(
                            CurveTween(curve: Curves.easeInOut),
                          ),
                        ),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: const Duration(seconds: 1),
                          builder: (BuildContext context, double value,
                              Widget? child) {
                            return Transform.translate(
                              offset: Offset(0.0, -100.0 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            decoration: _boxDecorationContainer,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  key: startKey,
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 50,
                                  ),
                                ),
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 50),
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 50),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: _opacity3,
                      duration: const Duration(seconds: 1),
                      child: SlideTransition(
                        position: _animationController3.drive(
                          Tween<Offset>(begin: _offset3, end: Offset.zero)
                              .chain(
                            CurveTween(curve: Curves.easeInOut),
                          ),
                        ),
                        child: Container(
                          decoration: _boxDecorationContainer,
                          height: 100,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 5,
                                  color: Colors.red,
                                ),
                              ),
                              AddToCartIcon(
                                key: cartKey,
                                icon: const Icon(Icons.star,
                                    color: Colors.yellow, size: 50),
                                badgeOptions: const BadgeOptions(
                                  active: true,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 350,
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            width: _isMovingStar ? 200.0 : 0,
                            height: _isMovingStar ? 50.0 : 0,
                            top: _isMovingStar ? 50.0 : 0,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (_isMovingStar)
                                  AnimatedBuilder(
                                    animation: _floatingAnimation,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset:
                                            Offset(0, _floatingAnimation.value),
                                        child: const Tooltip(
                                          message: "Hovering Tooltip",
                                          child: ColoredBox(
                                            color: Colors.blue,
                                            child:
                                                Center(child: Text('Redesign')),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                if (_isMovingStar)
                                  const ColoredBox(
                                    color: Colors.red,
                                    child: Center(child: Text('Continue')),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final BoxDecoration _boxDecorationContainer = BoxDecoration(
    borderRadius: const BorderRadius.all(
      Radius.circular(8),
    ),
    color: Colors.grey.withOpacity(0.7),
  );

  Future<void> _startStarAnimation(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }
}
