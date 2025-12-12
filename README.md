# NowWeather
 
Aplicación iOS desarrollada en Swift cuyo objetivo es practicar el consumo de una API REST pública, el uso de permisos de localización en iOS y manejar estados asíncronos, usando una arquitectura limpia y mantenible.  

Aunque la UI es sencilla, el foco principal está en la **estructura del código**, la **separación de responsabilidades** y el uso de **arquitectura moderna**.
 
## Arquitectura

El proyecto sigue un enfoque basado en **MVVM + Clean Architecture**, con separación clara entre capas:
 
- **Presentation**: ViewControllers, ViewModels, componentes UI.

- **Domain**: modelos de dominio y errores de dominio (preparado para refactorizar la arquitectura con  casos de uso).

- **Data**: DTOs, servicios de la API, repositorios y mappers.

- **Resources**: utilidades, constantes y archivo Localizable.strings.

- **Device**: Servicios relaciónados con el dispostivo.

- **Application**: Alojados los archivos relacionados con el control de la app.

## Diseño de la UI
 
La interfaz se construye con componentes reutilizables que se combinan dentro de una tabla. Cada elemento sabe dibujarse a sí mismo y la pantalla solo organiza la lista de componentes aprovechando asi las ventajas de redimensado automático y scroll que incorpora UITableView y evitando problemas con las constraints.
 
### Componentes

- Cada componente tiene **su propio modelo** y puede reutilizarse en cualquier pantalla.
 
### Celdas

- Los componentes se encapsulan en **celdas**, que reciben un modelo unificado si es necesario.

- Cada celda sabe **configurarse y dibujarse** por sí misma.
 
### Protocolo Drawer

- Los modelos implementan **Drawer**, que indica qué celda los dibuja.

- La tabla usa el Drawer para pedir a cada modelo que genere su celda correspondiente.
 
 
## Principios aplicados

- **SOLID**

- **Inversión de dependencias mediante protocolos**

- **Repository Pattern**

- **DTO → Mapper → Domain Model**

- **Async/Await para networking**

- **Componentización de la UI con Drawer Protocol**
 
## Funcionalidades principales

- Consulta del tiempo de la ubicación actual mediante API de OpenWeatherMap.

- Obtención de la ubicación del dispositivo con un servicio desacoplado.

- Gestión de estados en el ViewModel (`loading`, `success`, `error`).
 
## Objetivo del proyecto

Practicar una estructura profesional en iOS, priorizando:

- Código limpio  

- Facilidad de mantenimiento  

- Escalabilidad  

- Separación estricta de responsabilidades  
 
---
 
 
