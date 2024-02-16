import 'package:flutter/material.dart';


const Color mepyaColor = Color.fromARGB(255, 39, 184, 51);
const Color mepyaBackGroundColor = Colors.blue;
const Color mepyaThirdColor = Color.fromARGB(255, 91, 197, 59);


const LinearGradient mepyaBackGradient = LinearGradient(
  colors: [mepyaColor, mepyaBackGroundColor, mepyaThirdColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  transform: GradientRotation(1/50),
);

