import 'package:dashboard_fisei/models/select_carrer.dart';
import 'package:dashboard_fisei/models/select_day.dart';
import 'package:dashboard_fisei/models/select_hour.dart';
import 'package:dashboard_fisei/models/select_parallel.dart';
import 'package:dashboard_fisei/models/select_teacher.dart';
import 'package:dashboard_fisei/services/select_laboratory_service.dart';
import 'package:dashboard_fisei/services/select_subject_service.dart';
import 'package:dashboard_fisei/services/select_teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class ScheduleForm extends StatelessWidget {
  ScheduleForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Agregar o editar Horarios',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      scrollable: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SelectTeacherService()),
            ChangeNotifierProvider(create: (_) => SelectLaboratoryService()),
            ChangeNotifierProvider(create: (_) => SelectSubjectService()),
          ],
          child: _Form(),
        ),
      ),
      actions: <Widget>[
        // Puedes agregar botones o acciones en el modal
        TextButton(
          child: Text(
            'Cerrar',
            style: GoogleFonts.openSans(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          onPressed: () {
            // Cierra el modal
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          onPressed: () async {},
          color: AppColors.green,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Guardar',
            style: GoogleFonts.openSans(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }

  InputDecoration _dropdownStyle({String? label}) {
    return InputDecoration(
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

class _Form extends StatefulWidget {
  _Form({super.key});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  bool enabled = false;
  bool puesto = false;
  int carrerId = 1;

  List<SelectDay> days = [
    SelectDay(value: 1, day: 'Lunes'),
    SelectDay(value: 2, day: 'Martes'),
    SelectDay(value: 3, day: 'Miercoles'),
    SelectDay(value: 4, day: 'Jueves'),
    SelectDay(value: 5, day: 'Viernes'),
    SelectDay(value: 6, day: 'Sabado'),
  ];

  List<SelectHour> hours = [
    SelectHour(value: '07:00', hour: '07H00'),
    SelectHour(value: '08:00', hour: '08H00'),
    SelectHour(value: '09:00', hour: '09H00'),
    SelectHour(value: '10:00', hour: '10H00'),
    SelectHour(value: '11:00', hour: '11H00'),
    SelectHour(value: '12:00', hour: '12H00'),
    SelectHour(value: '13:00', hour: '13H00'),
    SelectHour(value: '14:00', hour: '14H00'),
    SelectHour(value: '15:00', hour: '15H00'),
    SelectHour(value: '16:00', hour: '16H00'),
    SelectHour(value: '17:00', hour: '17H00'),
    SelectHour(value: '18:00', hour: '18H00'),
    SelectHour(value: '19:00', hour: '19H00'),
    SelectHour(value: '20:00', hour: '20H00'),
    SelectHour(value: '21:00', hour: '21H00')
  ];

  List<SelectParallel> parallels = [
    SelectParallel(value: 1, parallel: 'A'),
    SelectParallel(value: 2, parallel: 'B'),
    SelectParallel(value: 3, parallel: 'C'),
    SelectParallel(value: 4, parallel: 'D'),
  ];

  List<SelectCarrer> carreras = [
    SelectCarrer(id: 1, carrera: 'Software'),
    SelectCarrer(id: 2, carrera: 'Telecomunicaciones'),
    SelectCarrer(id: 3, carrera: 'Industrial'),
    SelectCarrer(id: 4, carrera: 'Robótica'),
    SelectCarrer(id: 5, carrera: 'TI'),
  ];

  InputDecoration _dropdownStyle({String? label}) {
    return InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    final selectTeacherService = Provider.of<SelectTeacherService>(context);
    final selectLaboratoryService =
        Provider.of<SelectLaboratoryService>(context);
    final selectSubjectService = Provider.of<SelectSubjectService>(context);
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.16,
                child: DropdownButtonFormField(
                  items: days
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(
                            e.day,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                  decoration: _dropdownStyle(label: 'Día'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.16,
                child: DropdownButtonFormField(
                  items: hours
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(
                            e.hour,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                  decoration: _dropdownStyle(label: 'Hora de inicio'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.16,
                child: DropdownButtonFormField(
                  items: hours
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(
                            e.hour,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                  decoration: _dropdownStyle(label: 'Hora de fin'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: DropdownButtonFormField(
                  items: carreras
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: SizedBox(
                              child: Text(
                                e.carrera,
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      carrerId = value as int;
                    });
                    setState(() {
                      enabled = true;
                    });
                    selectSubjectService.getSubjects(carrerId);
                  },
                  decoration: _dropdownStyle(label: 'Carrera'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: DropdownButtonFormField(
                  items: selectSubjectService.selectSubjects
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              e.subject,
                              style: GoogleFonts.openSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: enabled ? (value) {} : null,
                  decoration: _dropdownStyle(label: 'Materia'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: DropdownButtonFormField(
                  items: selectTeacherService.teachers
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            e.nombre,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                  decoration: _dropdownStyle(label: 'Docente'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: DropdownButtonFormField(
                  items: parallels
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(
                            e.parallel,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                  decoration: _dropdownStyle(label: 'Paralelo'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: DropdownButtonFormField(
                  items: selectLaboratoryService.selectLaboratories
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(
                            e.laboratory,
                            style: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                  decoration: _dropdownStyle(label: 'Laboratorio'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
              ),
            ],
          ),
          const SizedBox(height: 25),
          //Agregar una linea separadora
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 1,
            color: AppColors.black.withOpacity(0.2),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        puesto = !puesto;
                      });
                    },
                    color: puesto ? AppColors.vine : AppColors.green,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      puesto ? 'Deshabilitar puesto' : 'Habilitar puesto',
                      style: GoogleFonts.openSans(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: TextFormField(
                  enabled: puesto,
                  onChanged: (value) {},
                  decoration: _dropdownStyle(label: 'Puesto'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
