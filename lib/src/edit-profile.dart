import 'dart:convert';
import 'package:flutter_app/src/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:flutter_app/services/serializer.dart';
import 'package:flutter_app/src/FadeAnimation.dart';
import 'package:flutter_app/src/edit-profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatefulWidget {
  var id, token;
  EditProfile({this.id, this.token});
  @override
  _EditProfileState createState() => _EditProfileState(id, token);
}

class _EditProfileState extends State<EditProfile> {
  var age, domicility, name, id, ageUpdate, domicilityUpdate, token, lastname;
  _EditProfileState(this.id, this.token);

  Map data;
  List userData;

  getUserData() async {
    String url = "http://34.239.109.204/api/v1/profile/profile_detail/$id/";
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    data = json.decode(response.body)[0];

    setState(() {
      name = data['name'] == null ? 'name' : data['name'];
      age = data['email'] == null ? 'email' : data['email'];
      domicility = data['address'] == null ? 'address' : data['address'];
      lastname = data['address'] == null ? 'address' : data['address'];
    });
  }

  Future<http.Response> updateUserData(String domiciality, String age) {
    return http.put(
      'https://api-flutter-mdb.herokuapp.com/updateinfo/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'domiciality': domicilityUpdate,
        'age': ageUpdate
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 450,
                backgroundColor: Color.fromRGBO(49, 39, 79, 1),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/profile.jpg'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Colors.black,
                            Colors.black.withOpacity(.3)
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(
                                1,
                                Text(
                                  "Hola, $name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            1.6,
                            Text(
                              "Estudiante de Ingeniería en desarrollo de software, en la universidad politécnica de chiapas. Amante del diseño y de las producciones cinematográficas de alto nivel.",
                              style: TextStyle(color: Colors.grey, height: 1.4),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            Text(
                              "Dirección:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.6,
                            TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        "Ingresa tu dirección (Actual: $domicility)",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (val) {
                                  domicilityUpdate = val;
                                })),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            Text(
                              "Edad",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.6,
                            TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Ingresa tu email (Actual $age)",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (val) {
                                  ageUpdate = val;
                                })),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
          Positioned.fill(
            bottom: 50,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FadeAnimation(
                  2,
                  Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: RaisedButton(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        child: Center(
                          child: Text(
                            "Editar perfil",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          updateUserData(domicilityUpdate, ageUpdate);
                          AuthService().getInfoUser(id, token).then((val) {
                            Fluttertoast.showToast(
                                msg: "Actualizando los datos de: " + "$name",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPage(
                                          id: id,
                                        )));
                          });
                        },
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
