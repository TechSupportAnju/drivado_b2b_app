import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

showDeleteDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, newState) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 363,
            decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Color(0xFFF5F6FA), Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(title: 'Delete Account', color: Color(0xFF606060), fontWeight: FontWeight.w500, fontSize: 14),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:SvgPicture.asset('assets/more/close-circle.svg')),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Colors.white, Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          SizedBox(height: 16,),
                          SvgPicture.asset('assets/more/delPopupAlert.svg'),
                          SizedBox(height: 16,),
                          CustomText(title: 'Are you sure ?\nyou want to delete your account',
                              height: 1.4,
                              textAlign: TextAlign.center,
                              color: Color(0xFF0D0D0D), fontWeight: FontWeight.w500, fontSize: 16),
                          SizedBox(height: 16),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: CustomDecorationsCards().baseBackgroundShadow(
                                radius: 8.0,
                                smooth: 1.0,
                                color: Color(0xffFFF0F1),
                                width: 0.50,
                                borderColor: Color(0xFFDC3545).withOpacity(0.5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        title: 'This action cannot be undone. Deleting your\naccount will:',
                                        color: const Color(0xFF4F0214),
                                        fontSize: 12,
                                        height: 1.4,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      CustomText(title: "•  Will permanently delete all your data",
                                          height: 1.2,
                                          color: const Color(0xFF4F0214), fontWeight: FontWeight.w400, fontSize: 10),
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      CustomText(title: "•  Remove access to your account",
                                          height: 1.2,
                                          color: const Color(0xFF4F0214), fontWeight: FontWeight.w400, fontSize: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 44,
                                    decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.secondary, AppColors.secondary),
                                    alignment: Alignment.center,
                                    child: CustomText(title: 'Keep,Stay', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16,),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    var selectedIndex = -1;
                                    List<Map<String, dynamic>> items = [
                                      {"title": "Too expensive"},
                                      {"title": "Privacy concerns"},
                                      {"title": "I found a better alternative"},
                                      {"title": "No longer need this service"},
                                      {"title": "Poor customer service"},
                                      {"title": "Technical issues"},
                                      {"title": "Other"},
                                    ];
                                    TextEditingController otherReason = TextEditingController();
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                              builder: (BuildContext context, StateSetter setModalState) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      decoration: CustomDecorations().draggableSheetDecoration(20.0, 20.0, 0.0, 0.0, 1.0, Colors.white, Colors.white),
                                                      height: MediaQuery.of(context).size.height/1.05,
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                        child: ListView(
                                                          children: <Widget>[
                                                            SizedBox(height: 40,),
                                                            Row(
                                                              children: [
                                                                CustomText(title: 'Tell us why', color: Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 20),
                                                                Spacer(),
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child:SvgPicture.asset('assets/more/close-circle.svg')),
                                                              ],
                                                            ),
                                                            SizedBox(height: 8,),
                                                            Row(
                                                              children: [
                                                                Expanded(child: CustomText(title: 'Help us improve by letting us know why you\'re leaving:', color: Color(0xFF606060), fontWeight: FontWeight.w400, fontSize: 14)),
                                                              ],
                                                            ),
                                                            SizedBox(height: 18,),
                                                            ListView.builder(
                                                                shrinkWrap: true,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                padding: EdgeInsets.zero,
                                                                itemCount: items.length,
                                                                itemBuilder: (context, index) {
                                                                  return GestureDetector(
                                                                    behavior: HitTestBehavior.translucent,
                                                                    onTap: () {
                                                                      setModalState(() {
                                                                        selectedIndex = index;
                                                                      });
                                                                    },
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                                                                          decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, selectedIndex == index ? Color(0xffFFF0F1) : Colors.white, selectedIndex == index ? AppColors.secondary : Color(0xFFE6E8E7), width: 0.5),
                                                                          height: 40,
                                                                          // padding: EdgeInsets.symmetric(vertical: 12),
                                                                          child: Row(
                                                                            children: [
                                                                              SizedBox(width: 12,),
                                                                              SvgPicture.asset(selectedIndex == index ? 'assets/more/radioCheck.svg' : 'assets/more/radioUncheck.svg'),
                                                                              SizedBox(width: 8,),
                                                                              CustomText(title: '${items[index]['title']}', color: Color(0xFF606060), fontWeight: FontWeight.w400, fontSize: 12),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(height:  items[index]['title'] == 'Other' && selectedIndex == 6 ? 12 : 0,),
                                                                        items[index]['title'] == 'Other' && selectedIndex == 6
                                                                            ? SingleChildScrollView(
                                                                          child: Container(
                                                                            height: 100,
                                                                            decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0xFFE6E8E7)),
                                                                            padding: EdgeInsets.symmetric(horizontal: 12),
                                                                            child: TextField(
                                                                              controller: otherReason,
                                                                              maxLines: 4,
                                                                              minLines: 4,
                                                                              cursorHeight: 15,
                                                                              style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF606060)),
                                                                              decoration: InputDecoration(
                                                                                alignLabelWithHint: true, // Aligns the label to the top for multiline fields
                                                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                hintText: 'Please tell us more...',
                                                                                hintStyle: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF606060)),
                                                                                border: InputBorder.none, // Adds a standard border around the field
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                            : Container(
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            SizedBox(height: 24,),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              decoration: CustomDecorationsCards().baseBackgroundShadow(
                                                                  radius: 8.0,
                                                                  smooth: 1.0,
                                                                  color: const Color(0xFFFEFFF0),
                                                                  width: 0.50,
                                                                  borderColor: const Color(0xFFFFA800)
                                                                //boxShadowColor:  Color(0x19000000),
                                                                // blurRadius: 0.0,
                                                                // x: 0, y: 0
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  spacing: 10,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            SvgPicture.asset("assets/more/alertYellow.svg"),
                                                                            SizedBox(width: 6,),
                                                                            CustomText(
                                                                              title: 'Last chance to change your mind',
                                                                              color: const Color(0xFFFFA800),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 8,),
                                                                        Row(
                                                                          children: [
                                                                            CustomText(title: "Once you click 'Delete Account', all your data will be permanently\nremoved and cannot be recovered.",
                                                                                height: 1.4,
                                                                                color: const Color(0xFFAF7600), fontWeight: FontWeight.w500, fontSize: 10),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 12,),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              decoration: CustomDecorationsCards().baseBackgroundShadow(
                                                                  radius: 8.0,
                                                                  smooth: 1.0,
                                                                  color: Color(0xffFFF0F1),
                                                                  width: 0.50,
                                                                  borderColor: Color(0xFFDC3545).withOpacity(0.5)
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        CustomText(
                                                                          title: 'What will be deleted:',
                                                                          color: const Color(0xFF4F0214),
                                                                          fontSize: 12,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 8,),
                                                                    Row(
                                                                      children: [
                                                                        CustomText(title: "•  Will permanently delete all your data",
                                                                            height: 1.2,
                                                                            color: const Color(0xFF4F0214), fontWeight: FontWeight.w400, fontSize: 10),
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 4,),
                                                                    Row(
                                                                      children: [
                                                                        CustomText(title: "•  Remove access to your account",
                                                                            height: 1.2,
                                                                            color: const Color(0xFF4F0214), fontWeight: FontWeight.w400, fontSize: 10),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 24,),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child: Container(
                                                                        height: 44,
                                                                        decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, Colors.white, Color(0xFF606060), width: 0.5),
                                                                        alignment: Alignment.center,
                                                                        child: CustomText(title: 'Cancel', color: Color(0xFF606060), fontWeight: FontWeight.w500, fontSize: 12),
                                                                      ),
                                                                    )),
                                                                SizedBox(width: 16,),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:   GestureDetector(
                                                                    onTap: () {

                                                                    },
                                                                    child: Container(
                                                                      height: 44,
                                                                      decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, selectedIndex == -1 ? AppColors.secondary.withOpacity(0.5) : AppColors.secondary, selectedIndex == -1 ? AppColors.secondary.withOpacity(0.5) : AppColors.secondary, width: 0.5),
                                                                      alignment: Alignment.center,
                                                                      child: CustomText(title: 'Delete Account', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(height: 24,),

                                                          ],
                                                        ),                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                          );});
                                  },
                                  child: Container(
                                    height: 44,
                                    decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, Colors.white, Color(0xFF606060)),
                                    alignment: Alignment.center,
                                    child: CustomText(title: 'Continue', color: Color(0xFF606060), fontWeight: FontWeight.w500, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
    },
  );
}