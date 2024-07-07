import 'package:cardi_care/model/user_model.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/keluarga_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/views/widgets/buttons.dart';
import 'package:cardi_care/views/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalisisHome extends StatefulWidget {
  const AnalisisHome({super.key});

  @override
  State<AnalisisHome> createState() => _AnalisisHomeState();
}

class _AnalisisHomeState extends State<AnalisisHome> {
  List<UserModel> userList = [];
  final TextEditingController searchController = TextEditingController();
  final AuthServices auth = Get.find<AuthServices>();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    String familyId = await auth.getKeluargaData().then((value) => value.uid);
    List<UserModel> users =
        await KeluargaServices().getUsersByKeluargaId(familyId);
    setState(() {
      userList = users;
    });
  }

  void searchUsers(String name) async {
    String familyId = await auth.getKeluargaData().then((value) => value.uid);
    List<UserModel> users =
        await KeluargaServices().searchUsersUnderKeluarga(familyId, name);
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        foregroundColor: whiteColor,
        title: Text(
          'Hasil Analisis',
          style: whiteText.copyWith(
            fontSize: 20,
            fontWeight: semibold,
          ),
        ),
      ),
      backgroundColor: pinkColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari nama pasien',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: redColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: CustomRedButton(
                    title: 'Cari',
                    onPressed: () {
                      searchUsers(searchController.text);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  UserModel user = userList[index];
                  return Column(
                    children: [
                      PasienListTile(
                        name: user.name,
                        email: user.email,
                        onTap: () {
                          Get.toNamed(Routes.keluargaAnalisisDetail,
                              arguments: user);
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
