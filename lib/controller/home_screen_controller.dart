import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapi/model/mymodel.dart';
import 'package:flutter/material.dart';
class HomeScreenController with ChangeNotifier{
  bool isLoading =false;
  PublicApiResponse? responseData;



fetchNews({String searchQuery ="trending"}) async{
  isLoading=true;
  notifyListeners();
  
   final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$searchQuery&apiKey=c794e5a8681e4e4bb0acd702bc250a42');
    var response = await http.get(url);
    
    responseData = PublicApiResponse.fromJson(jsonDecode(response.body));

  isLoading=false;
  notifyListeners();

}




}