enum Roles { vendedor, comprador, ambos }

class Usuario {
  final String curp;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final Roles rol;
  final DateTime fechaRegistro;
  final String calle;
  final int numeroInterior;
  final String codigoPostal;
  final String municipio;
  final String ciudad;
  final String contrasenia;

  Usuario({
    required this.curp,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.rol,
    required this.fechaRegistro,
    required this.calle,
    required this.numeroInterior,
    required this.codigoPostal,
    required this.municipio,
    required this.ciudad, required this.contrasenia,
  });
}
