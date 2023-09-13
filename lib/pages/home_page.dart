import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/forms/subjects_form.dart';
import 'package:dashboard_fisei/models/select_carrer.dart';
import 'package:dashboard_fisei/models/select_nivel.dart';
import 'package:dashboard_fisei/models/subjects.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
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

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: AppColors.black,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return _TeacherFormDialog();
                  },
                );
              },
              child: const Text(
                'Formulario de docentes',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: AppColors.black,
              onPressed: () {},
              child: const Text(
                'Formulario de materias',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: AppColors.black,
              onPressed: () {},
              child: const Text(
                'Formulario de laboratorio',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: AppColors.black,
              onPressed: () {},
              child: const Text(
                'Formulario de caracteristicas',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: AppColors.black,
              onPressed: () {},
              child: const Text(
                'Formulario de software',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TeacherFormDialog extends StatelessWidget {
  const _TeacherFormDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Agregar o editar Docente',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      scrollable: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
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
                  labelText: 'Cédula',
                  labelStyle: GoogleFonts.openSans(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
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
                  labelText: 'Nombre',
                  labelStyle: GoogleFonts.openSans(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
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
          onPressed: () {},
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
}
