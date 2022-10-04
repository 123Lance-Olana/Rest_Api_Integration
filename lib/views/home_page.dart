import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sample_app/models/products.dart';
import 'package:sample_app/services/remote_service.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/views/login_page.dart';






class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    List<ProductModel>? posts = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

  
    getProducts();
  }

 







  void getProducts() async {


    try {


var response = await Client().get(Uri.parse('/products')).catchError((err) {});
                  if (response == null) return;
                  debugPrint('successful:');

                  var users = productModelFromJson(response.body);
                  debugPrint('Users count: ' + users.length.toString());

    } catch (e) {
      print(e);
    }
    

 




  }


  






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Products'),
        actions: [
          TextButton(onPressed: () async {
             var user = ProductModel(
                    name: 'Sample Name',
                    description: 'Sample Description'
                  );

                  var response = await Client().post(Uri.parse('/products')).catchError((err) {});
                  if (response == null) return;
                  debugPrint('successful:');

          
               
          }, child: Text('Login',
          style: TextStyle(
            color: Colors.white
          ),),),
          TextButton(onPressed: () {
            Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterPage()));
          }, child: Text('Register',
          style: TextStyle(
            color: Colors.white
          ),),)
        ],
        
        
      ),
      body:   Column(
        children: 
          [
            Expanded(
            child: SizedBox(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              itemCount: posts?.length,
              itemBuilder: ((context, index) {
                
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.network('https://pngimg.com/uploads/running_shoes/running_shoes_PNG5805.png'),
                      ),
                      height: 120,
                        width: 200,
                      decoration: BoxDecoration(
                
                        color: Colors.teal,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
                      ),
                    ),
                     GestureDetector(
                      onTap: () async {
                      
                      },
                       child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                          child: Text('Shoes ${index}'),
                        ),
                        height: 60,
                          width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                        ),
                                   ),
                     ),
                  ],
                ),
              );
                    })),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              child: Text('Add Product',
              style: TextStyle(
                color: Colors.white,
              ),),
              minWidth: 250,
              color: Colors.teal,
              onPressed: () {
                post(Uri.parse('/products'));
              }),
          ),
        ],
      ),
    );
  }
}