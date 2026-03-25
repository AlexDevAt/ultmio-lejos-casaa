const email = ['@', '.com'];

class FormUsuarios {
  static bool validarTexto(String texto) {
    if (texto == null || texto.trim().isEmpty) {
      return false;
    }
    return true;
  }

  static bool validarEmail(String email) {
    if (email == null || email.trim().isEmpty) {
      return false;
    }
    if (!email.contains(email)) {
      return false;
    }
    return true;
  }

  static bool validarTelefon(String numero) {
    if (numero == null || numero.trim().isEmpty || numero.length > 10) {
      return false;
    }
    return true;
  }
}
