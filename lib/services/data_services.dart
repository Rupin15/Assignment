import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:assignment/model/data_model.dart';

class DataServices{
  String  baseUrl = 'http://mark.bslmeiyu.com/api' ;

  static Future<List<DataModel>> getInfo() async {
    try{
      http.Response res = await http.get(Uri.parse('http://mark.bslmeiyu.com/api/getplaces'));
      if(res.statusCode == 200){
        // response is success
        List<dynamic> list = json.decode(res.body);

        return list.map((block) => DataModel.fromJson(block)).toList();
      }else{

        return <DataModel>[];
      }
    }catch (e){
      print(e);
      return <DataModel>[];
    }
  }

}