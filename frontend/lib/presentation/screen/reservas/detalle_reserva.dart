import 'package:flutter/material.dart';
import 'package:lejos_de_casa_front/domain/entities/reserva.dart';


class BookingDetailScreen extends StatelessWidget {
  final Reserva reserva; // Recibimos el objeto completo directamente
  static String name = 'detalle_reserva_screen';

  const BookingDetailScreen({super.key, required this.reserva});

  // Helper para dar un formato estético a las fechas
  String _formatearFecha(DateTime fecha) {
    final meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    return "${fecha.day} ${meses[fecha.month - 1]}, ${fecha.year}";
  }

  // Calcula las noches de diferencia usando DateTime
  int _calcularNoches(DateTime inicio, DateTime fin) {
    return fin.difference(inicio).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final esActivo = reserva.estado.toLowerCase() == 'activo';
    final noches = _calcularNoches(reserva.fechaInicio, reserva.fechaFin);
    
    // Obtenemos los nombres del comprador o un fallback si viene nulo
    final nombreHuesped = reserva.comprador != null 
        ? "${reserva.comprador!.nombres} ${reserva.comprador!.apellidos}".trim()
        : "Huésped Registrado";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Fondo gris claro moderno
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Reserva #${reserva.id}",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // --- HERO CARD: ESTADO DE LA RESERVA ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: esActivo 
                    ? [const Color(0xFF0F9D58), const Color(0xFF4285F4)] // Degradado dinámico pro-arrendamiento
                    : [const Color(0xFFED213A), const Color(0xFF93291E)], // Degradado de cancelación
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: (esActivo ? const Color(0xFF0F9D58) : const Color(0xFFED213A)).withOpacity(0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Estado de tu Arrendamiento", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 4),
                      Text(
                        reserva.estado, 
                        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0.5)
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle
                    ),
                    child: Icon(
                      esActivo ? Icons.vpn_key_outlined : Icons.gavel_outlined, 
                      color: Colors.white, 
                      size: 28
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),

            // --- LÍNEA DE TIEMPO / PERIODO DE ESTANCIA ---
            const Text("Periodo de Estancia", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                ]
              ),
              child: Row(
                children: [
                  _buildDateColumn("Check-In", _formatearFecha(reserva.fechaInicio), Icons.login_rounded, Colors.green),
                  
                  // Línea conectora central
                  Expanded(
                    child: Column(
                      children: [
                        Text("$noches noches", style: TextStyle(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[200], thickness: 2, endIndent: 5)),
                            Icon(Icons.nightlight_round, size: 14, color: Colors.indigo[200]),
                            Expanded(child: Divider(color: Colors.grey[200], thickness: 2, indent: 5)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  _buildDateColumn("Check-Out", _formatearFecha(reserva.fechaFin), Icons.logout_rounded, Colors.redAccent),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // --- SECCIÓN: PERFIL EXPRESS DEL HUÉSPED ---
            const Text("Datos del Huésped", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                ]
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFF1F3F5),
                    child: Text(
                      nombreHuesped.substring(0, 1).toUpperCase(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombreHuesped,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "CURP: ${reserva.comprador?.curp ?? reserva.idComprador}",
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.verified_user_outlined, size: 20, color: Colors.blueAccent)
                ],
              ),
            ),
            const SizedBox(height: 25),

            // --- DETALLES DE VÍNCULO (CASA E IDENTIFICADORES) ---
            const Text("Detalles del Registro", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                ]
              ),
              child: Column(
                children: [
                  _buildSummaryRow("Identificador de Propiedad", "ID #${reserva.idCasa}", isBold: true),
                  const Divider(height: 24),
                  _buildSummaryRow("Ubicación Asociada", reserva.casa?.calle != null ? "Calle #${reserva.casa!.calle}" : "Consultar en Ficha"),
                  const Divider(height: 24),
                  _buildSummaryRow("Tipo de Alojamiento", reserva.casa?.tipo ?? "Propiedad Arrendada", isMuted: true),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- BOTONES DE INTERACCIÓN ---
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Acción para chat directo
                    },
                    icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.black),
                    label: const Text("Llamar/Mensaje", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Acción de administración directa
                    },
                    icon: const Icon(Icons.settings_outlined, color: Colors.white),
                    label: const Text("Modificar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDateColumn(String label, String date, IconData icon, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 15, color: iconColor),
            const SizedBox(width: 5),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        Text(date, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isBold = false, bool isMuted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: isMuted ? Colors.grey[400] : Colors.grey[700], fontSize: 14)),
        Text(
          value, 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isMuted ? Colors.grey[500] : Colors.black,
          )
        ),
      ],
    );
  }
}