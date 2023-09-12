import 'package:dashboard_fisei/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              onPressed: () {
                List<String> listaDeOpciones = [
                  "A",
                  "B",
                  "C",
                  "D",
                  "E",
                  "F",
                  "G"
                ];
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        'Agregar o editar Materia',
                        style: GoogleFonts.openSans(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                borderRadius: BorderRadius.circular(10),
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
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
                                  labelText: 'Carrera',
                                  labelStyle: GoogleFonts.openSans(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                items: listaDeOpciones
                                    .map((String opcion) => DropdownMenuItem(
                                          child: Text(opcion),
                                          value: opcion,
                                        ))
                                    .toList(),
                                onChanged: (_) {},
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
                    );
                  },
                );
              },
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
