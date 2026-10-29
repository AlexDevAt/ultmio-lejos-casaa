import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lejos_de_casa_front/domain/entities/casa.dart';

// --- SERVICIO DIO ---
class ReservaService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> obtenerReservaUrgente(int id) async {
  try {
    Response response = await _dio.get(
      'http://172.20.10.3:8000/reservas/casas/$id', // Usando la IP del emulador
    );

    if (response.statusCode == 200) {
      // 1. Recibimos la respuesta como una lista dinámica
      final listaReservas = response.data as List<dynamic>;
      
      // 2. Si la lista no está vacía, tomamos el primer elemento como el mapa que esperabas
      if (listaReservas.isNotEmpty) {
        return listaReservas.first as Map<String, dynamic>;
      }
      
      return null; // Lista vacía (La casa no tiene reservas)
    }
    return null;
  } catch (e) {
    print("Error al obtener la reserva: $e");
    return null;
  }
}
}

// --- WIDGET CONVERTIDO A STATEFUL ---
class PropertyDetailScreen extends StatefulWidget {
  final Casa casa;
  static String name = 'detallePropiedad_screen';

  const PropertyDetailScreen({super.key, required this.casa});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  late Future<Map<String, dynamic>?> _futureReserva;

  @override
  void initState() {
    super.initState();
    // Iniciamos la petición usando el ID de la casa que llegó por parámetros
    _futureReserva = ReservaService().obtenerReservaUrgente(widget.casa.id);
  }

  // Función auxiliar para limpiar el formato de fecha de la API (Saca solo el YYYY-MM-DD)
  String _formatearFecha(String? fecha) {
    if (fecha == null || fecha.isEmpty) return 'xxxx';
    try {
      return fecha.split('T')[0];
    } catch (_) {
      return fecha;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              "Informacion de la casa",
              style: TextStyle(
                  color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Casas de tu propiedad en arrendamiento",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _futureReserva,
        builder: (context, snapshot) {
          // 1. Mientras la API carga, muestra un spinner centrado
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }

          // Inicializamos variables por defecto por si no hay reserva activa en esa casa
          String estadoReserva = "Sin Reserva";
          Color estadoColor = Colors.orange;
          String fechaInicio = "xxxx";
          String fechaFin = "xxxx";
          String nombreHuesped = "Sin huésped asignado";

          // 2. Si la API respondió con éxito y trae data
          if (snapshot.hasData && snapshot.data != null) {
            final dataReserva = snapshot.data!;
            
            estadoReserva = dataReserva['estado'] ?? 'Activo';
            estadoColor = (estadoReserva.toLowerCase() == 'activo') ? Colors.green : Colors.red;
            
            fechaInicio = _formatearFecha(dataReserva['fecha_inicio']);
            fechaFin = _formatearFecha(dataReserva['fecha_fin']);

            // Mapeo del sub-diccionario del comprador
            final comprador = dataReserva['comprador'] as Map<String, dynamic>? ?? {};
            if (comprador.isNotEmpty) {
              nombreHuesped = "${comprador['nombres'] ?? ''} ${comprador['apellidos'] ?? ''}".trim();
            }
          }

          // Estructura principal clonada de tu diseño
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- IMAGEN PRINCIPAL ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/casas/${widget.casa.imagen}', // widget.casa
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 220,
                        color: Colors.grey[300],
                        child: const Icon(Icons.home_work, size: 50),
                      ),
                    ),
                  ),
                ),

                // --- HEADER (Título y Rating) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Casa ID :${widget.casa.id}",
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 22),
                          SizedBox(width: 4),
                          Text("4.1 (12)", style: TextStyle(fontSize: 18, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),

                // --- DIRECCIÓN (Fila de Ubicación) ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      _buildAddressChip(Icons.location_on_outlined, "Calle #${widget.casa.calle}"),
                      const SizedBox(width: 8),
                      _buildAddressChip(null, "Num exterior ${widget.casa.numInterior}"),
                      const SizedBox(width: 8),
                      _buildAddressChip(null, "${widget.casa.region?.municipio ?? 'N/A'}"),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Informacion del alojamiento:", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),

                // --- FORMULARIO DE DETALLES ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildEditableField(Icons.bed_outlined, "Numero de cuartos:", "${widget.casa.cuartos}"),
                      _buildEditableField(Icons.home_outlined, "Tipo", widget.casa.tipo),
                      _buildEditableField(Icons.person_outline, "Cupo", "${widget.casa.cupo}"),
                    ],
                  ),
                ),

                const Divider(indent: 20, endIndent: 20),

                // --- ESTADO Y PRECIO (Valores inyectados desde API) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                              children: [
                                const TextSpan(text: "Estado actual: "),
                                TextSpan(
                                  text: estadoReserva, 
                                  style: TextStyle(fontWeight: FontWeight.bold, color: estadoColor),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text("📅 Fecha inicio: $fechaInicio", style: const TextStyle(color: Colors.grey)),
                          Text("📅 Fecha fin: $fechaFin", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Precio Actual:", style: TextStyle(fontStyle: FontStyle.italic)),
                          Row(
                            children: [
                              Text("\$${widget.casa.precio}", 
                                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                              const Text("/ mo", style: TextStyle(fontSize: 16)),
                              const Icon(Icons.edit_note, size: 30),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // --- CHIP DE HUÉSPED (Dinámico desde API) ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        const Text("Huesped actual:", style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text(
                            nombreHuesped, 
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: snapshot.hasData ? () {} : null, // Deshabilitado si no hay data
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 10)
                          ),
                          child: const Text("Perfil", style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddressChip(IconData? icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildEditableField(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 15),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(label, style: const TextStyle(color: Colors.grey)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(value, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.edit_note, color: Colors.black),
        ],
      ),
    );
  }
}