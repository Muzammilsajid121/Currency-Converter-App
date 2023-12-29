import 'dart:convert';
import 'package:currency_converter/Models/currency_model.dart';
import 'package:http/http.dart' as http;

class CurrencyApiServices{

   Future<CurrencyModel> fetchWorldCurrencyApi()async{
   
     final response = await http.get(Uri.parse('https://open.er-api.com/v6/latest/USD'));

      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        return CurrencyModel.fromJson(data);
      }else{
        // return CurrencyModel.fromJson(data);
        throw Exception();
        
      }
    }

}