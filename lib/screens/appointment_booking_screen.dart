import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/auth_controller.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentBookingScreen extends StatefulWidget {

  final String speciality;
  final int index;

  const AppointmentBookingScreen({Key? key,required this.speciality,required this.index}) : super(key: key);

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {

  ThemeController themeController = Get.put(ThemeController());
  AuthController authController = Get.put(AuthController());
  String today="";
  String? bookingTime;
  bool loading=false;
  bool onlineMeetingSelected=false;
  String lastMeetingTime='';

  String price="";

  List<Map<String,String>> specialities = [{"Cardiologist":"Cardiology"},{"Dentist":"Dentistry"},
    {"Eye Special":"Ophthalmology"},{"Orthopaedic":"Orthopaedics"},{"Paediatrician":"Pediatrics"}];
  String curDay='';

  Future<List<String>> getTakenTimes(bool isOffline)async{
    List<String> takenList=[];
    String day =  DateFormat("EEEE").format(DateTime.now());

    QuerySnapshot<Map<String,dynamic>> reference =await FirebaseFirestore.instance.collection("RESERVATIONS")
        .doc(specialities[widget.index][widget.speciality]!).collection(isOffline? "OFFLINE":"ONLINE")
        .doc("DOCS").collection(curDay.toUpperCase()).orderBy("timeStamp",descending: true).get();

     List<QueryDocumentSnapshot<Map<String,dynamic>>> mList = reference.docs;

     mList.forEach((element) {
       String endTime = DateFormat("HH:mm").format(DateTime.parse((element.data() as Map<String,dynamic>)["endTime"])).toString();
       String startTime = DateTime.parse((element.data() as Map<String,dynamic>)["endTime"]).subtract(Duration(minutes: 15)).toString();
       String formattedStartTime = DateFormat("HH:mm").format(DateTime.parse(startTime)).toString();
       takenList.add("${formattedStartTime} - ${endTime}");
     });

     print("takenList: ${takenList}");

     return takenList;

  }

  Future<String> getEarlierTimes(bool isOffline)async{

    DocumentSnapshot<Map<String,dynamic>> hospitalData =await FirebaseFirestore.instance.collection(HOSPITAL_TABLE_COLLECTION).
    doc(curDay.toUpperCase()).get();
    String time = hospitalData[specialities[widget.index][widget.speciality]!]['time'];
    return time;

    }



  late Razorpay razorpay;
  bool hasPaid = false;
  
  Future<String> getPaymentPrice()async{
    
    DocumentSnapshot<Map<String,dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection(HOSPITAL_TABLE_COLLECTION)
        .doc(curDay.toUpperCase()).get();


    return (documentSnapshot.data() as Map<String,dynamic>)[specialities[widget.index][widget.speciality]]['price'];

    
  }

  List<String> takenTimes=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   today = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
   curDay = DateFormat("EEEE").format(DateTime.now());
   getEarlierTimes(true).then((value) {
     setState((){
        lastMeetingTime = value;
        print("LastMeetingTime: $value");
     });
   });

   getPaymentPrice().then((value) {
     setState((){
       price = value;
     });
   });

   razorpay = Razorpay();
   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentFailure);
   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    getTakenTimes(true).then((value){
      setState((){
        takenTimes = value;
      });
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Obx(()=>
          Text("Appointment Booking",style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
          ),),
        ),
      ),

      body: Center(
        child: !loading? ListView(
          children: [

            SizedBox(height: 20,),

            Center(
              child: Obx(()=>
                  Text("Booking a "+widget.speciality,style: GoogleFonts.alef(
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),)),
            ),

            SizedBox(height: 20,),

            Center(
              child: Obx(()=>
                  Text(today,style: GoogleFonts.badScript(
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),)),
            ),

            SizedBox(height: 20,),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Obx(()=>
                  Center(
                    child: Text("**Available times start at\n"+ lastMeetingTime,textAlign: TextAlign.center,style: GoogleFonts.akayaTelivigala(
                      color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),),
                  ),
              ),
            ),

            SizedBox(height: 20,),


            Center(
              child: Container(
                child: FlutterSwitch(
                  width: 210.0,
                  height: 60.0,
                  valueFontSize: 20.0,
                  toggleSize: 45.0,
                  value: onlineMeetingSelected,
                  borderRadius: 30.0,
                  padding: 8.0,
                  showOnOff: true,
                  inactiveText: "Offline Meeting",
                  activeText: "Online Meeting",
                  activeTextFontWeight: FontWeight.w300,
                  inactiveTextFontWeight: FontWeight.w400,
                  onToggle: (val) {

                    onlineMeetingSelected = val;
                    setState(() {
                    });

                     getEarlierTimes(!val).then((value) {
                     });

                     getTakenTimes(!val).then((value) {
                       takenTimes=value;
                         setState((){});
                     });

                    print("Value: ${onlineMeetingSelected}");
                  },
                ),
              ),
            ),

            SizedBox(height: 10,),

          takenTimes.isNotEmpty? Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [

               Obx(() =>   Text("Taken Times",style: GoogleFonts.averageSans(
                 color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                 fontWeight: FontWeight.w500,
                 fontSize: 18,
               ),
               ),),

                SizedBox(width:20),

                SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width*0.6,
                        child: CupertinoScrollbar(
                          child: ListView.builder(
                            itemCount: takenTimes.length,
                            itemBuilder: (context,index) => Obx(()=>
                                Text(takenTimes[index],style: GoogleFonts.averageSans(
                                  color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                                ),
                            ),
                          ),
                        ),

               ),
             ],
           ):Container(width: 0,height: 0,),

            SizedBox(height: 10,),


            SizedBox(height: 30,),

            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Obx(()=>
                Text(onlineMeetingSelected? "Select a Online meeting Time...":"Select a Offline meeting Time...",style: GoogleFonts.averageSans(
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),),
              ),
            ),

        SizedBox(height: 10,),


            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: DateTimePicker(
                  type: DateTimePickerType.time,
                  //timePickerEntryModeInput: true,
                  initialValue: '', //_initialValue,
                  icon: Icon(Icons.access_time),
                  timeLabelText: "Click to select time",
                  timeHintText: "Select Time here",
                  locale: Locale('pt', 'BR'),
                  style: GoogleFonts.lato(
                    fontSize: 20
                  ),
                  use24HourFormat: true,
                  onChanged: (val) {
                    print('Value is: ${val}');
                    bookingTime = val;
                    setState((){

                    });
                  },
                  onSaved: (val) {
                    print('saved Value is: ${val}');
                  },
                ),
              ),
            ),

           bookingTime==null?Container(width: 0,height: 0,): SizedBox(height: 30,),

            bookingTime==null?Container(width: 0,height: 0,): Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(()=>
                   Text("Price:    $price USD",style:  GoogleFonts.lato(
                    fontSize: 18,
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                  ),),
                ),

                SizedBox(width: 30,),

                GestureDetector(
                  onTap: startPayment,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pinkAccent
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Obx(()=>
                          Text("Pay Now",style:  GoogleFonts.lato(
                              fontSize: 20,
                              color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                          ),),
                      ),
                    ),
                  ),
                ),

              ],
            ),

            /*

            SizedBox(height: 30,),

            bookingTime!=null? GestureDetector(
              onTap: handleSubmitButton,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Obx(()=>
                      Text("Submit",style: GoogleFonts.lato(
                        fontSize: 22,
                        color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                        fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
              ),
            ):Container(width: 0,height: 0,),


             */



          ],
        ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            LoadingWidget(),
            SizedBox(height: 20,),
            Obx(()=>
                Text("Please Wait...",style: GoogleFonts.lato(
                    fontSize: 22,
                    color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w500
                ),),
            ),

          ],
        ),
      ),

    );
  }

  Future<void> handleSubmitButton() async {

      int hrs = int.parse(bookingTime!.split(":")[0]);
      int mins = int.parse(bookingTime!.split(":")[1]);


      DateTime dt = DateTime.parse(
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
      String date = DateFormat('yyyy-MM-dd').format(dt);


      print("booking team: ${date}");

      DateTime startingTime = DateTime(dt.year, dt.month, dt.day, hrs, mins);

      DateTime endTime = startingTime.add(Duration(minutes: 15));

      print("startingTime: ${startingTime}");
      print("lastAppointmentTime: ${lastMeetingTime}");




      setState(() {
        loading = true;
      });

      DateTime n = DateTime.now();

      Map<String, dynamic> map = {
        'bookerID': authController.firebaseUser.value!.uid.toString(),
        'timeStamp': Timestamp.fromDate(n),
        'endTime': endTime.toString(),
        'isFinished': false,
        'speciality': widget.speciality
      };

      print("endTime: ${endTime.toString()}");
      print("map: $map");



      if (onlineMeetingSelected) {
        await FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(
            authController.firebaseUser.value!.uid)
            .collection("BOOKINGS").doc(
            specialities[widget.index][widget.speciality]).collection(
            "RESERVATIONS")
            .doc(curDay.toUpperCase()).collection("ONLINE_BOOKINGS").doc(
            authController.firebaseUser.value!.uid).set(
            map, SetOptions(merge: true));


        await FirebaseFirestore.instance.collection("RESERVATIONS")
            .doc(specialities[widget.index][widget.speciality]!).collection(
            "ONLINE").doc("DOCS").collection(curDay.toUpperCase()).doc(
            authController.firebaseUser.value!.uid)
            .set(map, SetOptions(merge: true));
      } else {
        await FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(
            authController.firebaseUser.value!.uid)
            .collection("BOOKINGS").doc(
            specialities[widget.index][widget.speciality]).collection(
            "RESERVATIONS")
            .doc(curDay.toUpperCase()).collection("OFFLINE_BOOKINGS").doc(
            authController.firebaseUser.value!.uid).set(
            map, SetOptions(merge: true));


        await FirebaseFirestore.instance.collection("RESERVATIONS")
            .doc(specialities[widget.index][widget.speciality]!).collection(
            "OFFLINE").doc("DOCS").collection(curDay.toUpperCase()).doc(
            authController.firebaseUser.value!.uid)
            .set(map, SetOptions(merge: true));
      }



      setState(() {
        loading = false;
      });

      Fluttertoast.showToast(msg: "Meeting Booked Successfuly",
          backgroundColor: Colors.blue,
          gravity: ToastGravity.BOTTOM);

  }

  void openCheckOut()async{
    bool getout=false;
    setState((){
      loading=true;
    });


    if(bookingTime == null){
      setState((){
        loading=false;
      });
      Fluttertoast.showToast(msg: "Sorry The Booking time is null",backgroundColor: Colors.blue,gravity: ToastGravity.BOTTOM);
      return;
    }



    DateTime mToday = DateTime.now();

    DateTime bookingDateTime = DateTime(mToday.year,mToday.month,mToday.day,int.parse(bookingTime!.split(":")[0]),int.parse(bookingTime!.split(":")[1]));

    String startDayTimeAsString = lastMeetingTime.split("-")[0];
    String endDayTimeAsString = lastMeetingTime.split("-")[1];

    DateTime startDayTime = DateTime(mToday.year,mToday.month,mToday.day,int.parse(startDayTimeAsString.split(":")[0]),
        int.parse(startDayTimeAsString.split(":")[1]));

    DateTime endDayTime = DateTime(mToday.year,mToday.month,mToday.day,int.parse(endDayTimeAsString.split(":")[0]),
        int.parse(endDayTimeAsString.split(":")[1]));

    if(bookingDateTime.isBefore(startDayTime) || bookingDateTime.isAfter(endDayTime)){

      setState((){
        loading=false;
      });

      Fluttertoast.showToast(msg: "Sorry The Booking time is not Valid",backgroundColor: Colors.blue,gravity: ToastGravity.BOTTOM);

      return;
    }

   

    takenTimes.forEach((element) {
      String startingDateTimeAsString = element.split("-")[0];
      String endDateTimeAsString = element.split("-")[1];


      DateTime startDateTime = DateTime(mToday.year,mToday.month,mToday.day,int.parse(startingDateTimeAsString.split(":")[0]),int.parse(startingDateTimeAsString.split(":")[1]));
      DateTime endDateTime = DateTime(mToday.year,mToday.month,mToday.day,int.parse(endDateTimeAsString.split(":")[0]),int.parse(endDateTimeAsString.split(":")[1]));

      if(bookingDateTime.isBefore(endDateTime) && bookingDateTime.isAfter(startDateTime)){
        setState((){

          loading=false;
        });
        Fluttertoast.showToast(msg: "Sorry this Booking time is taken",backgroundColor: Colors.blue,gravity: ToastGravity.BOTTOM);
        getout=true;
        return;
      }
    });

    if(getout){
      setState((){
        loading=false;
      });
      return;
    }

    String key="rzp_test_yMdrQX3zaPqK8K";
    String secret = "66OcZjCBhGnydDTq1trAICIi";
    int amount = int.parse(price)*100;
    String orderID = await generateOrderId(key, secret, amount);
    var options = {
      "callback_url": 'https://your-server/callback_url',
      "redirect": true,
      'key':key,
      "amount":amount,
      "order_id": orderID,
      "name":"HomeMedica",
      "description":"Paying for the Reservation...",
      "prefill":{
        "contact":"1554401926",
        "email":"phenomenalboy0@gmail.com"
      },
      "external":{
        "wallets":["paytm"]
      }
    };

    try{
      razorpay.open(options);
      setState((){
        loading=false;
      });
    }catch(e){
      print("payment error ${e.toString()}");
      setState((){
        loading=false;
      });
    }

  }

    void handlerPaymentSuccess(PaymentSuccessResponse response) async{
      //Fluttertoast.showToast(msg: "Payment Success...",gravity: ToastGravity.BOTTOM,backgroundColor: Colors.blue);
      setState((){
        hasPaid=true;
      });
       await handleSubmitButton();
      setState((){
        hasPaid=false;
      });
    }

    void handlerPaymentFailure(PaymentFailureResponse response) async{
      print("payment Failure");
      print("${response.message.toString()} + code ${response.code}");
      //Fluttertoast.showToast(msg: "Payment Failure... pls try again",gravity: ToastGravity.BOTTOM,backgroundColor: Colors.blue);

      setState((){
        hasPaid=true;
      });
      await handleSubmitButton();
      setState((){
        hasPaid=false;
      });

  }

    handlerExternalWallet(ExternalWalletResponse response) {
      print("payment External Wallet");
    }


  void startPayment() async{
    openCheckOut();
  }

  Future<String> generateOrderId(String key, String secret,int amount) async{
    var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));

    var headers = {
      'content-type': 'application/json',
      'Authorization': authn,
    };

    var data = '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

    var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'), headers: headers, body: data);
    if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
    print('ORDER ID response => ${res.body}');

    return json.decode(res.body)['id'].toString();
  }

}
