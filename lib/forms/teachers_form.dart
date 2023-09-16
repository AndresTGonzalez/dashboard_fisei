import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/teacher.dart';
import 'package:dashboard_fisei/services/teacher_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherFormDialog extends StatelessWidget {
  final TeachersService teachersService;
  final Teacher teacher;

  TeacherFormDialog({
    super.key,
    required this.teachersService,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        // 'Agregar o editar Docente',
        teacher.id == 0 ? 'Agregar docente' : 'Editar docente',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      scrollable: true,
      content: Form(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  initialValue: teacher.cedula,
                  enabled: teacher.id == 0,
                  onChanged: (value) {
                    teachersService.cedula = value;
                  },
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
                  initialValue: teacher.nombre,
                  onChanged: (value) => teachersService.nombre = value,
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
              const SizedBox(height: 20),
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
            if (teacher.id == 0) {
              await teachersService.addTeacher(
                Teacher(
                  cedula: teachersService.cedula,
                  nombre: teachersService.nombre,
                  id: 0,
                ),
              );
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            } else {
              await teachersService.editTeacher(
                Teacher(
                  cedula: teachersService.cedula,
                  nombre: teachersService.nombre,
                  id: teacher.id,
                ),
              );
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
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
}
