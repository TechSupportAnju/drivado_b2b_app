import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'widgets/account_widget.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 110,
              color: Colors.white,
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0, left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.keyboard_backspace, color: Color(0xFF606060),)),
                    SizedBox(width: 16,),
                    CustomText(title: 'Account Setting', fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0D0D0D),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Colors.white, Colors.white),
                child: Column(
                  children: [
                    AccountPageHeader(
                      text: 'Notification',
                      image: 'assets/more/noti.svg',
                      isMore: true,
                    ),
                    SizedBox(height: 20,),
                    AccountPageHeader(
                      text: 'Delete Account',
                      image: 'assets/more/del.svg',
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}