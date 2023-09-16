import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:dashboard_fisei/services/laboratories_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*\
  Nombre - String :LISTO
  Edificio - Nombre - String  
  Piso - Nombre - String
  Proyector - Boolean
  Aire acondicionado - Boolean
  Cantidad PC - Int LISTO
  Capacidad - Int LISTO
 */

// ignore: must_be_immutable
class LaboratoryForm extends StatelessWidget {
  List<String> buildings = [
    'Edificio 1',
    'Edificio 2',
    'Edificio Ciencias Aplicadas'
  ];
  List<String> floors = [
    'Subsuelo',
    'Primero',
    'Segundo',
    'Tercero',
    'Cuarto',
    'Quinto',
    'Sexto',
    'Septimo'
  ];

  List<String> options = ['Si', 'No'];

  Aula aula;
  LaboratoriesService laboratoriesService;

  LaboratoryForm({
    required this.laboratoriesService,
    required this.aula,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        // 'Agregar o editar Laboratorio',
        aula.id == 0 ? 'Agregar laboratorio' : 'Editar laboratorio',
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
                  initialValue: aula.nombre,
                  onChanged: (value) {
                    laboratoriesService.nombre = value;
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
                    labelText: 'Laboratorio',
                    labelStyle: GoogleFonts.openSans(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      child: TextFormField(
                        initialValue: aula.cantidadPc.toString(),
                        onChanged: (value) {
                          laboratoriesService.cantidadPc = int.parse(value);
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
                          labelText: 'Cantidad de PC',
                          labelStyle: GoogleFonts.openSans(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      // height: 50,
                      child: TextFormField(
                        initialValue: aula.capacidad.toString(),
                        onChanged: (value) {
                          laboratoriesService.capacidad = int.parse(value);
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
                          labelText: 'Capacidad',
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
              const SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      child: DropdownButtonFormField(
                        value: aula.edificio,
                        items: buildings
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
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
                          laboratoriesService.edificio = value!;
                        },
                        decoration: _dropdownStyle('Edificio'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      // height: 50,
                      child: DropdownButtonFormField(
                        value: aula.piso,
                        items: floors
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
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
                          laboratoriesService.piso = value!;
                        },
                        decoration: _dropdownStyle('Piso'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      child: DropdownButtonFormField(
                        value: aula.aire,
                        items: options
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
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
                          laboratoriesService.aireAcondicionado = value!;
                        },
                        decoration: _dropdownStyle('Aire acondicionado'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      // height: 50,
                      child: DropdownButtonFormField(
                        value: aula.proyector,
                        items: options
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
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
                          laboratoriesService.proyector = value!;
                        },
                        decoration: _dropdownStyle('Proyector'),
                      ),
                    ),
                  ],
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
            if (aula.id == 0) {
              await laboratoriesService.addLaboratory(
                Aula(
                  nombre: laboratoriesService.nombre,
                  edificio: laboratoriesService.edificio,
                  piso: laboratoriesService.piso,
                  proyector: laboratoriesService.proyector,
                  aire: laboratoriesService.aireAcondicionado,
                  cantidadPc: laboratoriesService.cantidadPc,
                  capacidad: laboratoriesService.capacidad,
                ),
              );
              // Cerrar el dialogo
              Navigator.of(context).pop();
            } else {
              laboratoriesService.updateLaboratory(
                Aula(
                  id: aula.id,
                  nombre: laboratoriesService.nombre,
                  edificio: laboratoriesService.edificio,
                  piso: laboratoriesService.piso,
                  proyector: laboratoriesService.proyector,
                  aire: laboratoriesService.aireAcondicionado,
                  cantidadPc: laboratoriesService.cantidadPc,
                  capacidad: laboratoriesService.capacidad,
                ),
              );
              // Cerrar el dialogo
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

  InputDecoration _dropdownStyle(String label) {
    return InputDecoration(
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
      labelText: label,
      labelStyle: GoogleFonts.openSans(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}
