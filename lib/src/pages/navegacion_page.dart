import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class NavegacionPage extends StatelessWidget {
 const NavegacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notificaciones'),
          backgroundColor: Colors.pink,
        ),
        // body: ,
        floatingActionButton: const BottonFlotante(),
        bottomNavigationBar: const BottomNavigation(),
       ),
    );
  }
}

class BottonFlotante extends StatelessWidget {
  const BottonFlotante({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final notiModel = Provider.of<_NotificationModel>(context, listen: false);
        int numero = notiModel.numero;
        numero++;
        notiModel.numero = numero;

        if(numero >= 2){
          final controller = Provider.of<_NotificationModel>(context, listen: false).bounceController;
          controller.forward(from: 0.0);
        }
      },
      backgroundColor: Colors.pink,
      child: const FaIcon(FontAwesomeIcons.play),
    );
  }
}


class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final numero = Provider.of<_NotificationModel>(context).numero;
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [

        const BottomNavigationBarItem(
          label: 'Bones',
          icon: FaIcon(FontAwesomeIcons.bone)
        ),

        BottomNavigationBarItem(
          label: 'Notificaciones',
          icon: Stack(
            children: [
              const FaIcon(FontAwesomeIcons.bell),
              Positioned(
                top: 0,
                right: 0,
                // child: Icon(Icons.brightness_1, size: 10, color: Colors.redAccent,)
                child: BounceInDown(
                  from: 10,
                  animate: (numero > 0) ? true : false,
                  child: Bounce(
                    from: 10,
                    controller: (controller) => Provider.of<_NotificationModel>(context, listen: false).bounceController = controller,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle
                      ),
                      alignment: Alignment.center,
                      child: Text('$numero', style: const TextStyle(color: Colors.white, fontSize: 7),),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),

        const BottomNavigationBarItem(
          label: 'Mi Perro',
          icon: FaIcon(FontAwesomeIcons.dog)
        ),


      ],
    );
  }
}

class _NotificationModel extends ChangeNotifier {
  int _numero = 0;
  late AnimationController bounceController;
  int get numero => _numero;
  set numero(int value){
    _numero = value;
    notifyListeners();
  }
}