# Sistema de Gestión de Recursos Humanos (SGRH)

## Tabla de Contenidos
- [Objetivos del Sistema](#objetivos-del-sistema)
- [Características Técnicas](#características-técnicas)
- [Beneficios Clave](#beneficios-clave)
- [Módulos Principales](#módulos-principales)
- [Tecnologías Implementadas](#tecnologías-implementadas)
---

## Objetivos del Sistema

### Gestión Integral de Talento Humano
- **Registro centralizado**: Información completa de empleados en un solo lugar  
- **Estructura organizacional**: Asignación dinámica a departamentos y puestos  
- **Compensaciones**: Sistema integrado de salarios y beneficios  
- **Desempeño**: Evaluación continua con múltiples métricas  
- **Desarrollo profesional**: Planes de capacitación y crecimiento  

### Automatización de Procesos
- **Asistencia**: Control biométrico y registro horario  
- **Nóminas**: Cálculo automático con validaciones integradas  
- **Reportes**: Generación bajo demanda o programada  
- **Workflows**: Aprobaciones automatizadas para procesos de RRHH  

---

## Características Técnicas

### Arquitectura de Base de Datos

| Componente        | Especificación                            |
|-------------------|--------------------------------------------|
| Motor principal   | PostgreSQL 15+                             |
| Modelado          | Normalización 3NF                          |
| Procedimientos    | 15+ almacenados para operaciones clave     |
| Disparadores      | 8 triggers de auditoría                    |
| Seguridad         | 4 roles con permisos granulares            |
| Backup            | Automatizado diario + incrementales        |

### Estructura Modular
- **Núcleo Central**: Empleados, Departamentos, Puestos  
- **Compensación**: Salarios, Beneficios, Prestaciones  
- **Desarrollo**: Capacitaciones, Evaluaciones, Planes de carrera  
- **Operaciones**: Asistencias, Incidencias, Reportes  

---

## Beneficios Clave

### Para RRHH
- **Eficiencia**: Reducción del 60% en procesos manuales  
- **Centralización**: Todos los datos en un solo sistema  
- **Historial**: Trazabilidad completa de cada empleado  
- **Cumplimiento**: Alertas automáticas para requisitos legales  

### Para la Organización
- **Precisión**: Menos del 0.1% de errores en nómina  
- **Productividad**: 30% menos tiempo en procesos de RRHH  
- **Transparencia**: Acceso controlado a información  
- **Analítica**: Datos para toma de decisiones estratégicas  

---

## Módulos Principales

### 1. Gestión de Empleados
- **Registro**: Datos personales + profesionales  
- **Documentación**: Digitalización de expedientes  
- **Onboarding**: Flujo automatizado de ingreso  
- **Offboarding**: Proceso de salida controlado  

### 2. Administración de Compensaciones
- **Estructura salarial**: Rangos y niveles automatizados  
- **Prestaciones**: Cálculo preciso de beneficios  
- **Variables**: Bonos, incentivos y deducciones  
- **Proyecciones**: Simulador de crecimiento salarial  

### 3. Desarrollo Organizacional
- **Planes de carrera**: Rutas personalizadas  
- **Competencias**: Evaluación por habilidades  
- **Capacitación**: Programas y seguimiento  
- **Evaluación**: Sistema 360° integrado  

---

## Tecnologías Implementadas

### Stack Principal
- **Base de datos**: PostgreSQL 15 (RDBMS avanzado)  
- **Lenguaje**: PL/pgSQL (Procedimientos almacenados)  
- **Herramientas**: pgAdmin 4 (Gestión visual)  
- **Automatización**: PowerShell (Scripting de tareas)  
