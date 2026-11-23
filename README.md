# Coco Audio Reader

Lector personal de PDF a audio para iPhone. Local, sin cuentas, sin servidores, sin publicidad.

## Estado

- [x] Etapa 1 — Proyecto base e interfaz (Biblioteca, Reproductor, Voz y velocidad)
- [ ] Etapa 2 — Importación de PDFs
- [ ] Etapa 3 — Extracción de texto y lectura
- [ ] Etapa 4 — Controles de reproducción y velocidad
- [ ] Etapa 5 — Segundo plano y pantalla bloqueada
- [ ] Etapa 6 — Persistencia de biblioteca y progreso
- [ ] Etapa 7 — Pruebas en dispositivo real
- [ ] Etapa 8 — Correcciones y mejoras

## Arquitectura

| Pieza | Tecnología |
|---|---|
| Interfaz | SwiftUI (iOS 17+) |
| Lectura de PDF | PDFKit |
| Voz | AVSpeechSynthesizer |
| Segundo plano / Lock Screen | AVAudioSession + MediaPlayer (MPNowPlayingInfoCenter, MPRemoteCommandCenter) |
| Almacenamiento | Archivos en la carpeta Documents de la app + JSON |
| OCR (fase 2) | Vision |

```
CocoAudioReader/
  App/        punto de entrada
  Models/     datos (documento, ajustes)
  Views/      pantallas
Config/Info.plist   permisos (audio en segundo plano)
```

Cada `push` se compila automáticamente en una Mac de GitHub (pestaña **Actions**).

## Requisitos

- Mac con Xcode 16 o posterior
- iPhone con iOS 17 o posterior
- Apple ID gratuito (alcanza para instalar en tu propio iPhone; la app caduca a los 7 días y se reinstala con un clic)
