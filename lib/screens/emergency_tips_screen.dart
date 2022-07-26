import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/constants.dart';
import 'package:homemedica_patient/controllers/theme_controller.dart';
import 'package:homemedica_patient/controllers/tips_search_controller.dart';

TipsSearchController searchController = Get.put(TipsSearchController());

int? toNavigateTo = null;

class EmergencyTipsScreen extends StatefulWidget {
  const EmergencyTipsScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyTipsScreen> createState() => _EmergencyTipsScreenState();
}

class _EmergencyTipsScreenState extends State<EmergencyTipsScreen> {
  ThemeController themeController = Get.put(ThemeController());
  TextEditingController textEditingController = TextEditingController();

  String bullet = "\u2022 ";


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  void startSearching(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    searchController.isSearching.value=true;
  }

  void _stopSearching() {
    _clearSearchQuery();
    searchController.isSearching.value=false;
  }

  void _clearSearchQuery() {
    textEditingController.clear();
    searchController.searchQuery.value='';
  }

  List<Widget> getTheList(){
    return [

      SizedBox(height: 20,),


      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("1. "+emergencies[0]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "If a person is choking, you should not interfere as long as he is coughing.\n"
                              "If coughing does not dislodge the object from the trachea and the victim is "
                              "breathing with extreme difficulty, or if he turns a bluish color"
                              "and appears to be choking but is unable to cough or speak,\n quickly ask, "
                              "Are you choking? A choking victim can nod his head 'yes,' but will be unable to talk."
                              "It is important to ask this question because a person suffering from a heart attack will have similar symptoms, "
                              "but he will be able to talk.\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("In Case of an Actual Emergency strictly Use the Abdominal Thrust.\n the way to do so is listed below:",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Stand behind him with your arms around his waist.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Place one fist, with the knuckle of the thumb against the victim's midsection, slightly above the navel but well below the breastbone.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Hold your fist firmly with the other hand and pull both hands sharply toward you with an upward-and-inward jab.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet This procedure should be administered continually until either the object is forced out or the victim becomes unconscious.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Take the patient to the doctor immediately if you're not comfortable handling the emergency.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pink,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("2. "+emergencies[1]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Before losing consciousness, the victim may complain of:\n"
                              "$bullet Light headedness\n"
                              "$bullet Weakness\n"
                              "$bullet Nausea\n"
                              "$bullet Skin may be pale and clammy\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("If a person begins to feel faint, he should...:",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Lean forward.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Lower head toward knees.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("When the victim becomes unconscious",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Keep the victim lying down with head lowered and legs elevated.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Loosen any tight clothing.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Apply cool, damp cloths to face and neck.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  In most cases, the victim will regain consciousness shortly after being placed in this position."
                          " Ensure that the patient has regained full consciousness by asking him questions of his identity.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),



                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("3. "+emergencies[2]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "A convulsion (violent, involuntary contraction or muscle spasm) can be caused by epilepsy or sudden illness."
                              " It is dangerous if the victim stops breathing."
                              " In such cases, it is recommended to seek doctor's assistance.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 10,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Symptoms",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Muscles become stiff and hard, followed by jerking movements.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  The patient may bite his tongue or stop breathing.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Face and lips may turn a bluish color.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  May salivate excessively or foam at the mouth.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Tips for action",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Clear all objects away from the victim and place something soft under the head.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Do not place anything between the teeth or in the patient's mouth.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Do not give the victim any liquids.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  If the victim stops breathing, check to see that the airway is open and begin rescue.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Stay calm and keep the victim comfortable until help arrives.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Most convulsions are followed by a period of unconsciousness or another convulsion.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Take the patient to the doctor at the earliest.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),



                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("4. "+emergencies[3]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),



                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Actions",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Cool the body of a heatstroke victim immediately.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  If possible, put him in cool water; wrap him in cool wet clothes; or sponge his skin with cool water, rubbing ice, or cold packs..",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Once the victim's temperature drops to about 101 F, lay him in the recovery position in a cool room..",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  If the temperature begins to rise again, repeat the cooling process.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If he/she is able to drink, give him/her some water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Do not give any kind of medication.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Seek medical attention.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),



                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("5. "+emergencies[4]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Hypothermia is caused by prolonged exposure to cold temperatures.\n"
                              "It begins to occurs when your body temperature drops below 95 degrees Fahrenheit.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Symptoms",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Shivering.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Slurred speech or mumbling.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Week pulse.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Weak coordination.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Confusion.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Red, cold skin.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Loss of consciousness.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Treatment",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Be gentle with the afflicted person.\n"
                          "Don’t rub their body and don’t move their body in too jarring of a way; this could trigger cardiac arrest.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Move the person out of the cold, and remove any wet clothing.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Cover the person with blankets and use heat packs.\n"
                          "Don’t apply heat directly to the skin because this could cause major skin damage.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Give the person warm fluids.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If you set the person on the ground, be aware that the ground may also be a cold source.\n"
                          "Place warm materials on the ground that the person is going to lay on.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),


      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("6. "+emergencies[5]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Allergic reactions occur when your body is hypersensitive to a foreign substance.\n"
                              "Bee stings, certain foods, or drug ingredients can cause allergic reactions.\n"
                              "Anaphylaxis is a life-threatening allergic reaction that can be caused by all of those mention allergens.\n"
                              "The best way to treat an allergic reaction is to use an EpiPen.\n"
                              "EpiPen, or “epinephrine autoinjector,” is a small and ergonomic needle that’s used to inject epinephrine (adrenaline) into someone suffering greatly from an allergic reaction.\n"
                              "The epinephrine usually subdues the effects of the allergic reaction.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Treatment",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Keep the person calm.\n"
                          "Ask if they use an EpiPen and have one with them.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Have the person lie on their back. Keep their feet elevated 12 inches.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Make sure the person’s clothing is loose so they’re able to breathe.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Avoid giving them food, drink, or medicine.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If appropriate, learn how to inject an EpiPen in someone having a reaction.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Wait 5-15 minutes after using an EpiPen.\n"
                          "If the allergic reaction isn’t subdued, a second dose may be required.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),


      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("7. "+emergencies[6]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Sometimes it’s very easy to tell if someone has suffered a fractured bone.\n"
                              "But sometimes it’s not.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("What To Do",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Don’t try to straighten a fractured limb.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Use a splint or padding to stabilize the area and keep it from moving.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Apply a cold pack to the area. Don’t apply it directly to the skin.\n"
                          "Wrap it in a cloth or put it in a plastic bag.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Keep the area elevated, if possible.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Give the person an anti-inflammatory drug, like ibuprofen.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),


      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("8. "+emergencies[7]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "The loss of consciousness is always a serious sign.\n"
                              " Unconsciousness is described as the state in which the human being will not respond in any way to shaking,"
                              " shouting or pinching.\n If a person who appears unconscious recovers and ‘comes to’ quickly when shaken, "
                              "spoken to sharply, or pinched - instantly knows where he is and who he is -"
                              " then that person was asleep and not unconscious.\n In casualties who are only just unconscious,"
                              " the eyes may be moving about and when a bright light is shone into them the pupil’s contract.\n"
                              " In people who are deeply unconscious, however, the eyes may be fixed as if looking straight ahead with the pupils"
                              " dilated (bigger than normal); the pupils will not contract when a light is shone into them.\n"
                              " In these conditions—with the pupils dilated and the eyes fixed in one position ---"
                              " it usually means that the casualty is near to death.\n When you find a person apparently unconscious,"
                              " apply the Shake, Shout and Pinch routine.\n If there is no response, he is unconscious. \n"
                              "The loss of consciousness is always a serious sign. Unconsciousness is described as the state in which"
                              " the human being will not respond in any way to shaking, shouting or pinching. \nIf a person who appears"
                              " unconscious recovers and ‘comes to’ quickly when shaken, spoken to sharply, or pinched -"
                              " instantly knows where he is and who he is - then that person was asleep and not unconscious.\n"
                              " In casualties who are only just unconscious, the eyes may be moving about and when a bright light"
                              " is shone into them the pupil’s contract. \nIn people who are deeply unconscious, however,"
                              " the eyes may be fixed as if looking straight ahead with the pupils dilated (bigger than normal); "
                              "the pupils will not contract when a light is shone into them. \nIn these conditions—with the pupils"
                              " dilated and the eyes fixed in one position --- it usually means that the casualty is near to death.\n"
                              "When you find a person apparently unconscious, apply the Shake, Shout and Pinch routine. "
                              "If there is no response, he is unconscious.\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 10,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Care",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Place the casualty in the Recovery Position in the following manner: turn him onto his back.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Tuck his left arm under the left buttock.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Place the right arm above the head.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 10,),

                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(35)
                      ),
                      child: Image.asset('assets/images/unconciousness1.jpg'),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Pull the body over on top of the left side.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Bend the right leg up to the bent position.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Bend the right arm into the bent position.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Clear away anything loose from the mouth and throat,"
                          " including dentures, thus producing a clear airway so that casualty may breathe easily.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Ease the left arm out behind the body.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Now lift the head upwards and backwards to ensure that the airway is clear.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "In cases where it is impossible to turn the casualty into the Recovery Position owing to"
                          " the presence of other injuries, or his being trapped, then the maintenance of a"
                          " clear airway is carried out by placing two fingers behind the angle of the jaw"
                          " on both sides and pushing the jaw forward towards the nose. This will force the"
                          " tongue forward and away from the back of the throat, so clearing the airway.\n"
                          " If this simple procedure should fail to clear the airway, and then open the mouth,"
                          " clear any debris from it and then hold the tongue between the folds of a"
                          " handkerchief and pull it forwards. The airway should then be clear.\n"
                          " It is important to remember that the airway must be kept clear in one"
                          " of these ways until it is automatically kept clear by placing the casualty"
                          " in the Recovery Position or until a doctor or other trained person has passed"
                          " a special type of breathing tube. The untrained person attempting to"
                          " pass a tube may do more harm than good to the casualty.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Do not give any food or liquid by mouth, as this will make the casualty choke and block the airway so that he cannot breathe.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet  Now lift the head upwards and backwards to ensure that the airway is clear.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Whilst awaiting the arrival of the doctor or ambulance you must not only maintain the clear airway, but treat any other injuries the casualty may have sustained.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),



                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "If the casualty appears dead, i.e. if the breathing and heart appear to have just stopped,"
                          " then the Kiss of Life and heart massage must be started immediately.\n"
                          " A doctor or ambulance must also be summoned as soon as possible.\n"
                          " If the casualty is stiff from having died some time previously then leave the casualty"
                          " in the position in which you find him and call a doctor and, where appropriate, the police.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Causes of Unconsciousness",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Fainting.\n"
                          "$bullet Head injury\n"
                          "$bullet Stroke\n"
                          "$bullet Epilepsy – major fits or convulsions\n"
                          "$bullet Minor fits\n"
                          "$bullet Heart attacks\n"
                          "$bullet Diabetes\n"
                          "$bullet Drugs\n"
                          "$bullet Drink\n"
                          "$bullet Severe bleeding\n"
                          "$bullet Acute and severe allergy\n"
                          "$bullet Electric shock\n"
                          "$bullet Drowning\n"
                          "$bullet Gas poisoning\n",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),



                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("9. "+emergencies[8]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "This is usually easy to identify as the casualty will be lying unconscious near an electrical appliance or cable..\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Electrical Shock Treatment",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Before touching the casualty remember to switch off the electrical supply.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If the casualty is breathing, turn him into the Recovery Position.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If the casualty has stopped breathing, you must start the Kiss of Life and heart message immediately.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Send for a doctor or ambulance.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Drowning Treatment",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Clear the airway and determine whether causality is breathing and the heart pumping.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If the heart and breathing have stopped, then you immediately start the Kiss of life an heart massage.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If the causality is just unconscious, then once removed from water, he should be placed in the Recovery Position.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet A doctor or an ambulance should be sent for immediately.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("10. "+emergencies[9]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Poisons are substances or gases which when taken into the body in sufficient quantity will harm or destroy life. They can enter the body in three ways:\n"
                              "$bullet Through the lungs.\n"
                              "$bullet Through the skin.\n"
                              "$bullet By mouth.\n"
                          ,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Cautions",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Never leave tablets or medicines within reach of children.\n Keep them in a locked cabinet,"
                          " well out of reach (e.g. on top of a wardrobe).",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never store tablets or medicines for long periods.\n"
                          "They deteriorate and any surplus at the end of a course of "
                          "treatment should be returned to the supplier (chemist or doctor) "
                          "or flushed down the lavatory.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never take drugs in the dark--- always read the label before taking or giving medicine..",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never pour harmful liquids into lemonade or other drink bottles.\n"
                          "Children will recognize the bottle and drink the contents.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never keep domestic cleaners and detergents under the sink where toddlers can"
                          " find them.\n(By the way, bleach and lavatory cleaners when mixed together do not produce a cleaner lavatory, but do produce a toxic gas which if inhaled is poisonous.).",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never make a casualty vomit: never give large quantities of salt water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never give anything by mouth (unless the mouth is burnt and the casualty is conscious).",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never attempt to give anything by mouth if casualty is unconscious.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never wait for a casualty who has swallowed a petroleum preparation to vomit: casualty should be put in the Recovery Position from the beginning, with head lower than heart.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Never give or take any tablets, especially sleeping tablets, with alcohol--- the combination may be fatal.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Common Poisons",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Berries and seeds.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Fungi: toadstools.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Decomposing food.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Strong chemicals: paraffin, petrol bleaches, weed killers, chemical fertilizers.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Medicines: aspirin, sleeping tablets, tranquilizers, iron tablets.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Animal bait: rat and mouse poisons.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Alcohol.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Green potatoes. (It is not generally appreciated how dangerous green potatoes can be. They can cause colic, vomiting and eventually diarrhea, possibly followed by collapse.).",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("General Treatment",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet The casualty may be conscious or unconscious,"
                          " and if the former, may be able to help somewhat with your task.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet While casualty is conscious try to discover what has been swallowed, how much, and when.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet If there are any tablets, empty bottles or cartons near the casualty,"
                          " keep them for examination in hospital. This may help to identify the poison swallowed.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Examine the casualty’s mouth.\n If there is evidence of burning and the casualty can swallow give him as much milk or water as he can drink.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Should the casualty vomit--- catch the vomit in a dish or polythene bag and keep for examination in hospital. Again it may help in identifying the poison swallowed.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Get the casualty to hospital as quickly as possible.\n"
                          "If the casualty is unconscious or becomes unconscious while in your care.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Poisoning through the skin",textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontSize: 22,
                              color: Colors.purple
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 10,right: 10),child: Text(
                      "Today many pesticides, especially those used by nursery men and farmers, may contain potent chemicals (eg malathion) which, if they come in contact with the skin, are capable of being taken into the body, with disastrous results.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Clues",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Known contact or contamination with a pesticide.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Development of shivering, twitching and fits.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Casualty gradually becomes unconscious.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Care",textAlign: TextAlign.center,
                          style: GoogleFonts.akayaTelivigala(
                              fontSize: 22,
                              color: Colors.pink
                          ),),),
                    ),

                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Wash the contaminated area thoroughly with cold water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Carefully remove any contaminated clothing, taking care not to touch the chemical yourself..",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Reassure the casualty, lie him down and encourage him to stay still and quiet.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Arrange for transfer to hospital as soon as possible.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),
                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Keep the casualty cool; apply cold pad to the forehead and sponge back of neck, spine and body with cold water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),
                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Encourage casualty to drink as much cool fluid as possible.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),
                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Watch for twitching and fits developing.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),
                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet If casualty becomes unconscious, check breathing and place casualty in the Recovery Position.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),
                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Always keep the poison container.\nIt may have notes for treatment, but it is also important for your doctor to see it.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("11. "+emergencies[10]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Follow these steps to keep cuts clean and prevent infections and scar\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Wash your hands.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "First, wash up with soap and water so you don’t get bacteria into the cut and cause an infection."
                              " If you’re on the go, use hand sanitizer.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Stop the bleeding.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Put pressure on the cut with a gauze pad or clean cloth."
                              " Keep the pressure on for a few minutes.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Clean the wound.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Once you’ve stopped the bleeding, rinse the cut under cool running water or use a saline wound wash."
                              "Clean the area around the wound with soap and a wet washcloth."
                              " Don’t get soap in the cut, because it can irritate the skin."
                              " And don’t use hydrogen peroxide or iodine, which could irritate the cut.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Remove any dirt or debris.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Use a pair of tweezers cleaned with alcohol to gently pick out any dirt,"
                              " gravel, glass, or other material in the cut.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 30,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet Do I need to bandage a cut or scrape?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "You don’t need to bandage every cut and scrape."
                              " Some heal more quickly when left uncovered to stay dry."
                              " But if the cut is on a part of the body that might get dirty or rub against clothes,"
                              " put on a bandage to protect it. Change the bandage every day or whenever it gets wet or dirty.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How long should a cut or scrape be covered?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Once a solid scab has formed, you can take off the bandage.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet When do you need to call a doctor?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "$bullet if The cut is deep, long, or the edges are jagged, You may need stitches and a tetanus shot.\n"
                              "$bullet if The cut or scrape is from a dirty or rusty object. You may need a tetanus shot.\n"
                              "$bullet if The injury is from an animal or human bite.\n"
                              "$bullet if You can’t stop the bleeding with direct pressure.\n"
                              "$bullet if You can’t get dirt out of the wound.\n"
                              "$bullet if The cut is on your face or near a joint, like on your fingers.\n"
                              "$bullet if The skin around the cut gets red and swollen or develops red streaks.\n"
                              "$bullet if Pus drains from the cut.\n"
                              "$bullet if You have a fever of more than 100.4 F (in either an adult or child).\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),



                    SizedBox(height: 30,),

                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("12. "+emergencies[11]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "A sprain is a stretch or tear of a ligament,"
                              " the tough tissue that connects bones and supports the joints."
                              " You’re most likely to get a sprain in the wrist or ankle. Sprains cause pain, "
                              "bruising, and swelling. You may have trouble moving the joint.\n\n"
                              "A strain is an injury to a muscle or tendon,"
                              " the thick tissue that attaches muscles to bones. "
                              "You’re most likely to get a strain in your back or hamstring muscles. "
                              "Strains cause pain, weakness, swelling, and muscle cramps. You may have trouble moving the muscle.\n\n"
                              "Follow these steps to treat Strains and Sprains\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Rest the limb to give it a chance to heal.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Hold ice on the area for 20 minutes at a time,"
                          " four to eight times a day, to bring down swelling."
                          " Don’t use heat -- it could make the area swell even more.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Wrap an elastic bandage or splint around the sprain or strain.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Put a pillow under the injured body part to keep it raised.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Take over-the-counter medicines such as ibuprofen to relieve the pain.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 30,),

                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("13. "+emergencies[12]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Nosebleeds usually look a lot worse than they are. Most of the time you can stop the flow with a few simple steps:\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Lean the head slightly forward, so blood doesn’t run down the throat.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet With a tissue or washcloth, gently press the nostrils together to stop the bleeding.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Hold the nose for at least 5 minutes. Then check to see if the bleeding has stopped. If it hasn’t stopped, gently squeeze for another 10 minutes.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Urgent in the following cases you must see a doctor",textAlign: TextAlign.center,style: GoogleFonts.aladin(
                            fontSize: 22
                        ),),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet The bleeding hasn’t stopped after 15 to 20 minutes or keeps starting again.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet The bleeding is fast and there’s a lot of blood.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet The bleeding is from an injury to your nose or face.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet You feel faint or weak.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 30,),


                  ],
                ),
              ),
            )

            ),
        ),
      ),


      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("14. "+emergencies[13]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Splinters are more of an annoyance than real health problem, but if you’ve got one stuck in a finger or toe,"
                              " you’ll want to get it out. How you remove a splinter depends on how deep it is.\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("If the splinter is sticking out of the skin:",textAlign: TextAlign.center,style: GoogleFonts.aladin(
                            fontSize: 22,
                            color: Colors.pink
                        ),),
                      ),
                    ),


                    SizedBox(height: 20,),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Wash the skin around the splinter with soap and water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Clean a pair of tweezers with a cotton swab dipped in alcohol.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Grab the end of the splinter with the tweezers.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Pull it out at the same angle as the splinter went in.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Clean the skin again with soap and water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("If the splinter is under the skin:",textAlign: TextAlign.center,style: GoogleFonts.aladin(
                            fontSize: 22,
                            color: Colors.pink
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Wash the skin around the splinter with soap and water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Clean a needle and tweezers with alcohol.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Gently scrape away the skin above the splinter with the needle until you can see the top of the splinter.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Grab the end of the splinter with the tweezers and pull it out at the same angle it went in.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Clean the skin again with soap and water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 30,),


                  ],
                ),
              ),
            )

            ),
        ),
      ),


      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("15. "+emergencies[14]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "For any animal bite, you may need an antibiotic to prevent infection."
                              " So it’s always a good idea to call your doctor,"
                              " especially if you have medical conditions that weaken your immune system."
                              " Also, you should call your doctor or head to the emergency room if:\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet The bite was caused by an animal you don’t know,"
                          " or by any wild animal like a raccoon, skunk, or bat. You may need a tetanus or rabies vaccine.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.purple,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet The bite is large, or it doesn’t stop bleeding after you’ve held pressure on it for 15 minutes. It may need to be closed with stitches.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.purple,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet You think the bite may have damaged a bone, tendons, or nerves, because you can’t bend or straighten the body part or you’ve lost feeling in it.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.purple,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet The wound is red, swollen, or oozing fluid.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.purple,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),child:
                      Text("Other than these symtoms follow these steps:",textAlign: TextAlign.center,style: GoogleFonts.akayaTelivigala(
                          fontSize: 22,
                          color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                      ),),),
                    ),

                    SizedBox(height: 20,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Hold a towel or gauze to the area to stop the bleeding.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Clean the wound with soap and water.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet Cover it with a clean bandage or gauze pad.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),


                    SizedBox(height: 30,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How do I treat bee, wasp, and other insect stings?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "$bullet If the insect has left behind a stinger,"
                              " remove it from the skin so less of the venom gets into your body."
                              " You can scrape out the stinger with the edge of a credit card or the dull edge of a knife."
                              " Don’t squeeze the stinger. You might release more of the venom into your skin.\n"
                              "$bullet Once the stinger is out or if there is no stinger, wash the area around the sting with soap and water.\n"
                              "$bullet Hold an ice pack or cool washcloth to the sting to stop it from swelling.\n"
                              "$bullet Spread calamine lotion or baking soda mixed with water to relieve pain.\n"
                              "$bullet To prevent itching, use a spray or cream containing hydrocortisone or antihistamine.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How do I treat a mosquito bite?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "$bullet Apply firm pressure to the bite for 10 seconds to help stop the itch.\n"
                              "$bullet Use a baking soda paste or hydrocortisone cream 4 times a day to relieve itching. Don’t have either on hand? Holding ice or a wet washcloth on the bite will also help.\n"
                              "$bullet Take an antihistamine if the bite is very itchy.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet What are the signs that a child is allergic to the insect?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Text(
                        "Anyone who has allergies to bees, wasps, or other stinging insects should keep an "
                            "epinephrine auto-injector at home, work, and school in case of a sting.\n"
                            "Call 911 or go to the emergency room if you see any of these signs of an allergic reaction",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.akayaTelivigala(
                          color: Colors.pink.shade400,
                          fontSize: 22,
                        ),
                      ),),
                    ),

                    SizedBox(height: 20,),


                    Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                      "$bullet Dizziness.\n"
                          "$bullet Hives -- red, itchy bumps on the skin.\n"
                          "$bullet Stomach cramps, vomiting, or diarrhea.\n"
                          "$bullet Swelling of the tongue.\n"
                          "$bullet Trouble breathing, wheezing.\n"
                      ,style: GoogleFonts.actor(
                        fontSize: 16,
                        color: Colors.pink,
                        fontWeight: FontWeight.w400

                    ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How do I treat a spider bite?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "For most of the harmless types of spiders you’ll find at home,"
                              " treatment is pretty simple:\n"
                              "$bullet Wash the area with soap and water.\n"
                              "$bullet Hold an ice pack or cool washcloth to the bite to relieve pain and bring down swelling.\n"
                          ,textAlign: TextAlign.center,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How do you know if a spider is poisonous?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Spiders might be creepy and crawly, but most of them aren’t poisonous."
                              " The poisonous spiders to watch out for are the brown recluse and black widow. Here’s how to spot them:\n"
                              "$bullet Brown recluse spiders are about 1/2-inch long."
                              " They’re brown and have a mark in the shape of a violin on their back.\n"
                              "$bullet Black widow spiders are black with a red hourglass-shaped mark on their stomach.\n"
                          ,textAlign: TextAlign.center,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),


                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet What should I do for a poisonous spider bite?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "If you think you were bitten by a poisonous spider like a brown recluse or black widow,"
                              " call 911 or go to the emergency room right away. Look for these signs:\n"
                              "$bullet A red or purple color around the bite.\n"
                              "$bullet Pain in the bite area.\n"
                              "$bullet Swelling around the bite.\n"
                              "$bullet Muscle pain and cramps.\n"
                              "$bullet Fever.\n"
                              "$bullet Chills.\n"
                              "$bullet Rash.\n"
                              "$bullet Stomach pain.\n"
                              "$bullet Nausea and vomiting.\n"
                              "$bullet Trouble breathing.\n"
                          ,textAlign: TextAlign.start,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),




                    SizedBox(height: 30,),

                  ],
                ),
              ),
            )

            ),
        ),
      ),


      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("16. "+emergencies[15]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "When you get a burn, first check to see which type it is. Some are more serious than others:\n"
                              "$bullet First-degree burns are painful but minor. They turn red and may swell.\n"
                              "$bullet Second-degree burns form blisters. The skin may be very red and painful.\n"
                              "$bullet Third-degree burns make the skin look white or charred."
                              " The burns may not hurt because nerves have been damaged.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),


                    SizedBox(height: 15,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet When should you see a doctor?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Serious burns need to be treated by a doctor or in a hospital. Call for medical help if:\n"
                              "$bullet You have a third-degree burn.\n"
                              "$bullet The burn is larger than 2 to 3 inches.\n"
                              "$bullet The burn is on your face, hands, feet, or over a joint like your shoulder or knee.\n"
                              "$bullet The burn goes all the way around a hand, arm, foot, or leg.\n"
                              "$bullet The pain gets worse instead of better.\n"
                              "$bullet The burn was caused by electricity or a chemical.\n"
                              "$bullet You see fluid or pus oozing from the burn.\n"
                          ,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How do you treat burns?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "You can treat minor first-degree burns and small second-degree burns at home."
                              " Here’s what to do:\n"
                              "$bullet Place the burned area under running cool water for at least 5 minutes to reduce swelling.\n"
                              "$bullet Apply an antiseptic spray, antibiotic ointment, or aloe vera cream to soothe the area.\n"
                              "$bullet Loosely wrap a gauze bandage around the burn.\n"
                              "$bullet To relieve pain, take acetaminophen, ibuprofen, or naproxen.\n"
                          ,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How do you treat a sunburn?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "$bullet Always wear sunscreen when you’re outdoors to protect your skin from the sun."
                              " If you stay outside for too long without protection, you can get a red, "
                              "itchy burn that may blister. As soon as you spot a sunburn, head inside to treat it.\n"
                              "$bullet Soothe your burned skin with a cool, damp washcloth. Or take a cool shower or bath. "
                              "Pat your skin dry afterward. Be gentle -- your sunburn may be sore.\n"
                              "$bullet Apply an aloe vera lotion. Or use a hydrocortisone cream to relieve the itch. Do not use lotions that contain petroleum, "
                              "benzocaine, or lidocaine. These ingredients can irritate the skin even more.\n"
                              "$bullet If the sunburn is really sore, take acetaminophen, "
                              "ibuprofen, or naproxen to relieve the pain.\n"
                              "$bullet A sunburn can dry out your body. Drink extra water so you won’t get dehydrated.\n"
                              "$bullet Give your sunburn time to heal. Cover your burned skin with clothing and a hat to protect it when you go outside.\n"
                              "$bullet See a doctor if you have blisters on the sunburn, or you get a fever or chills. Don’t pop the blisters. They could get infected...\n"
                          ,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),



                    SizedBox(height: 30,),

                  ],
                ),
              ),
            )

            ),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Obx(()=>
            ExpandablePanel(
                theme: ExpandableThemeData(
                    iconColor: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
                ),
                header: Text("17. "+emergencies[16]+".",style: GoogleFonts.lato(
                    fontSize: 22, color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                    fontWeight: FontWeight.w600
                ),),
                collapsed: Container(
                  width: 0,
                  height: 0,
                ), expanded: SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                child: ListView(
                  children: [

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "When you touch poison ivy -- or poison oak or sumac -- "
                              "the rash that appears on your skin is caused by an oil in the plant."
                              " The rash may itch and blister. But it should go away on its own within a few weeks.\n",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 15,),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "\n$bullet $bullet How do I treat a rash from poison ivy or other poisonous plants?",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    SizedBox(height: 10,),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Treat the rash and itch at home with these steps:\n"
                          ,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Wash your Skin.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "To get as much of the oil off as possible, clean your skin with soap and lukewarm water.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Wash everything.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Clean anything the plant touched -- your clothes, gardening tools, even your pet."
                              " The oil can stick to these objects and cause a rash if you touch them again.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Bathe in oatmeal.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Run a warm bath and add some colloidal oatmeal or baking soda to ease the itch."
                              " You can also apply a cool, wet washcloth to your skin.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Apply calamine or hydrocortisone cream.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "These products will also relieve the itch. If creams and lotions aren’t enough to soothe itchy skin,"
                              " ask your doctor whether you should take an antihistamine or steroid medicine by mouth.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,right: 10),child: Text(
                      "$bullet Don’t scratch!.",style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400
                    ),
                    ),),

                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "Though the rash might itch, resist the urge to scratch or pick at the blisters. You could get an infection.",style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),

                    SizedBox(height: 20,),

                    Center(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Text(
                        "\n$bullet $bullet Go to the emergency room if you have:\n",textAlign: TextAlign.center,style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w400
                      ),
                      ),),
                    ),

                    SizedBox(height: 20,),


                    Obx(()=>
                        Padding(padding: EdgeInsets.only(left: 50,right: 10),child: Text(
                          "$bullet Trouble breathing or swallowing.\n"
                              "$bullet Rashes or blisters on a large part of your body, or on your face or genitals.\n"
                              "$bullet Swelling, especially of the eyes.\n"
                              "$bullet An itch you can’t relieve, no matter what medicine or lotion you use.\n"
                              "$bullet A fever over 100 F.\n"
                              "$bullet A rash that hasn’t gone away after a few weeks.\n"
                          ,style: GoogleFonts.actor(
                            fontSize: 16,
                            color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],
                            fontWeight: FontWeight.w400
                        ),
                        ),),
                    ),



                    SizedBox(height: 30,),

                  ],
                ),
              ),
            )

            ),
        ),
      ),



    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Obx(()=>
          searchController.isSearching.value==false? Text("Tips",style: GoogleFonts.lato(
            fontSize: 20,
              color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900]
          ),):SearchBarWidget(controller: textEditingController, themeController: themeController,),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(builder: (context){
          return Obx(()=>
             IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(CupertinoIcons.left_chevron,color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],)),
          );
        }),
        
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Obx(()=>
               IconButton(onPressed: (){
                  searchController.isSearching.value = !searchController.isSearching.value;
                  toNavigateTo=null;
                  setState((){
                  });
               },
                  icon: Icon(searchController.isSearching.value?CupertinoIcons.xmark: CupertinoIcons.search,color: themeController.isDarkModeEnabled.value?Colors.grey[100]:Colors.grey[900],)),
            ),
          )
        ],
        
      ),

      body: Center(
        child: toNavigateTo == null? ListView(
          children: getTheList()
        ):ListView(
          children: [
            getTheList()[toNavigateTo!+1]
            ]

        ),
      ),

    );
  }
}

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final ThemeController themeController;
  const SearchBarWidget({Key? key,required this.controller,required this.themeController}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            textInputAction: TextInputAction.search,
            autofocus: true,
            controller: widget.controller,
          decoration: InputDecoration(
            hintText: "Search...",
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: widget.themeController.isDarkModeEnabled.value==false
                    ? Colors.black
                    : Colors.white),
          ),
          style: TextStyle(
            color: widget.themeController.isDarkModeEnabled.value==false
                ? Colors.black
                : Colors.white,
            fontSize: 18.0,
          ),
          maxLines: 1,
          onChanged: (query)=> searchController.searchQuery.value=query,
          onSubmitted: (value) {
            print('Submitted: ${value}');
            if (value.isEmpty) {
              Fluttertoast.showToast(msg: 'Sorry, The field is empty',gravity: ToastGravity.BOTTOM,backgroundColor: Colors.blue,
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16,
              );
            } else{



            }
          },
        ),
        suggestionsCallback: (pattern){
          print("pattern $pattern");
          List<String> suggestions=[];
          emergencies.forEach((element) {
            if(element.toLowerCase().contains(pattern.toLowerCase())){
              suggestions.add(element);
            }
          });
          return suggestions;
          },
        itemBuilder: (context, suggestion) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            child: Text(suggestion.toString(),style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.blue
            ),),
          );
        },
        onSuggestionSelected: (suggestion) {

          print("selected ${suggestion}");
          toNavigateTo = emergencies.indexOf(suggestion.toString());
          print("toNavigateTo: $toNavigateTo");
          setState((){

          });
        },
      ),
    );
      /*TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      enableSuggestions: true,

      onSubmitted: (value) {
        print('Submitted: ${value}');
        if (value.isEmpty) {
          Fluttertoast.showToast(msg: 'Sorry, The field is empty',gravity: ToastGravity.BOTTOM,backgroundColor: Colors.blue,
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16,
          );
        } else{

        }
      },
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search...",
        border: InputBorder.none,
        hintStyle: TextStyle(
            color: themeController.isDarkModeEnabled.value==false
                ? Colors.black
                : Colors.white),
      ),
      style: TextStyle(
        color: themeController.isDarkModeEnabled.value==false
            ? Colors.black
            : Colors.white,
        fontSize: 18.0,
      ),
      maxLines: 1,
      onChanged: (query)=> searchController.searchQuery.value=query,
    );
    */
  }
}

