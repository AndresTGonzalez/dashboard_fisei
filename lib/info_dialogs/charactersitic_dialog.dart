import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:dashboard_fisei/forms/characteristics_form.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:dashboard_fisei/services/characteristic_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CharacteristicDialog extends StatelessWidget {
  final List<Caracteristica> caracteristicas;
  final int? laboratoryId;

  const CharacteristicDialog({
    required this.caracteristicas,
    required this.laboratoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharacteristicService(
        caracteristicas: caracteristicas,
      ),
      child: _Dialog(
        laboratoryId: laboratoryId,
      ),
    );
  }
}

class _Dialog extends StatelessWidget {
  final int? laboratoryId;

  const _Dialog({
    required this.laboratoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final characteristicService = Provider.of<CharacteristicService>(context);
    return AlertDialog(
      title: Row(
        children: [
          const Text(
            'Características',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              characteristicService.nombre = '';
              characteristicService.descripcion = '';
              showDialog(
                context: context,
                builder: (context) {
                  return CharacteristicsForm(
                    laboratoryId: laboratoryId,
                    caracteristica: Caracteristica(
                      id: 0,
                      nombre: '',
                      descripcion: '',
                    ),
                    characteristicService: characteristicService,
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: characteristicService.caracteristicas.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                characteristicService
                                    .caracteristicas[index].nombre,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                characteristicService
                                    .caracteristicas[index].descripcion,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                              tooltip: 'Editar',
                              onPressed: () {
                                characteristicService.nombre =
                                    characteristicService
                                        .caracteristicas[index].nombre;
                                characteristicService.descripcion =
                                    characteristicService
                                        .caracteristicas[index].descripcion;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CharacteristicsForm(
                                      laboratoryId: laboratoryId,
                                      caracteristica: characteristicService
                                          .caracteristicas[index],
                                      characteristicService:
                                          characteristicService,
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              tooltip: 'Eliminar',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Eliminar'),
                                    content: const Text(
                                        '¿Está seguro que desea eliminar este laboratorio?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await characteristicService
                                              .deleteCharacteristic(
                                            characteristicId:
                                                characteristicService
                                                    .caracteristicas[index].id,
                                          );
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).pop();
                                        },
                                        color: AppColors.vine,
                                        child: const Text(
                                          'Eliminar',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cerrar',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
