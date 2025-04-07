# Modelo Entidad-Relación del Sistema HRMS

![E-R recursos_Humanos](image.png)

## Entidades Principales

### 1. Empleados
- **Atributos clave**: empleado_id, nombre, apellido, email
- **Relaciones**:
  - Pertenece a un Departamento (1:N)
  - Tiene un Puesto (1:1)
  - Recibe múltiples Salarios (1:N)
  - Tiene múltiples Beneficios (N:M)

### 2. Departamentos
- **Atributos clave**: departamento_id, nombre
- **Relaciones**:
  - Contiene múltiples Puestos (1:N)

### 3. Puestos
- **Atributos clave**: puesto_id, nombre, salario_base
- **Relaciones**:
  - Asignado a un Departamento (N:1)

## Diccionario de Datos

| Entidad       | Atributo          | Tipo         | Descripción                     |
|---------------|-------------------|--------------|---------------------------------|
| Empleados     | empleado_id       | SERIAL       | Identificador único            |
| Empleados     | fecha_contratacion| DATE         | Fecha de ingreso a la empresa  |
| Salarios      | monto             | DECIMAL(10,2)| Valor del salario mensual      |
| Beneficios    | costo_mensual     | DECIMAL(8,2) | Costo mensual del beneficio    |