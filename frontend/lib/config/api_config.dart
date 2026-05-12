class ApiConfigUsers {
  static String baseUrl = "http://10.0.2.2:8000";
  static String prefix = 'usuarios';
  //baseUrl = "http://192.168.1.68:8000" cuando use telefono
  // static String baseUrl = 'http://10.0.2.2:8000'; CUANDO USE EMULADOR

  static String obtenerUsuario(String curp) => '$baseUrl/$prefix/$curp';
  static String obtenerUsuarios() => '$baseUrl/$prefix';
  static String actualizarUsuario(String curp) => "$baseUrl/$prefix/$curp";
  static String crearUsuario() => "$baseUrl/$prefix/register";
  static String iniciarSesion() => "$baseUrl/auth/login";
}

class ApiConfigCasas {
   static String baseUrl = "http://10.0.2.2:8000";
  static String prefix = 'casas';
  //baseUrl = "http://192.168.1.68:8000" cuando use telefono
  // static String baseUrl = 'http://10.0.2.2:8000'; CUANDO USE EMULADOR

  static String obtenerCasa(int id) => '$baseUrl/$prefix/$id';
  static String obtenerCasas({String? filtro}) => '$baseUrl/$prefix/';
  static String obtenerCasasFiltro({String? filtro,String? tipoFiltro}) => '$baseUrl/$prefix/$filtro/$tipoFiltro';
  static String actualizarCasa(int id) => "$baseUrl/$prefix/$id";
  static String crearCasa() => "$baseUrl/$prefix/register";

}

