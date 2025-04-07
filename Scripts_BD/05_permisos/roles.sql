-- Crear el rol
CREATE ROLE dba WITH
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION LIMIT -1
  PASSWORD 'PasswordSeguro123'; -- Cambia por una contraseña segura

-- Asignar privilegios
GRANT ALL PRIVILEGES ON DATABASE hrms TO dba;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dba;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO dba;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO dba;

-- Privilegios futuros
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON TABLES TO dba;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON SEQUENCES TO dba;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON FUNCTIONS TO dba;

-- Crear el rol
CREATE ROLE recursos_humanos WITH
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION LIMIT -1
  PASSWORD 'RhPassword456'; -- Cambia por una contraseña segura

-- Privilegios sobre todas las tablas existentes
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO recursos_humanos;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO recursos_humanos;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO recursos_humanos;

-- Privilegios para crear objetos (opcional)
GRANT CREATE ON SCHEMA public TO recursos_humanos;

-- Privilegios futuros
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO recursos_humanos;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT USAGE, SELECT ON SEQUENCES TO recursos_humanos;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT EXECUTE ON FUNCTIONS TO recursos_humanos;

-- Crear el rol
CREATE ROLE empleado WITH
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION LIMIT -1
  PASSWORD 'EmpleadoPass789'; -- Cambia por una contraseña segura

-- Privilegios de solo lectura sobre todas las tablas existentes
GRANT SELECT ON ALL TABLES IN SCHEMA public TO empleado;

-- Privilegios futuros
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO empleado;