
### 📄 scripts/01_esquema/tablas_principales.sql

```sql
-- TABLAS PRINCIPALES DEL SISTEMA HRMS

-- Tabla: Departamentos
CREATE TABLE departamentos (
    departamento_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla: Puestos
CREATE TABLE puestos (
    puesto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    salario_base DECIMAL(10,2) NOT NULL,
    nivel_jerarquico INTEGER,
    departamento_id INTEGER REFERENCES departamentos(departamento_id)
);

-- Tabla: Empleados
CREATE TABLE empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero CHAR(1) CHECK (genero IN ('M', 'F', 'O')),
    direccion TEXT,
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    fecha_contratacion DATE NOT NULL,
    departamento_id INTEGER REFERENCES departamentos(departamento_id),
    puesto_id INTEGER REFERENCES puestos(puesto_id),
    foto BYTEA,
    estado VARCHAR(20) DEFAULT 'ACTIVO'
);

-- Tabla: Beneficios
CREATE TABLE beneficios (
    beneficio_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    costo_mensual DECIMAL(10,2) NOT NULL,
    tipo_beneficio VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla: Salarios 
CREATE TABLE salarios (
    salario_id SERIAL PRIMARY KEY,
    empleado_id INTEGER NOT NULL REFERENCES empleados(empleado_id),
    monto DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    motivo_ajuste VARCHAR(100)
);

-- Tabla: Evaluaciones
CREATE TABLE evaluaciones (
    evaluacion_id SERIAL PRIMARY KEY,
    empleado_id INTEGER NOT NULL REFERENCES empleados(empleado_id),
    fecha_evaluacion DATE NOT NULL,
    calificacion DECIMAL(3,1) NOT NULL CHECK (calificacion BETWEEN 0 AND 10),
    comentarios TEXT,
    evaluador_id INTEGER REFERENCES empleados(empleado_id),
    tipo_evaluacion VARCHAR(50)
);

-- Tabla: Capacitaciones
CREATE TABLE capacitaciones (
    capacitacion_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    costo DECIMAL(10,2),
    proveedor VARCHAR(100),
    horas_duracion INTEGER
);

-- Tabla: Asistencias
CREATE TABLE asistencias (
    asistencia_id SERIAL PRIMARY KEY,
    empleado_id INTEGER NOT NULL REFERENCES empleados(empleado_id),
    fecha DATE NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME,
    estado_asistencia VARCHAR(20) DEFAULT 'PRESENTE',
    observaciones TEXT
);