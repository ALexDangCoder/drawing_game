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
  double _buttonOpacity = 0.0;
  final Duration _durationTime = Duration(milliseconds: 500);

  final Offset _offset1 = const Offset(0, 1);
  final Offset _offset2 = const Offset(0, 1);
  final Offset _offset3 = const Offset(0, 1);

  bool _isMoingButtonStar = false;

  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late AnimationController _floatingController;
  late AnimationController _buttonAnimationController;

  late Animation<double> _floatingAnimation;

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  final GlobalKey startKey = GlobalKey();
  var _cartQuantityItems = 0;

  double get widthOfStatusBar => MediaQuery.of(context).size.width * 0.6;

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

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

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
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    await Future.delayed(_durationTime);
    setState(() {
      _opacity1 = 1.0;
      _animationController1.forward();
    });

    await Future.delayed(_durationTime);
    setState(() {
      _opacity2 = 1.0;
      _animationController2.forward();
    });

    await Future.delayed(_durationTime);
    setState(() {
      _opacity3 = 1.0;
      _animationController3.forward();
    });

    await Future.delayed(_durationTime);

    await _startStarAnimation(startKey);

    await Future.delayed(_durationTime);
    setState(() {
      _isMoingButtonStar = true;
    });

    await Future.delayed(_durationTime);
    setState(() {
      _opacity4 = 1.0;
    });

    await Future.delayed(_durationTime);
    setState(() {
      _buttonOpacity = 1.0;
      _buttonAnimationController.forward();
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
      jumpAnimation: const JumpAnimationOptions(active: false),
      createAddToCartAnimation: (runAddToCartAnimation) {
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
                    const Spacer(),
                    AnimatedOpacity(
                      opacity: _opacity1,
                      duration: _durationTime,
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
                      duration: _durationTime,
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
                      duration: _durationTime,
                      child: SlideTransition(
                        position: _animationController2.drive(
                          Tween<Offset>(begin: _offset2, end: Offset.zero)
                              .chain(
                            CurveTween(curve: Curves.easeInOut),
                          ),
                        ),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: _durationTime,
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
                                    color: Colors.grey, size: 50),
                                const Icon(Icons.star,
                                    color: Colors.grey, size: 50),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: _opacity3,
                      duration: _durationTime,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: widthOfStatusBar,
                                    height: 5,
                                    color: Colors.grey,
                                  ),
                                  AnimatedContainer(
                                    width: (widthOfStatusBar / 3) *
                                        _cartQuantityItems,
                                    height: 5,
                                    color: Colors.blue,
                                    duration: _durationTime,
                                    curve: Curves.easeInOut,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              AddToCartIcon(
                                key: cartKey,
                                icon: const Icon(Icons.star,
                                    color: Colors.yellow, size: 40),
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
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      width: 40,
                      height: 40,
                      child: const Center(child: Icon(Icons.share)),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 250,
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            width: _isMoingButtonStar
                                ? MediaQuery.of(context).size.width - 47
                                : 0,
                            height: _isMoingButtonStar ? 85 : 0,
                            top: _isMoingButtonStar ? 50.0 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            child: AnimatedOpacity(
                              opacity: _buttonOpacity,
                              duration: _durationTime,
                              child: Column(
                                children: [
                                  AnimatedBuilder(
                                    animation: _floatingAnimation,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset:
                                            Offset(0, _floatingAnimation.value),
                                        child: const Align(
                                          alignment: Alignment.topLeft,
                                          child: SpeechBubbleWidget(),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: ColoredBox(
                                            color: Colors.blue,
                                            child:
                                                Center(child: Text('Redesign')),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const ColoredBox(
                                          color: Colors.red,
                                          child:
                                              Center(child: Text('Continue')),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
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

class SpeechBubbleWidget extends StatelessWidget {
  const SpeechBubbleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Can you perfect\nyour design?",
                style: TextStyle(
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15,
          height: 7,
          child: CustomPaint(
            painter: TrianglePainter(),
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill; // Changed style to fill for solid triangle

    final path = Path();
    path.moveTo(0, 0); // Move to the top left
    path.lineTo(size.width, 0); // Draw line to top right
    path.lineTo(size.width / 2, size.height); // Draw line to bottom center
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
