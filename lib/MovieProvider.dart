import "dart:math";

import "package:flutter/material.dart";
final List initialData=[1,2,3,4,5,6,7,8,9,10];

class MoviesProvider extends ChangeNotifier{
    final List _data=initialData;
    List get data=>_data;
    final List _myFav=[];
    List get myFav=>_myFav;
    void addNum(int num){
      _myFav.add(num);
      notifyListeners();
    }
    void removeNum(int num){
      _myFav.remove(num);
      notifyListeners();
    }

}