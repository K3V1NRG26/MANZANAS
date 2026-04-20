#  Atrapa Manzanas

Juego desarrollado en **Lua con Solar2D**, donde controlas un ave que debe atrapar manzanas para ganar puntos y evitar perder vidas.

---

##  Descripción

El objetivo del juego es mover el ave horizontalmente para atrapar las manzanas que caen desde la parte superior de la pantalla.
Cada manzana atrapada suma puntos, mientras que cada manzana perdida reduce una vida.

El juego termina cuando el jugador pierde todas sus vidas, mostrando una pantalla de **Game Over** con opción de reiniciar.

---
## Características

* Movimiento del ave con mouse o touch
* Animación de aleteo 
* Manzanas aleatorias 
* Sistema de puntaje
* Contador de manzanas atrapadas
* Sistema de vidas 
* Aumento progresivo de dificultad
* Sonido al atrapar manzanas 
* Pantalla de **Game Over**
* Botón de **Reiniciar**

---

## Tecnologías utilizadas

* Lenguaje: **Lua**
* Motor: **Solar2D (Corona SDK)**

---

## Estructura del proyecto

```
proyecto
 ├── main.lua
 ├── config.lua
 ├── bosque.jpg
 ├── parrot-a.png
 ├── parrot-b.png
 ├── apple.png
 ├── apple2.png
 └── Bite.mp3
```

---

## Cómo ejecutar el juego

1. Instala **Solar2D**
2. Abre el proyecto en el simulador
3. Ejecuta el archivo `main.lua`

---

## Lógica del juego

* Las manzanas caen continuamente usando `enterFrame`
* Se generan posiciones aleatorias con `math.random()`
* Las colisiones detectan cuando el ave atrapa una manzana
* Se suman puntos y aumenta la velocidad
* Si no se atrapa, se pierde una vida
* Al llegar a 0 vidas → Game Over

---

## Mejoras implementadas

* Sistema de vidas
* Dificultad progresiva
* Sonido al atrapar
* Botón de reinicio

---

## videncia

Agregar aquí capturas del juego funcionando:

* Gameplay
* Puntaje
* Game Over
* Botón reiniciar

---

## Autor

Proyecto desarrollado por **[Tu nombre aquí]**

---

## Notas

Este proyecto fue realizado como práctica para aprender:

* Eventos en programación
* Detección de colisiones
* Lógica de videojuegos
* Uso de físicas en Solar2D

---
