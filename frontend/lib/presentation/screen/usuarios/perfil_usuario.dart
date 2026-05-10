import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/presentation/widgets/icono_custom.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Perfil', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: _FotoPerfil()),
            SizedBox(height: 15),
            _CambiarFoto(),
            SizedBox(height: 20),

            _InfPersonal(),
            SizedBox(height: 20),

            _Direccion(),
            SizedBox(height: 20),
            _Rol(),
          ],
        ),
      ),
    );
  }
}

class _CardOpcion extends StatelessWidget {
  final String title;
  final Icon icon;
  final String subtitle;
  final bool grid;
  final bool editable;
  final bool useIcon;
  const _CardOpcion({
    this.grid = false,
    this.useIcon = true,
    this.editable = false,
    required this.title,
    required this.icon,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: grid ? 2 : null,
      child: TextField(
        readOnly: !editable,
        decoration: InputDecoration(
          suffixIcon: ((editable || grid)  && useIcon)
              ? Icon(Icons.edit_outlined)
              : null,
          prefixIconConstraints: BoxConstraints(minWidth: grid ? 20 : 40),
          label: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black38, fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: grid ? 13 : 14.5,
                ),
              ),
            ],
          ),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: grid ? null : icon,
        ),
      ),
    );
  }
}

class _Direccion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 15, // Softness of shadow
            spreadRadius: .2, // How much it spreads
            offset: Offset(2, 4), // X and Y offset
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF1B84B3),
                  size: 28,
                ),
                SizedBox(width: 5),
                Center(
                  child: Text(
                    'Direccion',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => (),
                  icon: Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
          _CardOpcion(
            title: 'Calle',
            useIcon: false,
            icon: Icon(Icons.home_outlined),
            subtitle: 'Calle palma',
            editable: true,
          ),
          Row(
            children: [
              Expanded(
                child: _CardOpcion(
                  title: 'Num interior',
            useIcon: false,
                  grid: true,
                  icon: Icon(Icons.home_outlined),
                  subtitle: 'Calle palma',
                ),
              ),

              Expanded(
                child: _CardOpcion(
                  title: 'Colonia',
            useIcon: false,
                  grid: true,
                  icon: Icon(Icons.home_outlined),
                  subtitle: 'Aguascalientes',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _CardOpcion(
                  title: 'Municipio',
            useIcon: false,
                  grid: true,
                  icon: Icon(Icons.home_outlined),
                  subtitle: 'Calle palma',
                ),
              ),

              Expanded(
                child: _CardOpcion(
                  title: 'CP',
            useIcon: false,
                  grid: true,
                  icon: Icon(Icons.home_outlined),
                  subtitle: 'Calle palma',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Rol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 15, // Softness of shadow
            spreadRadius: .2, // How much it spreads
            offset: Offset(2, 4), // X and Y offset
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(children: [Icon(Icons.work_outline_outlined)]),
        ],
      ),
    );
  }
}

class _InfPersonal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 15, // Softness of shadow
            spreadRadius: .2, // How much it spreads
            offset: Offset(2, 4), // X and Y offset
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.person_2_outlined,
                  color: Color(0xFF1B84B3),
                  size: 28,
                ),
                SizedBox(width: 5),
                Center(
                  child: Text(
                    'Informacion personal',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          _CardOpcion(
            title: 'Nombres',
            icon: Icon(Icons.person_2_outlined),
            subtitle: 'Alexis Mauricio',
            
          ),
          _CardOpcion(
            title: 'Apellido materno',
            icon: Icon(Icons.person_2_outlined),
            subtitle: 'Gonzalez',
          ),
          _CardOpcion(
            title: 'Apellido paterno',
            icon: Icon(Icons.person_2_outlined),
            subtitle: 'Cruz',
          ),
          _CardOpcion(
            title: 'CURP',
            icon: Icon(Icons.credit_card_outlined),
            subtitle: 'kjhfhdsjh28k',
          ),
          _CardOpcion(
            title: 'Correo',
            icon: Icon(Icons.email_outlined),
            editable: true,
            subtitle: 'fer7447@gmail.com',
          ),
          _CardOpcion(
            title: 'Telefono',
            editable: true,
            icon: Icon(Icons.phone_iphone_outlined),
            subtitle: '123123132',
          ),
        ],
      ),
    );
  }
}

class _FotoPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(child: Icon(Icons.person, size: 100)),
    );
  }
}

class _CambiarFoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: Colors.blue, width: 2),
      ),
      child: FloatingActionButton.extended(
        onPressed: () => (),
        label: Text(
          'Cambiar fotografia',
          style: TextStyle(
            color: Color(0xFF1B84B3),
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: Icon(Icons.file_upload_outlined, color: Color(0xFF1B84B3)),
        elevation: 0,
        backgroundColor: Colors.white,
      ), //TODO funcion foto
    );
  }
}
