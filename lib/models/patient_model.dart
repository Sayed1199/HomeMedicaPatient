
class PatientModel{

  late String id;
  late int finished;

  PatientModel({required this.id,required this.finished});


  factory PatientModel.fromJson(Map<String,dynamic> map){
    return PatientModel(id: map['id'], finished: map['finished']);
  }

  static Map<String,dynamic> toJson(PatientModel model){
    return {
      'id':model.id,
      'finished':model.finished
    };
  }


}