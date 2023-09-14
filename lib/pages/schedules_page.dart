import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchedulesPage extends StatelessWidget {
  List<String> testOptions = [
    'Nivelación',
    'Primero',
    'Segundo',
    'Tercero',
    'Cuarto',
    'Quinto',
    'Sexto',
    'Septimo',
    'Octavo',
    'Noveno',
    'Decimo',
  ];

  SchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // color: AppColors.vine,
                    child: DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: _dropdownStyle(label: 'Docente'),
                      value: 'Nivelación',
                      items: testOptions.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      onPressed: () {},
                      color: AppColors.vine,
                      height: 40,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        // color: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: AppColors.white,
                            ),
                            Text(
                              'Nuevo',
                              style: GoogleFonts.openSans(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.bottom,
              trackVisibility: true,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 400, // Ancho de cada contenedor
                      color: Colors.red,
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      width: 400,
                      color: Colors.green,
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      width: 400,
                      color: Colors.blue,
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      width: 400,
                      color: Colors.yellow,
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      width: 400,
                      color: Colors.orange,
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownStyle({String? label}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.black,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      labelText: label,
      labelStyle: GoogleFonts.openSans(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}
