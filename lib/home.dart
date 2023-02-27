import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Container(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return Text(
                'Loading',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 34),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder:(context,index){
                      Contact contact = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(contact.displayName),
                          subtitle: Column(
                            children: [
                              Text(contact.phones.toString())
                            ],
                          ),
                        ),
                      );
                  }
              );
            }
          }
        ),
      )


    );
  }

  Future <List<Contact>> getContacts() async{
    bool isGranted = await Permission.contacts.status.isGranted;

    if(!isGranted){
      isGranted = await Permission.contacts.request().isGranted;
    }
    if(isGranted){
      return await FastContacts.getAllContacts();
    }
    return [];
  }
}
