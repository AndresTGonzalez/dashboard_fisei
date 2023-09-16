import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:dashboard_fisei/forms/software_form.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoftwareDialog extends StatelessWidget {
  final List<Software> softwares;

  const SoftwareDialog({
    required this.softwares,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SoftwareForm(
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
                itemCount: softwares.length,
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
                                softwares[index].nombre,
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
                                softwares[index].version,
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
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SoftwareForm(
                                      software: softwares[index],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              tooltip: 'Eliminar',
                              onPressed: () {},
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
