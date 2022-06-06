import 'package:flutter/material.dart';
import 'package:interceptor_concept_app/config/config.dart';
import 'package:interceptor_concept_app/models/organisation_unit_model.dart';
import 'package:interceptor_concept_app/services/http_service.dart';
import 'package:interceptor_concept_app/services/organisation_unit_service.dart';
import 'package:interceptor_concept_app/services/sharedPreference_helper_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interceptor App Demo Concept',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Interceptor App Demo Concept'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Dhis2OrganisationUnit> _organisationUnits = [];

   data()async{
     SharedPreferenceHelper.setUserToken(key: 'username', value: AppConfig.username);
     SharedPreferenceHelper.setUserToken(key: 'password', value: AppConfig.password);
    _organisationUnits =await OrganisationUnitService().discoveringOrganisationUnit();
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
            switch(snapshot.connectionState){
              case (ConnectionState.waiting):
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case (ConnectionState.done):
                return Column(
                  children:_organisationUnits.map((Dhis2OrganisationUnit organisationUnit){
                    return ListTile(
                      title: Text(organisationUnit.name ??''),
                      subtitle: Text(organisationUnit.id ?? ''),
                    );
                  }).toList()); 
                
              default:
                return const Center(
                  child: Text('Error'),
                );
            }
          }
        
        , future: data()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
