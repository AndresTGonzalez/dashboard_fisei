import 'package:dashboard_fisei/models/select_carrer.dart';
import 'package:dashboard_fisei/models/select_nivel.dart';
import 'package:dashboard_fisei/models/subjects.dart';
import 'package:dashboard_fisei/services/subjects_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class SubjectsForm extends StatelessWidget {
  List<SelectNivel> niveles = [
    SelectNivel(value: 'Nivelacion', nivel: 'Nivelación'),
    SelectNivel(value: 'Primero', nivel: 'Primero'),
    SelectNivel(value: 'Segundo', nivel: 'Segundo'),
    SelectNivel(value: 'Tercero', nivel: 'Tercero'),
    SelectNivel(value: 'Cuarto', nivel: 'Cuarto'),
    SelectNivel(value: 'Quinto', nivel: 'Quinto'),
    SelectNivel(value: 'Sexto', nivel: 'Sexto'),
    SelectNivel(value: 'Septimo', nivel: 'Septimo'),
    SelectNivel(value: 'Octavo', nivel: 'Octavo'),
    SelectNivel(value: 'Noveno', nivel: 'Noveno'),
    SelectNivel(value: 'Decimo', nivel: 'Decimo'),
  ];

  List<SelectCarrer> carreras = [
    SelectCarrer(id: 1, carrera: 'Software'),
    SelectCarrer(id: 2, carrera: 'Telecomunicaciones'),
    SelectCarrer(id: 3, carrera: 'Industrial'),
    SelectCarrer(id: 4, carrera: 'Robótica'),
    SelectCarrer(id: 5, carrera: 'TI'),
  ];

  final Materia materia;

  final SubjectsService subjectsService;

  SubjectsForm({
    super.key,
    required this.materia,
    required this.subjectsService,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        // 'Agregar o editar Materias',
        materia.id == 0 ? 'Agregar materia' : 'Editar materia',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      scrollable: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                initialValue: materia.nombre,
                onChanged: (value) => subjectsService.nombre = value,
                cursorColor: AppColors.black,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Materia',
                  labelStyle: GoogleFonts.openSans(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: materia.nivel,
                items: niveles
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.value,
                        child: Text(
                          e.nivel,
                          style: GoogleFonts.openSans(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  subjectsService.nivel = value!;
                },
                decoration: _dropdownStyle(
                  label: 'Nivel',
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: materia.idCarrera,
                items: carreras
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.carrera,
                          style: GoogleFonts.openSans(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  subjectsService.idCarrera = value!;
                },
                decoration: _dropdownStyle(
                  label: 'Carrera',
                ),
              ),
            ],
          ),
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
          onPressed: () async {
            if (materia.id == 0) {
              Materia materia = Materia(
                id: 0,
                nombre: subjectsService.nombre,
                nivel: subjectsService.nivel,
                idCarrera: subjectsService.idCarrera,
              );
              // Cerrar el dialog
              if (await subjectsService.addSubject(materia)) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al agregar la materia'),
                  ),
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
            } else {
              if (await subjectsService.updateSubject(
                Materia(
                  id: materia.id,
                  nombre: subjectsService.nombre,
                  nivel: subjectsService.nivel,
                  idCarrera: subjectsService.idCarrera,
                ),
              )) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al editar la materia'),
                  ),
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
              // Cerrar el dialog
            }
          },
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
