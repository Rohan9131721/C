import 'messages.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   late DialogFlowtter DialogF;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => DialogF = instance);
    super.initState();
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    // this Message is written in dialogFlowtter class.
    messages.add({'message': message,
      'isUserMessage':isUserMessage});
  }
  sendMessage(String text) async {
    // this function is for the send to send the message.
    if (text.isEmpty) {
      print('Message is Empty');
    } else {
      setState(() {
        addMessage(Message(
          text: DialogText(text: [text])),true
        );
      });
      DetectIntentResponse response = await DialogF.detectIntent(queryInput: QueryInput(
        text: TextInput(text: text),),);
      if(response.message==null){
        return;
      }
      setState(() {
        addMessage(response.message!);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 70,
        leading: Center(
        //child: Image.asset("assets/images/logo.png", height: 80),
    ),
    title: Text(
    ' AKGEC ChatBot ',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 25),
    ),
    ),
    body: Container(
    child: Column(
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
    child: Text(
    '(Affiliated to Dr. APJ Abdul Kalam Technical University, Lucknow, UP, College Code - 027)',
    textAlign: TextAlign.center,
    )),
    ),
    const Divider(
    thickness: 2,
    color: Colors.black,
    ),
    Container(
    child: Text(
    'Chat with us',
    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, decoration: TextDecoration.underline,),

    ),
    color: Colors.yellow,

    ),
    Expanded(child: MessageScreen(messages: messages)),
    Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    color: Colors.black,
    child: Row(
    children: [
    Expanded(
    child: TextField(
    controller: _controller,
    style: TextStyle(color: Colors.white, fontSize: 20),
    )),
    IconButton(
    onPressed: () {
    sendMessage(_controller.text);
    _controller.clear();
    },
    icon: Icon(Icons.send),
    color: Colors.white,
    )
    ],
    ),
    )
    ],
    ),
    ),
    );
  }
}
