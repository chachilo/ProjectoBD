-- PROCEDIMIENTO: registrar_empleado
-- Descripción: Registra un nuevo empleado y asigna salario inicial

CREATE OR REPLACE PROCEDURE registrar_empleado(
    p_nombre VARCHAR(50),
    p_apellido VARCHAR(50),
    p_fecha_nacimiento DATE,
    p_genero CHAR(1),
    p_email VARCHAR(100),
    p_fecha_contratacion DATE,
    p_departamento_id INTEGER,
    p_puesto_id INTEGER,
    p_salario_inicial DECIMAL(10,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_empleado_id INTEGER;
BEGIN
    -- Validar datos de entrada
    IF p_genero NOT IN ('M', 'F', 'O') THEN
        RAISE EXCEPTION 'Género no válido. Use M, F u O';
    END IF;

    -- Insertar nuevo empleado
    INSERT INTO empleados (
        nombre, apellido, fecha_nacimiento, genero, 
        email, fecha_contratacion, departamento_id, puesto_id
    ) VALUES (
        p_nombre, p_apellido, p_fecha_nacimiento, p_genero,
        p_email, p_fecha_contratacion, p_departamento_id, p_puesto_id
    ) RETURNING empleado_id INTO v_empleado_id;

    -- Asignar salario inicial
    INSERT INTO salarios (
        empleado_id, monto, fecha_inicio
    ) VALUES (
        v_empleado_id, p_salario_inicial, p_fecha_contratacion
    );

    -- Asignar beneficios básicos
    INSERT INTO empleados_beneficios (empleado_id, beneficio_id, fecha_inicio)
    SELECT v_empleado_id, beneficio_id, CURRENT_DATE
    FROM beneficios
    WHERE tipo_beneficio = 'BASICO';

    -- Registrar en auditoría
    INSERT INTO auditoria_empleados (
        empleado_id, accion, detalles, usuario
    ) VALUES (
        v_empleado_id, 'REGISTRO', 'Nuevo empleado registrado', CURRENT_USER
    );

    COMMIT;
    RAISE NOTICE 'Empleado % % registrado con ID: %', p_nombre, p_apellido, v_empleado_id;
END;
$$;