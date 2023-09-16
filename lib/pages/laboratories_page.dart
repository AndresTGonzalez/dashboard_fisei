import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/forms/laboratory_form.dart';
import 'package:dashboard_fisei/info_dialogs/charactersitic_dialog.dart';
import 'package:dashboard_fisei/info_dialogs/software_dialog.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:dashboard_fisei/services/laboratories_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LaboratoriesPage extends StatelessWidget {
  const LaboratoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => LaboratoriesService(),
        child: const _Table(),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final laboratoriesService = Provider.of<LaboratoriesService>(context);
    return laboratoriesService.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.vine,
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _Search(laboratoriesService: laboratoriesService),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return LaboratoryForm(
                                aula: Aula(
                                  id: 0,
                                  nombre: '',
                                  cantidadPc: 0,
                                  capacidad: 0,
                                ),
                                laboratoriesService: laboratoriesService,
                              );
                            },
                          );
                        },
                        color: AppColors.vine,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          // color: AppColors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: AppColors.white,
                              ),
                              Text(
                                'Nuevo',
                                style: GoogleFonts.openSans(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                _DataTable(laboratoriesService: laboratoriesService),
              ],
            ),
          );
  }
}

class _Search extends StatelessWidget {
  const _Search({
    super.key,
    required this.laboratoriesService,
  });

  final LaboratoriesService laboratoriesService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged: (value) {
          laboratoriesService.search(value);
        },
        cursorColor: AppColors.vine,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Buscar',
          prefixIcon: Icon(
            Icons.search,
            size: 20,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.vine,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.vine,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class _DataTable extends StatelessWidget {
  const _DataTable({
    super.key,
    required this.laboratoriesService,
  });

  final LaboratoriesService laboratoriesService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: DataTable(
        showCheckboxColumn: false,
        columnSpacing: 20,
        headingTextStyle: GoogleFonts.openSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        dividerThickness: 0.2,
        dataTextStyle: GoogleFonts.openSans(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        columns: const [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Cantidad de PC')),
          DataColumn(label: Text('Capacidad')),
          DataColumn(label: Text('Acciones')),
        ],
        rows: [
          for (final laboratory in laboratoriesService.searchsLaboratories)
            DataRow(
              onSelectChanged: (value) {},
              cells: [
                DataCell(Text(laboratory.nombre!)),
                DataCell(Text(laboratory.cantidadPc.toString())),
                DataCell(Text(laboratory.capacidad.toString())),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Editar',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              laboratoriesService.nombre = laboratory.nombre!;
                              laboratoriesService.edificio =
                                  laboratory.edificio!;
                              laboratoriesService.piso = laboratory.piso!;
                              laboratoriesService.cantidadPc =
                                  laboratory.cantidadPc!;
                              laboratoriesService.capacidad =
                                  laboratory.capacidad!;
                              laboratoriesService.aireAcondicionado =
                                  laboratory.aire!;
                              laboratoriesService.proyector =
                                  laboratory.proyector!;
                              return LaboratoryForm(
                                aula: laboratory,
                                laboratoriesService: laboratoriesService,
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
                                    await laboratoriesService
                                        .deleteLaboratory(laboratory.id!);
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
                      IconButton(
                        tooltip: 'Software',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SoftwareDialog(
                                softwares: laboratory.softwares!,
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.developer_mode),
                      ),
                      IconButton(
                        tooltip: 'Características',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CharacteristicDialog(
                                caracteristicas: laboratory.caracteristicas!,
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.table_rows_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
