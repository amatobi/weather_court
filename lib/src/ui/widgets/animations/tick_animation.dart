import 'dart:async';
import 'package:flutter/material.dart';



class TicAnimation extends StatefulWidget {

  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallCheer;
  final Widget child;
  const TicAnimation(
      {Key? key,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 100),
      this.onEnd,
      this.smallCheer = false,
      required this.child,       
      })
      : super(key: key);

  @override
  TicAnimationState createState() => TicAnimationState();
}

class TicAnimationState extends State<TicAnimation>
    with SingleTickerProviderStateMixin {
   late AnimationController animationController;
   late Animation<double> scale;
   late Timer _timer;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds ~/ 2,
      ),
    );
    scale = Tween<double>(begin: 1, end: 1.1).animate(animationController);
    widget.isAnimating;
    if(widget.isAnimating){   
      restartAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant TicAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
 
    if(widget.isAnimating != oldWidget.isAnimating){     
       _timer.cancel();
    }
  }

  startAnimation() async {
    await animationController.forward();
   
    await animationController.reverse();

    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }
  

  void restartAnimation() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (timer) {
      startAnimation();
    });
  }

  void stpoAnimation(){
    _timer.cancel();
  }

  @override
  void dispose() {
    animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
   
    return ScaleTransition(
      scale: scale,
       child: widget.child,  
    );
  }
}
