import 'package:dev/Pages/Following.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dev/Provider/UserProvider.dart';

void main() => runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
          ],
          child: MaterialApp(
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          )),
    );

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  // UserPovider up = Provider.of(context,listen:false);

  void getUser() async {
    if (_controller.text.isEmpty) {
      return Provider.of<UserProvider>(context, listen: false)
          .setMessage("please enter your username");
    } else {
      // Provider.of<UserProvider>(context, listen: false)
      //     .fetchUser(_controller.text)
      //     .then((value) {
      //   if (!value) {
      //     return Provider.of<UserProvider>(context, listen: false).getMessage();
      //   } else if(value){
      //     return Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => FollowingPage()));
      //   }
      // });
      final result = await Provider.of<UserProvider>(context, listen: false)
          .fetchUser(_controller.text);
      if (result) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => FollowingPage()));
      } else {
         Provider.of<UserProvider>(context, listen: false).getMessage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // UserPovider up = Provider.of(context,listen:false);
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 100),
                    Container(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage('assets/images/github.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Github",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 150),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(.1)),
                      child: TextField(
                        onChanged: (value) {
                          userProvider.setMessage(null);
                        },
                        controller: _controller,
                        enabled: !userProvider.isLoading(),
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorText: userProvider.getMessage(),
                          border: InputBorder.none,
                          hintText: "Github Username",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        padding: EdgeInsets.all(20),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          child: userProvider.isLoading()
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2,
                                )
                              : Text(
                                  'Get Your Following',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        onPressed: () => getUser()),
                  ],
                )),
          ),
        ),
      );
    });
  }
}



















// import 'package:flutter/material.dart';

// //the main function is the starting point for all our flutter apps.
// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.blueGrey,
//         appBar: AppBar(
//           title: Center(child: Text("I am Rich")),
//           backgroundColor: Colors.blueGrey[900],
//         ),
//         body: Center(
//             child: Image(
//           image: AssetImage('assets/images/diamond.png'),
//         )),
//       ),
//     ),
//   );
// }
