# Sistema de Gestión de Recursos Humanos (HRMS)

Sistema de base de datos completo para la gestión de empleados, departamentos, salarios, beneficios y evaluaciones.

## Características Clave
✅ Gestión centralizada de empleados  
✅ Control de asistencia y nómina  
✅ Evaluaciones de desempeño  
✅ Beneficios y compensaciones  
✅ Generación de reportes

## Tecnologías
- PostgreSQL 15+
- pgAdmin 4

## Estructura del Repositorio

| Carpeta          | Contenido                                  |
|------------------|-------------------------------------------|
| /consultas       | Consultas SQL frecuentes                  |
| /documentacion   | Documentación del proyecto                |
| /scripts        | Scripts de estructura y procedimientos    |
| /permisos       | Configuración de roles y usuarios         |

## Requisitos
- PostgreSQL 15+
- pgAdmin 4 (opcional)

## Instalación
1. Clonar repositorio
2. Ejecutar scripts en orden:
```bash
psql -U postgres -f scripts/01_esquema/tablas_principales.sql
psql -U postgres -f scripts/01_esquema/tablas_relacionales.sql

### 2. Description_Proyecto.md

```markdown
# Descripción del Proyecto HRMS

## Objetivo
Sistema integral para la gestión de recursos humanos en una organización.

## Componentes Principales

### 1. Módulo de Empleados
- Registro de información personal
- Historial laboral
- Documentación asociada

### 2. Módulo de Nómina
- Cálculo de salarios
- Beneficios
- Deducciones

### 3. Módulo de Evaluación
- Desempeño laboral
- Objetivos
- Planes de mejora

## Diagrama de Flujo
![recursos humanos](https://www.mermaidchart.com/raw/1418c4e3-e3a1-428b-9d77-158f5e25abf4?theme=light&version=v0.1&format=svg)
