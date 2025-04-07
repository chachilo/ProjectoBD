-- 1.-Consulta de Nomina Completa
SELECT 
    e.empleado_id,
    e.nombre || ' ' || e.apellido AS empleado,
    d.nombre AS departamento,
    p.nombre AS puesto,
    s.monto AS salario_actual,
    (SELECT SUM(costo) 
     FROM Empleados_Beneficios eb 
     JOIN Beneficios b ON eb.beneficio_id = b.beneficio_id
     WHERE eb.empleado_id = e.empleado_id AND (eb.fecha_fin IS NULL OR eb.fecha_fin > CURRENT_DATE)
    ) AS costo_beneficios,
    s.monto + COALESCE((SELECT SUM(costo) 
                       FROM Empleados_Beneficios eb 
                       JOIN Beneficios b ON eb.beneficio_id = b.beneficio_id
                       WHERE eb.empleado_id = e.empleado_id AND (eb.fecha_fin IS NULL OR eb.fecha_fin > CURRENT_DATE)), 0) AS costo_total
FROM 
    Empleados e
JOIN 
    Departamentos d ON e.departamento_id = d.departamento_id
JOIN 
    Puestos p ON e.puesto_id = p.puesto_id
JOIN 
    Salarios s ON e.empleado_id = s.empleado_id
WHERE 
    s.fecha_fin IS NULL
ORDER BY 
    d.nombre, p.nombre;

-- 2.-Analisis de desempeño por departamento
SELECT 
    d.departamento_id,
    d.nombre AS departamento,
    COUNT(e.empleado_id) AS total_empleados,
    ROUND(AVG(ev.calificacion), 2) AS promedio_evaluacion,
    MAX(ev.calificacion) AS maxima_evaluacion,
    MIN(ev.calificacion) AS minima_evaluacion,
    (SELECT COUNT(DISTINCT ec.empleado_id)
     FROM Empleados_Capacitaciones ec
     JOIN Empleados e2 ON ec.empleado_id = e2.empleado_id
     WHERE e2.departamento_id = d.departamento_id AND ec.asistio = TRUE
    ) AS empleados_capacitados
FROM 
    Departamentos d
LEFT JOIN 
    Empleados e ON d.departamento_id = e.departamento_id
LEFT JOIN 
    Evaluaciones ev ON e.empleado_id = ev.empleado_id
GROUP BY 
    d.departamento_id, d.nombre
ORDER BY 
    promedio_evaluacion DESC;

-- 3.-Consulta de Beneficios Vs Desempeño
SELECT 
    b.beneficio_id,
    b.nombre AS beneficio,
    COUNT(eb.empleado_id) AS empleados_con_beneficio,
    ROUND(AVG(ev.calificacion), 2) AS promedio_evaluacion,
    ROUND((SELECT AVG(ev2.calificacion)
          FROM Evaluaciones ev2
          JOIN Empleados e2 ON ev2.empleado_id = e2.empleado_id
          WHERE NOT EXISTS (
              SELECT 1 FROM Empleados_Beneficios eb2 
              WHERE eb2.empleado_id = e2.empleado_id 
              AND eb2.beneficio_id = b.beneficio_id
              AND (eb2.fecha_fin IS NULL OR eb2.fecha_fin > CURRENT_DATE)
          )
    ), 2) AS promedio_sin_beneficio,
    ROUND(AVG(ev.calificacion) - (SELECT AVG(ev2.calificacion)
          FROM Evaluaciones ev2
          JOIN Empleados e2 ON ev2.empleado_id = e2.empleado_id
          WHERE NOT EXISTS (
              SELECT 1 FROM Empleados_Beneficios eb2 
              WHERE eb2.empleado_id = e2.empleado_id 
              AND eb2.beneficio_id = b.beneficio_id
              AND (eb2.fecha_fin IS NULL OR eb2.fecha_fin > CURRENT_DATE)
          )
    ), 2) AS diferencia_desempeño
FROM 
    Beneficios b
LEFT JOIN 
    Empleados_Beneficios eb ON b.beneficio_id = eb.beneficio_id 
    AND (eb.fecha_fin IS NULL OR eb.fecha_fin > CURRENT_DATE)
LEFT JOIN 
    Evaluaciones ev ON eb.empleado_id = ev.empleado_id
GROUP BY 
    b.beneficio_id, b.nombre
ORDER BY 
    diferencia_desempeño DESC;

-- 4.-Reporte Integral de Empleado (Todas las tablas realcionadas)
SELECT 
    e.empleado_id,
    e.nombre || ' ' || e.apellido AS empleado,
    d.nombre AS departamento,
    p.nombre AS puesto,
    p.salario_base,
    s.monto AS salario_actual,
    s.fecha_inicio AS fecha_inicio_salario,
    (SELECT STRING_AGG(b.nombre, ', ')
     FROM Empleados_Beneficios eb
     JOIN Beneficios b ON eb.beneficio_id = b.beneficio_id
     WHERE eb.empleado_id = e.empleado_id AND (eb.fecha_fin IS NULL OR eb.fecha_fin > CURRENT_DATE)
    ) AS beneficios_actuales,
    (SELECT COUNT(*) 
     FROM Evaluaciones ev 
     WHERE ev.empleado_id = e.empleado_id
    ) AS total_evaluaciones,
    (SELECT ROUND(AVG(calificacion), 2)
     FROM Evaluaciones ev 
     WHERE ev.empleado_id = e.empleado_id
    ) AS promedio_evaluaciones,
    (SELECT STRING_AGG(c.nombre, ', ')
     FROM Empleados_Capacitaciones ec
     JOIN Capacitaciones c ON ec.capacitacion_id = c.capacitacion_id
     WHERE ec.empleado_id = e.empleado_id AND ec.asistio = TRUE
    ) AS capacitaciones_completadas,
    (SELECT COUNT(*) 
     FROM Asistencias a 
     WHERE a.empleado_id = e.empleado_id
     AND a.fecha BETWEEN CURRENT_DATE - INTERVAL '30 days' AND CURRENT_DATE
    ) AS dias_asistidos_ultimo_mes
FROM 
    Empleados e
JOIN 
    Departamentos d ON e.departamento_id = d.departamento_id
JOIN 
    Puestos p ON e.puesto_id = p.puesto_id
JOIN 
    Salarios s ON e.empleado_id = s.empleado_id AND s.fecha_fin IS NULL
ORDER BY 
    d.nombre, e.apellido;

-- 5.-Análisis de Costo-Efectividad de Capacitaciones
SELECT 
    c.capacitacion_id,
    c.nombre AS capacitacion,
    COUNT(ec.empleado_id) FILTER (WHERE ec.asistio = TRUE) AS empleados_asistieron,
    COUNT(ec.empleado_id) FILTER (WHERE ec.asistio = FALSE) AS empleados_no_asistieron,
    (SELECT COUNT(DISTINCT e.empleado_id) FROM Empleados e) AS total_empleados,
    ROUND(COUNT(ec.empleado_id) FILTER (WHERE ec.asistio = TRUE) * 100.0 / 
          (SELECT COUNT(DISTINCT e.empleado_id) FROM Empleados e), 2) AS porcentaje_participacion,
    (SELECT ROUND(AVG(ev.calificacion), 2)
     FROM Evaluaciones ev
     JOIN Empleados_Capacitaciones ec2 ON ev.empleado_id = ec2.empleado_id
     WHERE ec2.capacitacion_id = c.capacitacion_id AND ec2.asistio = TRUE
     AND ev.fecha_evaluacion > c.fecha_fin
    ) AS promedio_evaluaciones_post_capacitacion,
    (SELECT ROUND(AVG(ev.calificacion), 2)
     FROM Evaluaciones ev
     JOIN Empleados_Capacitaciones ec2 ON ev.empleado_id = ec2.empleado_id
     WHERE ec2.capacitacion_id = c.capacitacion_id AND ec2.asistio = TRUE
     AND ev.fecha_evaluacion < c.fecha_inicio
    ) AS promedio_evaluaciones_pre_capacitacion,
    (SELECT ROUND(AVG(ev.calificacion), 2)
     FROM Evaluaciones ev
     JOIN Empleados_Capacitaciones ec2 ON ev.empleado_id = ec2.empleado_id
     WHERE ec2.capacitacion_id = c.capacitacion_id AND ec2.asistio = TRUE
     AND ev.fecha_evaluacion > c.fecha_fin
    ) - 
    (SELECT ROUND(AVG(ev.calificacion), 2)
     FROM Evaluaciones ev
     JOIN Empleados_Capacitaciones ec2 ON ev.empleado_id = ec2.empleado_id
     WHERE ec2.capacitacion_id = c.capacitacion_id AND ec2.asistio = TRUE
     AND ev.fecha_evaluacion < c.fecha_inicio
    ) AS mejora_desempeño
FROM 
    Capacitaciones c
LEFT JOIN 
    Empleados_Capacitaciones ec ON c.capacitacion_id = ec.capacitacion_id
GROUP BY 
    c.capacitacion_id, c.nombre
ORDER BY 
    mejora_desempeño DESC NULLS LAST;