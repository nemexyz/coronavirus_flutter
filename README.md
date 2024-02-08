# CoronaVirus Flutter App

Prueba Técnica desarrollada en Dart y Flutter.
Con diseño responsivo para dispositivos iPhone y android.

## Solución

Se integro dependencias para organización del proyecto mediante BLoC Flutter, como base en principios SOLID y Clean Arquitecture. Cada carpeta en /lib se entiende como modulo y página del proyecto, dentro de ellas esta su lógica con estados eventos y estados, también su modelo de datos y vistas segmentadas.

Cada página contiene una inyección de dependencia para fácil mantenimiento y uso, también para desarrollo de test practicos en un futuro. Su estructura de páginación se desarrollo en base a un enrutador que permite enviar argumentos y direccionar de una forma sencilla.

En la temificación se agrego la dependencia Provider y un manager para obtener más facilmente los valores de cada modo (light o dark).

> Nota: El flujo comienza desde el Splash, al hacer login no guarda la sesión. No se especifico en la prueba, solo simular cierre de sesión.

## Foto capturas
<p Align ="center">
<img src = "/doc/images/splash.png" height = 450;>
<img src = "/doc/images/login.png" height = 450;>
<img src = "/doc/images/home.png" height = 450;>
<img src = "/doc/images/home_dark.png" height = 450;>
<img src = "/doc/images/states.png" height = 450;>
<img src = "/doc/images/region.png" height = 450;>
</p>

## API de Servicios

https://api.covidtracking.com
