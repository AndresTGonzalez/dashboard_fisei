import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoftwareForm extends StatelessWidget {
  final Software software;

  const SoftwareForm({
    required this.software,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        // 'Agregar o editar Software',
        software.id == 0 ? 'Agregar software' : 'Editar software',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      scrollable: true,
      content: Form(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  initialValue: software.nombre,
                  onChanged: (value) {},
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextFormField(
                  initialValue: software.version,
                  // initialValue: teacher.nombre,
                  // onChanged: (value) => teachersService.nombre = value,
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
                    labelText: 'Versión',
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
}
