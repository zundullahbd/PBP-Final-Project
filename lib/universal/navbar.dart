// Code adapted from : https://amiworthy.in/html/Bootstrap_NavBar.html
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_akhir_f03/covid_data.dart';

void main() {
  runApp(MaterialApp(
    home: NavApp(),
    debugShowCheckedModeBanner: false,
  ));
}

double collapsableHeight = 0.0;
Color selected = const Color(0xffffffff);
Color notSelected = const Color(0xafffffff);

class NavApp extends StatefulWidget {
  NavApp({Key? key}) : super(key: key);
  @override
  _MyNavState createState() => _MyNavState();
}

class _MyNavState extends State<NavApp> {
  int totalNavItems = 0;
  double countHeight() {
    double h = 0;
    for (int i = 0; i < totalNavItems; i++) {
      h += 60;
    }
    return h;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double navMaxHeight = countHeight();
    List<Widget> navBarItems = [
      NavBarItem(
        text: 'SusunJadwal',
        isLogin: false,
        onTap: () {},
      ),
      NavBarItem(
        text: 'Search',
        isLogin: false,
        onTap: () {},
      ),
      NavBarItem(
        text: 'To-Do List',
        isLogin: false,
        onTap: () {},
      ),
      NavBarItem(
        text: 'Covid-19 Data',
        isLogin: false,
        onTap: () {
          Widget next = const CovidData();
          setState(() {
            collapsableHeight = 0.0;
          });
          if (context != next) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => next),
            );
          }
        },
      ),
      NavBarItem(
        text: 'Scheduler',
        isLogin: false,
        onTap: () {},
      ),
      NavBarItem(
        text: 'Login',
        isLogin: true,
        onTap: () {},
      ),
    ];
    totalNavItems = navBarItems.length;
    return Column(
      children: [
        Container(
          color: const Color(0xFF5F9EA0),
          height: 80.0,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'P . B . P',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.9),
              ),
              LayoutBuilder(builder: (context, constraints) {
                return NavBarButton(
                  onPressed: () {
                    if (collapsableHeight == 0.0) {
                      setState(() {
                        collapsableHeight = navMaxHeight;
                      });
                    } else if (collapsableHeight == navMaxHeight) {
                      setState(() {
                        collapsableHeight = 0.0;
                      });
                    }
                  },
                );
              })
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 375),
          curve: Curves.ease,
          height: (width < 800.0) ? collapsableHeight : 0.0,
          //width: double.infinity,
          color: const Color(0xFF5F9EA0),
          child: SingleChildScrollView(
            child: Column(
              children: navBarItems,
            ),
          ),
        ),
      ],
    );
  }
}

class NavBarItem extends StatefulWidget {
  final String text;
  bool isLogin;
  final Function onTap;

  NavBarItem({required this.text, required this.onTap, required this.isLogin});

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  Color color = notSelected;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          color = selected;
        });
      },
      onExit: (value) {
        setState(() {
          color = notSelected;
        });
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            setState(() {
              widget.onTap();
            });
          },
          child: Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: widget.isLogin == false
                ? Text(
                    widget.text,
                    style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 16,
                        letterSpacing: 0.9),
                  )
                : Text(
                    widget.text,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class NavBarButton extends StatefulWidget {
  final Function onPressed;

  NavBarButton({
    required this.onPressed,
  });

  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: 60.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xcfffffff),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            setState(() {
              widget.onPressed();
            });
          },
          child: const Icon(
            Icons.menu,
            size: 30.0,
            color: Color(0xcfffffff),
          ),
        ),
      ),
    );
  }
}