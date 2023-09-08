import 'package:flutter/material.dart';
import 'dart:core';
import 'package:csc_picker/csc_picker.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    String countryValue = "";
    String? stateValue = "";
    String? cityValue = "";
    String address = "";
    Size size=MediaQuery.of(context).size;
    return  Scaffold(

        key: scaffoldKey,

        backgroundColor: Color(0xFFffffff),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child:  Form(
            key:formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.1),
                Text("Contact us ", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                SizedBox(height: height*0.03),
                TextFormField(

                  decoration: InputDecoration(
                      labelText: "Enter your name"
                  ),
                  validator: (value){
                    if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                      return "Enter correct name";
                    }else{
                      return null;
                    }
                  }
                ),

                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Enter your number"
                  ),
                  validator: (value){
                    if(value!.isEmpty || !RegExp(r'^[+*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s./0-9]+$').hasMatch(value!)){
                      return "Enter correct number";
                    }else{
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Enter your email"
                  ),
                  validator: (value){
                    if(value!.isEmpty || ! RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value!)){
                      return "Enter correct email";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: height*0.05),
                  CSCPicker(
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged:(value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged:(value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
                // SizedBox(height: height*0.05),
                Row(
                  children: [
                    Text("Gender: "),
                    SizedBox(width: size.width*0.05,),
                    GenderSelector()
                  ],
                ),
                SizedBox(height: height*0.03),
                SubmitButton(formKey: formKey),
              ],
            ),
          )
        )
    );

  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      if(formKey.currentState!.validate()){
        final snackbar=SnackBar(content: Text("Submitted"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    },

      style:  ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: SizedBox(
          width: double.infinity,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.app_registration),
              Text("Submit",
                style: TextStyle(fontSize: 18),
              )
            ],
          )

      ),

    );
  }
}


class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key});

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {

  List<String> list=<String>['Male','Female','Non-binary'];
  String dropdownValue = 'Male';
  IconData icon=Icons.male;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(icon),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          if(value=='Male') icon=Icons.male;
          else if(value=='Female') icon=Icons.female;
          else icon=Icons.transgender_sharp;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }
}

