USE muchocine;


-- *************************************************
-- *****                                       *****
-- *****     2. NOTIFICACIONES DE ESTRENOS     *****
-- *****                                       *****
-- *************************************************

CREATE TABLE NOTIFICACION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_estreno INT NOT NULL,
    id_cuenta INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (id_estreno) REFERENCES ESTRENO(id),
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id_persona)
);


DELIMITER $$
CREATE FUNCTION contar_visualizaciones_genero(id_cuenta INT, id_genero INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_visualizaciones INT;

    SELECT
        COUNT(s.id_cuenta) INTO total_visualizaciones
    FROM SUBCUENTA s
        JOIN VISUALIZACION v ON v.id_subcuenta = s.id
        JOIN CONTENIDO co ON co.id = v.id_contenido
        JOIN GENERO g ON g.id = co.id_genero
    WHERE s.id_cuenta = id_cuenta
        AND g.id = id_genero
        AND s.activo = 1;

    RETURN total_visualizaciones;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_estreno_insert
AFTER INSERT ON ESTRENO
FOR EACH ROW
BEGIN
    DECLARE genero INT;
    DECLARE minimo INT;
    SET minimo = 0;

    SELECT id_genero INTO genero
    FROM CONTENIDO
    WHERE id = NEW.id_contenido;

    INSERT INTO NOTIFICACION (id_estreno, id_cuenta)
    SELECT NEW.id AS id_estreno, c.id_persona AS id_cuenta
    FROM CUENTA c
    WHERE contar_visualizaciones_genero(c.id_persona, genero) > minimo;
END$$
DELIMITER ;


-- **********************************************************
-- *****                                                *****
-- *****     5. VERIFICACION DE RESTRICCION DE EDAD     *****
-- *****                                                *****
-- **********************************************************

ALTER TABLE SUBCUENTA
    ADD COLUMN id_restriccion INT NOT NULL DEFAULT 3,
    ADD CONSTRAINT `fk_subcuenta_restriccion` FOREIGN KEY (id_restriccion)
        REFERENCES RESTRICCION(id);

ALTER TABLE RESTRICCION ADD nivel_restriccion INT NOT NULL;
UPDATE RESTRICCION SET nivel_restriccion = 0
    WHERE tipo_restriccion = 'ATP';
UPDATE RESTRICCION SET nivel_restriccion = 5
    WHERE tipo_restriccion = 'TP';
UPDATE RESTRICCION SET nivel_restriccion = 20
    WHERE tipo_restriccion = 'MPAA';
UPDATE RESTRICCION SET nivel_restriccion = 30
    WHERE tipo_restriccion = 'PG-15';
UPDATE RESTRICCION SET nivel_restriccion = 40
    WHERE tipo_restriccion = 'R-Rated';


DELIMITER $$
CREATE TRIGGER before_visualization_insert
BEFORE INSERT ON VISUALIZACION
FOR EACH ROW
BEGIN
    DECLARE restriccion_edad_contenido INT;
    DECLARE restriccion_edad_cuenta INT;

    SELECT r.nivel_restriccion INTO restriccion_edad_contenido
        FROM RESTRICCION r
        JOIN CONTENIDO c ON c.id_restriccion = r.id
        WHERE c.id = NEW.id_contenido;

    SELECT scr.nivel_restriccion INTO restriccion_edad_cuenta
        FROM SUBCUENTA sc
        JOIN RESTRICCION scr on scr.id = sc.id_restriccion
        WHERE sc.id = NEW.id_subcuenta;

    IF restriccion_edad_contenido > restriccion_edad_cuenta THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Contenido prohibido por la restricción de edad';
    END IF;
END$$
DELIMITER ;


-- ********************************************************************
-- *****                                                          *****
-- *****     11. PREVENCION DE ELIMINACION DE CUENTAS ACTIVAS     *****
-- *****                                                          *****
-- ********************************************************************

DELIMITER $$
CREATE TRIGGER before_delete_cuenta
BEFORE DELETE ON CUENTA
FOR EACH ROW
BEGIN
    DECLARE suscripciones_activas INT;

    SELECT COUNT(*)
        INTO suscripciones_activas
        FROM SUSCRIPCION
        WHERE id_cuenta = OLD.id_persona AND fecha_fin > CURDATE();

    IF suscripciones_activas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar la cuenta porque tiene suscripciones activas.';
    END IF;
END$$
DELIMITER ;



-- **********************************************************

-- *******************************************************
-- *****                                             *****
-- *****     20. VALIDACION DE FORMATOS DE DATOS     *****
-- *****                                             *****
-- *******************************************************

DELIMITER $$
CREATE TRIGGER validar_persona_insert
BEFORE INSERT ON PERSONA
FOR EACH ROW
BEGIN
    IF NEW.nombre REGEXP '[^A-Za-z ]' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre debe contener solo letras y espacios';
    END IF;

    IF NEW.fecha_nacimiento >= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de nacimiento debe ser anterior a la fecha actual';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER validar_cuenta_insert
BEFORE INSERT ON CUENTA
FOR EACH ROW
BEGIN
    DECLARE email_regex VARCHAR(255) DEFAULT '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
    DECLARE username_regex VARCHAR(255) DEFAULT '^[A-Za-z0-9_]{5,30}$';

    IF NOT (NEW.correo REGEXP email_regex) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El formato del correo es incorrecto';
    END IF;

    IF NOT (NEW.usuario REGEXP username_regex) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre de usuario debe tener entre 5 y 30 caracteres y solo puede incluir letras, números y guiones bajos';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER validar_oferta_insert
BEFORE INSERT ON OFERTA
FOR EACH ROW
BEGIN
    IF NEW.descuento >= NEW.precio THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El descuento no puede ser mayor que el precio';
    END IF;

    IF NEW.fecha_inicio >= NEW.fecha_fin THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de inicio debe ser anterior a la fecha de fin';
    END IF;
END$$
DELIMITER ;


-- **********************************************************

-- ***************************************
-- *****                             *****
-- *****     22. BITACORA CUENTA     *****
-- *****                             *****
-- ***************************************

CREATE TABLE B_CUENTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    correo VARCHAR(100),
    usuario VARCHAR(100),
    clave VARCHAR(255),
    operacion VARCHAR(10),
    user_db VARCHAR(100) NOT NULL DEFAULT CURRENT_USER,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


DELIMITER $$
CREATE TRIGGER before_cuenta_insert
BEFORE INSERT ON CUENTA
FOR EACH ROW
BEGIN
    INSERT INTO B_CUENTA (id_persona, correo, usuario, clave, operacion)
    VALUES (NEW.id_persona, NEW.correo, NEW.usuario, NEW.clave, 'INSERT');
END$$

CREATE TRIGGER before_cuenta_update
BEFORE UPDATE ON CUENTA
FOR EACH ROW
BEGIN
    INSERT INTO B_CUENTA (id_persona, correo, usuario, clave, operacion)
    VALUES (NEW.id_persona, NEW.correo, NEW.usuario, NEW.clave, 'UPDATE');
END$$

CREATE TRIGGER before_cuenta_delete
BEFORE DELETE ON CUENTA
FOR EACH ROW
BEGIN
    INSERT INTO B_CUENTA (id_persona, correo, usuario, clave, operacion)
    VALUES (OLD.id_persona, OLD.correo, OLD.usuario, OLD.clave, 'DELETE');
END$$
DELIMITER ;


-- ********************************************
-- *****                                  *****
-- *****     23. BITACORA SUSCRIPCION     *****
-- *****                                  *****
-- ********************************************

CREATE TABLE B_SUSCRIPCION (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_suscripcion INT,
    fecha_adquisicion DATE,
    fecha_fin DATE,
    tipo_tarjeta ENUM('credito', 'debito'),
    id_paquete INT,
    id_cuenta INT,
    id_forma_pago INT,
    operacion VARCHAR(10),
    user_db VARCHAR(100) NOT NULL DEFAULT CURRENT_USER,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER $$
CREATE TRIGGER before_suscripcion_insert
BEFORE INSERT ON SUSCRIPCION
FOR EACH ROW
BEGIN
    INSERT INTO B_SUSCRIPCION (
        id_suscripcion,
        fecha_adquisicion, fecha_fin,
        tipo_tarjeta,
        id_paquete,
        id_cuenta,
        id_forma_pago,
        operacion
    ) VALUES (
        NEW.id,
        NEW.fecha_adquisicion,
        NEW.fecha_fin,
        NEW.tipo_tarjeta,
        NEW.id_paquete,
        NEW.id_cuenta,
        NEW.id_forma_pago,
        'INSERT'
    );
END$$

CREATE TRIGGER before_suscripcion_update
BEFORE UPDATE ON SUSCRIPCION
FOR EACH ROW
BEGIN
    INSERT INTO B_SUSCRIPCION (
        id_suscripcion,
        fecha_adquisicion,
        fecha_fin,
        tipo_tarjeta,
        id_paquete,
        id_cuenta,
        id_forma_pago,
        operacion
    ) VALUES (
        NEW.id,
        NEW.fecha_adquisicion,
        NEW.fecha_fin,
        NEW.tipo_tarjeta,
        NEW.id_paquete,
        NEW.id_cuenta,
        NEW.id_forma_pago,
        'UPDATE'
    );
END$$

CREATE TRIGGER before_suscripcion_delete
BEFORE DELETE ON SUSCRIPCION
FOR EACH ROW
BEGIN
    INSERT INTO B_SUSCRIPCION (
        id_suscripcion,
        fecha_adquisicion,
        fecha_fin,
        tipo_tarjeta,
        id_paquete,
        id_cuenta,
        id_forma_pago,
        operacion
    ) VALUES (
        OLD.id,
        OLD.fecha_adquisicion,
        OLD.fecha_fin,
        OLD.tipo_tarjeta,
        OLD.id_paquete,
        OLD.id_cuenta,
        OLD.id_forma_pago,
        'DELETE'
    );
END$$
DELIMITER ;
