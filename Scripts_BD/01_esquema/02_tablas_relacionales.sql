-- Tabla intermedia: Empleados_Beneficios
CREATE TABLE empleados_beneficios (
    empleado_id INTEGER NOT NULL REFERENCES empleados(empleado_id),
    beneficio_id INTEGER NOT NULL REFERENCES beneficios(beneficio_id),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (empleado_id, beneficio_id, fecha_inicio)
);

-- Tabla intermedia: Empleados_Capacitaciones
CREATE TABLE empleados_capacitaciones (
    empleado_id INTEGER NOT NULL REFERENCES empleados(empleado_id),
    capacitacion_id INTEGER NOT NULL REFERENCES capacitaciones(capacitacion_id),
    asistio BOOLEAN NOT NULL DEFAULT FALSE,
    calificacion INTEGER CHECK (calificacion BETWEEN 1 AND 5),
    PRIMARY KEY (empleado_id, capacitacion_id)
);