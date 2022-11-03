import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _obsecure = false;

  late Animation animation;
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.pink[200],
      body: Container(
        //padding: EdgeInsets.all(20),
        child: Stack(children: [
          CachedNetworkImage(
            alignment: FractionalOffset(animation.value, 0),
            imageUrl:
                "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171__480.jpg",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  /*colorFilter:
                        ColorFilter.mode(Colors.red, BlendMode.colorBurn)*/
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Your Mail",
                    labelText: "Mail please",
                    suffixIcon: Icon(Icons.mail),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    }
                    if (value.length > 8) {
                      return "too Long Pass";
                    }
                    if (value.length < 3) {
                      return "Small Pass";
                    }
                  },
                  controller: _passcontroller,
                  obscureText: _obsecure,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Your Pass",
                    labelText: "Password please",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obsecure = !_obsecure;
                          });
                        },
                        icon: Icon(_obsecure
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print("Ok");
                    } else {
                      print("object");
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    color: Colors.black,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
