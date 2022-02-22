import 'package:flutter/material.dart';
import 'package:lms/shared/component/constants.dart';
class AmitionTest extends StatefulWidget {
  const AmitionTest({Key? key}) : super(key: key);

  @override
  _AmitionTestState createState() => _AmitionTestState();
}

class _AmitionTestState extends State<AmitionTest> {
  bool moveLeft =false;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      moveLeft = !moveLeft;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {
              moveLeft = !moveLeft;
            });
          }, icon: Icon(Icons.star))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        height: 400,
        width: double.infinity,
        color: Colors.grey[100],
        child:Stack(
          children: [
             Positioned(
              top: 100,
              child: Container(
                height: 3,
                width: 600,
                color: primaryColor,
              ),
            ),
            AnimatedPositioned(
              top: 74,
              left:moveLeft? 200:250,
              duration: Duration(seconds: 3),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
              ),
            ),
            AnimatedPositioned(
              top: 74,
              left:moveLeft? 100:120,
              duration: Duration(seconds: 3),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
              ),
            ),
            AnimatedPositioned(
              top: 74,
              left:moveLeft ? 40 : 50,
              duration: Duration(seconds: 1),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
