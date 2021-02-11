import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Task',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List movieNames = ["Forrest Gump","Star Wars:Episode III","The Godfather","The Lord of the Rings","Friends with Benefits","Yes Man","Requiem for a Dream","The Dark Knight","Despicable Me","Mr.Nobody"];
  final List img = ["assets/1.jpg","assets/2.jpg","assets/3.jpg","assets/4.jpg","assets/5.jpg","assets/6.jpg","assets/7.jpg","assets/8.jpg","assets/9.jpg","assets/10.jpg"];
  String like='0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: movieNames.length,
        itemBuilder: (BuildContext _context, int index) {
          final movieName = movieNames[index];
          final imgPath = img[index];
          return Dismissible(
            key: Key(movieName),
            child: _buildTile('$imgPath', '$movieName'),
            onDismissed: (direction){

                setState(() {
                  movieNames.removeAt(index);
                });

            },
            background: Container(
              color: Colors.red,
            ),
          );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return _FbPage();}));
        },
        tooltip: 'FaceBook Page',
        child: Icon(Icons.tune),
      ),
    );
  }
  Widget _buildTile(String imgPath, String mName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Hero(
          tag: imgPath,
          child: Image(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
            height: 60.0,
            width: 60.0,
          ),
        ),
        title: Text('$mName'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$like'),
            Icon(Icons.thumb_up_alt),
            Text('/$like'),
            Icon(Icons.thumb_down_alt)
          ],
        ),
      ),
    );
  }
}

class _FbPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebView(initialUrl: 'https://www.facebook.com/apple/',
    javascriptMode: JavascriptMode.unrestricted,),);
  }
}