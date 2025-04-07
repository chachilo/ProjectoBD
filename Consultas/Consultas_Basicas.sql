-- 1. Empleados por departamento
SELECT e.nombre, e.apellido, d.nombre AS departamento  
FROM Empleados e  
JOIN Departamentos d ON e.departamento_id = d.departamento_id  
WHERE d.nombre = 'Ventas';

-- 2. Salario actual de cada empleado
SELECT e.empleado_id, e.nombre, e.apellido, s.monto AS salario_actual
FROM Empleados e
JOIN Salarios s ON e.empleado_id = s.empleado_id
WHERE s.fecha_fin IS NULL OR s.fecha_fin > CURDATE();

-- 3. Beneficios por empleado
SELECT e.nombre, e.apellido, b.nombre AS beneficio, b.costo
FROM Empleados e
JOIN Empleados_Beneficios eb ON e.empleado_id = eb.empleado_id
JOIN Beneficios b ON eb.beneficio_id = b.beneficio_id;