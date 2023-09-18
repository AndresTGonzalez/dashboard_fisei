import 'package:dashboard_fisei/constants/app_colors.dart';
import 'package:dashboard_fisei/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vine,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 450,
            height: 400,
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Bienvenido',
                    style: GoogleFonts.openSans(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
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
                            labelText: 'Correo electrónico',
                            labelStyle: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: TextFormField(
                          obscureText: true,
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
                            labelText: 'Contraseña',
                            labelStyle: GoogleFonts.openSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      // Boton de iniciar sesion
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () async {
                            // Navigator.pushReplacementNamed(
                            //     context, '/dashboard');
                            // await AuthProvider.createAccount();
                            await AuthProvider.signInWithMail(
                              emailAddress: 'adminredesfisei@uta.edu.ec',
                              password: 'AdminRedesFISEI2000',
                            );
                            await AuthProvider.testToken();
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          },
                          color: AppColors.vine,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Iniciar Sesión',
                            style: GoogleFonts.openSans(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
