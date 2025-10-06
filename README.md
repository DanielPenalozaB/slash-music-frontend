# 🎵 Slash Music - Frontend

Aplicación de streaming de música desarrollada con Flutter, conectada a un backend en Spring Boot desplegado en AWS.

## 🚀 Quick Start

```bash
# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## 📚 Documentación

- **[BACKEND_READY.md](BACKEND_READY.md)** - 🎯 **EMPIEZA AQUÍ** - Guía completa de la integración del backend
- **[BACKEND_INTEGRATION_GUIDE.md](BACKEND_INTEGRATION_GUIDE.md)** - Guía técnica detallada de la arquitectura
- **[API_SPECIFICATION.md](API_SPECIFICATION.md)** - Especificación completa de la API
- **[QUICK_START.md](QUICK_START.md)** - Guía rápida de inicio

## 🏗️ Arquitectura

El proyecto sigue **Clean Architecture** con las siguientes capas:

- **Presentation** - UI (Pages, Widgets, Bloc)
- **Domain** - Lógica de negocio (Use Cases, Repositories)
- **Data** - Fuentes de datos (API, Local Storage)
- **Core** - Utilidades compartidas (Network, Constants)

## ✨ Características Implementadas

- ✅ Autenticación completa (Registro, Login, Logout)
- ✅ Gestión de estado con Bloc
- ✅ Almacenamiento local de tokens
- ✅ Arquitectura limpia y escalable
- ✅ Validación de formularios
- ✅ Manejo de errores
- ✅ UI moderna con tema personalizado

## 🔗 Backend

**URL:** http://ec2-54-167-13-29.compute-1.amazonaws.com:7777

**Swagger:** [http://ec2-54-167-13-29.compute-1.amazonaws.com:7777/swagger-ui/index.html](http://ec2-54-167-13-29.compute-1.amazonaws.com:7777/swagger-ui/index.html)

## 📦 Dependencias Principales

- `dio` - Cliente HTTP
- `flutter_bloc` - Gestión de estado
- `get_it` - Inyección de dependencias
- `shared_preferences` - Almacenamiento local
- `json_serializable` - Serialización JSON
- `dartz` - Programación funcional

## 🛠️ Comandos Útiles

```bash
# Regenerar archivos de serialización
flutter pub run build_runner build --delete-conflicting-outputs

# Limpiar proyecto
flutter clean

# Ver dispositivos disponibles
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device-id>
```

## 👥 Equipo

Desarrollado con ❤️ por el equipo de Slash Music

---

Para más información, consulta la documentación en los archivos markdown del proyecto.
