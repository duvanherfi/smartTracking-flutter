import 'package:flutter/material.dart';
import 'package:smart_tracking/base/view_model/base_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class StatusCard extends ViewModelWidget<BaseScreenViewModel> {
  double? speed;
  DateTime? lastUpdateTime; // Pasamos el DateTime para calcular la diferencia

  StatusCard({
    super.key,
    this.speed,
    this.lastUpdateTime,
  });

  @override
  Widget build(BuildContext context, BaseScreenViewModel viewModel) {
    final size = MediaQuery.of(context).size;
    final String updated = viewModel.formatRelativeTime(lastUpdateTime!);
    const Color textColor = Colors.white;
    const Color backgroundColor = Color(0xFF6A1B9A); // Un morado similar al de la imagen

    // Estilos de texto
    const TextStyle headerLabelStyle = TextStyle(
      color: textColor,
      fontSize: 16, // Ajusta según sea necesario
      fontWeight: FontWeight.w500,
    );
    const TextStyle mainValueStyle = TextStyle(
      color: textColor,
      fontSize: 40, // Tamaño grande para los números principales
      fontWeight: FontWeight.bold,
    );
    const TextStyle unitLabelStyle = TextStyle(
      color: textColor,
      fontSize: 18, // Ligeramente más grande para la unidad "Días"
      fontWeight: FontWeight.w500,
    );

    return Container(
      color: backgroundColor,
      width: size.width,
      height: size.height * 0.1255,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Velocidad actual Km/h",
                  textAlign: TextAlign.center,
                  style: headerLabelStyle,
                ),
                Text(
                  speed!.toInt().toString(),
                  style: mainValueStyle,
                ),
              ],
            ),
          ),
          // Divisor Vertical
          Container(
            height: size.height * 0.2,
            width: 2,
            color: textColor.withValues(alpha: 0.7),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          // Sección de Actualización
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Actualizado hace",
                  textAlign: TextAlign.center,
                  style: headerLabelStyle,
                ),
                Text(
                  updated,
                  style: mainValueStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}