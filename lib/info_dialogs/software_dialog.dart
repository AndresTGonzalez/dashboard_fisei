import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:dashboard_fisei/forms/software_form.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:dashboard_fisei/services/software_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SoftwareDialog extends StatelessWidget {
  final int laboratoryId;
  final List<Software> softwares;

  const SoftwareDialog({
    required this.laboratoryId,
    required this.softwares,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SoftwareService(
        softwares: softwares,
      ),
      child: _Dialog(laboratoryId: laboratoryId),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({
    super.key,
    required this.laboratoryId,
  });

  final int laboratoryId;

  @override
  Widget build(BuildContext context) {
    final softwareService = Provider.of<SoftwareService>(context);
    return AlertDialog(
      title: Row(
        children: [
          const Text(
            'Software instalado',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Agregar',
            onPressed: () {
              softwareService.nombre = '';
              softwareService.version = '';
              softwareService.laboratoryId = laboratoryId;
              showDialog(
                context: context,
                builder: (context) {
                  return SoftwareForm(
                    softwareService: softwareService,
                    software: Software(
                      id: 0,
                      nombre: '',
                      version: '',
                    ),
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
                itemCount: softwareService.softwares.length,
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
                                softwareService.softwares[index].nombre,
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
                                softwareService.softwares[index].version,
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
                                softwareService.laboratoryId = laboratoryId;
                                softwareService.nombre =
                                    softwareService.softwares[index].nombre;
                                softwareService.version =
                                    softwareService.softwares[index].version;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SoftwareForm(
                                      softwareService: softwareService,
                                      software:
                                          softwareService.softwares[index],
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
                                          await softwareService.deleteSoftware(
                                            software: softwareService
                                                .softwares[index],
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
