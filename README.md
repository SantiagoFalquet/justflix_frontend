# 🎬 Proyecto JustFlix - Backend

JustFlix es una plataforma de streaming de videos.

---

## 👥 Integrantes

- **Adrian**
- **Santiago**
- **Roly**

## Tecnología implementanda

### Frontend

- **Flutter**
- **Dart**

## Repositorio relacionados

| Módulo  | Repositorio                                                    |
| ------- | -------------------------------------------------------------- |
| Base    | [url](https://github.com/adriian04/just-eat-adrian-roly-santi) |
| Backend | [url](https://github.com/RolyAlc/JustFlix-Backend.git)         |

---

## Objetivo del proyecto

- Implementar una arquitectura cliente-servidor.
- Aplicar principios de **CLEAN code**.
- Desarrolar una interfaz atractiva y modular.
- Integrar API REST.

## Requisitos

- **Flutter**
- **Android Studio**

## Fases

### Fase 2

- [x] Caldrà convertir els vídeos que volguem afegir a l'aplicació, cadascun en una carpeta, on afegirem els fitxers .ts i .m3u8 generats.
- [x] Caldrà configurar el nostre servidor Express amb el middleware `static`, per a que servisca la carpeta amb els vídeos.
- [x] Caldrà modificar la llista de vídeos amb la informació dels vídeos que hem creat, afegint com a font del vídeo la ruta al fitxer m3u8.
- [x] Afegir la reproducció de vídeo al client:
  - [x] Afegir un widget per a la reproducció de vídeo.
  - [x] Generar els controls necessaris per a la reproducció i pausa.
  - [x] Modificar l'aplicació per donar-li permís per accedir a Internet al `AndroidManifest.xml`, després de l'etiqueta `application`: `<uses-permission android:name="android.permission.INTERNET"/>`

---

Todos los derechos reservados © JustFlix 2025
