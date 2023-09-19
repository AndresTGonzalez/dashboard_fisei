import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:dashboard_fisei/services/characteristic_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacteristicsForm extends StatelessWidget {
  final Caracteristica caracteristica;
  final CharacteristicService characteristicService;
  final int? laboratoryId;

  const CharacteristicsForm({
    required this.characteristicService,
    required this.caracteristica,
    required this.laboratoryId,
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
        caracteristica.id == 0
            ? 'Agregar característica'
            : 'Editar característica',
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
                  initialValue: caracteristica.nombre,
                  onChanged: (value) {
                    characteristicService.nombre = value;
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
                  initialValue: caracteristica.descripcion,
                  onChanged: (value) =>
                      characteristicService.descripcion = value,
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
                    labelText: 'Descripción',
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
            if (caracteristica.id == 0) {
              if (await characteristicService.addCharacteristic(
                laboratoryId: laboratoryId,
              )) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ocurrió un error al agregar la característica',
                    ),
                  ),
                );
              }
            } else {
              if (await characteristicService.updateCharacteristic(
                characteristicId: caracteristica.id,
              )) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ocurrió un error al editar la característica',
                    ),
                  ),
                );
              }
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
