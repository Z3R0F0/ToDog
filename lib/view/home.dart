import 'package:flutter/material.dart';
import 'package:untitled7/Instuments/data_.dart';
import 'package:untitled7/view/tasks.dart';
import 'package:untitled7/Instuments/widgets.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  DatabaseUsage _dbHelper = DatabaseUsage();
  AnimationController _animationController;
  Animation _animation;
  String timeString = '';
  int checkHome = 0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 1.0, end: 10.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
          color: Color(0xFFFFFFFF),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(1),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'), // ядро приложения
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(21.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFFFF7EB),
                      ),
                      child: FutureBuilder(
                        initialData: [],
                        future: _dbHelper.getTasks(),
                        builder: (context, snapshot) {
                          return ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                top: 7,
                                right: 7,
                                left: 7,
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TaskView(
                                          task: snapshot.data[index],
                                        ),
                                      ),
                                    ).then(
                                      (value) {
                                        setState(() {});
                                      },
                                    );
                                  },
                                  child: TaskCardWidget(
                                    title: snapshot.data[index].title,
                                    desc: snapshot.data[index].description,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskView(
                                task: null,
                              )),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      child: Center (
                        child:Container(
                          width: MediaQuery.of(context).size.width / 1.058,
                          height: 64.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xFFECBA7B), Color(0xFFFFFFFF)],
                                  begin: Alignment(0.0, -1.0),
                                  end: Alignment(0.0, 20.0)),
                              borderRadius: BorderRadius.circular(90.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(67, 203, 163, 85),
                                    /*blurRadius: _animation.value,*/
                                    spreadRadius: _animation.value)
                              ]),
                          child: Center(
                            child: Text(
                              "Добавить задачу",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ),
                        ),
                      )
                    ),


                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
