import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class HomeMedicaApi{

  String baseUrl = "home-medica-tests-api.herokuapp.com";

  Future<String?> getDiabetesResult(Map<String,dynamic> queryParameters)async{

    String? result;

    var uri = Uri.https(baseUrl, '/diabetes',queryParameters);
    
    http.Response response = await http.get(uri);
    Map<String,dynamic> map = jsonDecode(response.body);
    print("Map: ${map}");

    print('responseStatusCode: ${response.statusCode}');

    if(response.statusCode == 200){
      if(map['Positive']==true){
        result = "sadly +Positive with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }else{
        result = "yaay -Negative with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }
    }else{
      result = "something wrong happened pls try again";
      return null;
    }
  }


  Future<String?> getBreastcancerResults(Map<String,dynamic> queryParameters)async{

    String? result;

    var uri = Uri.https(baseUrl, '/breastCancer',queryParameters);

    http.Response response = await http.get(uri);
    Map<String,dynamic> map = jsonDecode(response.body);
    print("Map: ${map}");


    print('responseStatusCode: ${response.statusCode}');

    if(response.statusCode == 200){
      if(map['Positive']==true){
        result = "sadly +Positive Malignant with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }else{
        result = "yaay -Negative (Benign) with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }
    }else{
      result = "something wrong happened pls try again";
      return null;
    }


  }



  Future<String?> getHeartDiseaseResults(Map<String,dynamic> queryParameters)async{

    String? result;

    var uri = Uri.https(baseUrl, '/heartDisease',queryParameters);

    http.Response response = await http.get(uri);
    Map<String,dynamic> map = jsonDecode(response.body);
    print("Map: ${map}");


    print('responseStatusCode: ${response.statusCode}');

    if(response.statusCode == 200){
      if(map['Positive']==true){
        result = "sadly +Positive HeartDisease with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }else{
        result = "yaay -Negative HeartDisease with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }
    }else{
      result = "something wrong happened pls try again";
      return null;
    }

  }


  Future<String?> getKidneyDiseaseResults(Map<String,dynamic> queryParameters)async{

    String? result;

    var uri = Uri.https(baseUrl, '/KidneyDisease',queryParameters);

    http.Response response = await http.get(uri);
    Map<String,dynamic> map = jsonDecode(response.body);
    print("Map: ${map}");


    print('responseStatusCode: ${response.statusCode}');

    if(response.statusCode == 200){
      if(map['Positive']==true){
        result = "sadly +Positive Chronic kidney Disease with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }else{
        result = "yaay -Negative Chronic kidney Disease with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }
    }else{
      print('error: ${map['detail']}');
      result = "something wrong happened pls try again";
      return null;
    }


  }

  Future<String?> getLiverDiseaseResults(Map<String,dynamic> queryParameters)async{

    String? result;

    var uri = Uri.https(baseUrl, '/liverDisease',queryParameters);

    http.Response response = await http.get(uri);
    Map<String,dynamic> map = jsonDecode(response.body);
    print("Map: ${map}");


    print('responseStatusCode: ${response.statusCode}');

    if(response.statusCode == 200){
      if(map['Positive']==true){
        result = "sadly +Positive Liver Disease with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }else{
        result = "yaay -Negative Liver Disease with accuracy ${(map['Accuracy'])*100}%";
        return result;
      }
    }else{
      print('error: ${map['detail']}');
      result = "something wrong happened pls try again";
      return null;
    }


  }

  Future<String?> getMalariaDiseaseResults(XFile image)async{


    String? res = await uploadImage(File(image.path).path, 'https://home-medica-tests-api.herokuapp.com/malariaDisease/','cell_image');

    return res;

  }

  Future<String?> getPneumoniaDiseaseResults(XFile image)async{


    String? res = await uploadImage(File(image.path).path, 'https://home-medica-tests-api.herokuapp.com/pneumoniaDisease/','xray_image');

    return res;

  }

  Future<String?> getCovid19DiseaseResults(XFile image)async{


    String? res = await uploadImage(File(image.path).path, 'https://home-medica-tests-api.herokuapp.com/covid19/','xray_image');

    return res;

  }


  Future<String?> uploadImage(filename, url,String imageName) async {
    String? result;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath(imageName, filename));
    var res = await request.send();
    print("statusCode: ${res.statusCode}");
    http.Response response = await http.Response.fromStream(res);
    print('body: ${response.body}');
    if(response != null)
    {
    Map<String,dynamic> map = jsonDecode(response.body);
      if(response.statusCode == 200){
        if(map['Positive']==true){
          result = "sadly +Positive Covid19 Disease with accuracy ${(map['Accuracy'])*100}%";
        }else{
          result = "yaay -Negative Covid19 Disease with accuracy ${(map['Accuracy'])*100}%";
        }
      }

    }
    else
      result = "something wrong happened pls try again";
    return result;
  }





}