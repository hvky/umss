CREATE DATABASE muchocine;

USE muchocine;

CREATE TABLE IDIOMA (
    codigo_iso CHAR(2) NOT NULL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE FORMATO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL
);

-- CREATE TABLE PAIS (
--     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     nombre VARCHAR(20) NOT NULL,
--     continente ENUM('AFRICA', 'AMERICA', 'ASIA', 'EUROPA', 'OCEANIA') NOT NULL
-- );

-- CREATE TABLE UBICACION (
--     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     ciudad VARCHAR(30) NOT NULL,
--     id_pais INT NOT NULL,
--     FOREIGN KEY (id_pais) REFERENCES PAIS(id)
-- );

CREATE TABLE EMPRESA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL
    -- fecha_fundacion YEAR,
    -- sitio_web VARCHAR(255)
);

CREATE TABLE GENERO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE OFERTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT NOT NULL,
    precio DECIMAL(3, 2) NOT NULL,
    descuento DECIMAL(3, 2),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE PREMIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL,
    categoria VARCHAR(100) NOT NULL
);

CREATE TABLE RESTRICCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL,
    tipo_restriccion ENUM('ATP', 'TP', 'MPAA', 'PG-15', 'R-Rated')
);


CREATE TABLE PERSONA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    apellido_paterno VARCHAR(20),
    apellido_materno VARCHAR(20),
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('F', 'M', 'N'),
    ciudad_residencia VARCHAR(50) NOT NULL,
    pais_residencia VARCHAR(30) NOT NULL
);

CREATE TABLE ACTOR (
    id_persona INT NOT NULL,
    ciudad_origen VARCHAR(50) NOT NULL,
    pais_origen VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id)
);

CREATE TABLE CUENTA (
    id_persona INT NOT NULL,
    correo VARCHAR(255) NOT NULL UNIQUE,
    usuario VARCHAR(255) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id)
);

CREATE TABLE SUBCUENTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT NOT NULL,
    clave_acceso VARCHAR(255),
    activo BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id_persona)
);

CREATE TABLE SUSCRIPCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    forma_pago ENUM('debito', 'credito') NOT NULL,
    duracion DECIMAL(6, 2) NOT NULL,
    id_cuenta INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id_persona)
);

CREATE TABLE TRANSACCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(3, 2) NOT NULL,
    id_suscripcion INT NOT NULL,
    FOREIGN KEY (id_suscripcion) REFERENCES SUSCRIPCION(id)
);


CREATE TABLE INFORMACION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    estreno YEAR NOT NULL,
    link_portada VARCHAR(255) NOT NULL,
    id_restriccion INT NOT NULL,
    FOREIGN KEY (id_restriccion) REFERENCES RESTRICCION(id)
);

CREATE TABLE AUDIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_audio VARCHAR(255) NOT NULL,
    codigo_idioma CHAR(2) NOT NULL,
    id_informacion INT NOT NULL,
    FOREIGN KEY (codigo_idioma) REFERENCES IDIOMA(codigo_iso),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);

CREATE TABLE REPRODUCCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_subcuenta INT NOT NULL,
    id_informacion INT NOT NULL,
    FOREIGN KEY (id_subcuenta) REFERENCES SUBCUENTA(id),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);

CREATE TABLE SUBTITULO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_subtitulo VARCHAR(255) NOT NULL,
    codigo_idioma CHAR(2) NOT NULL,
    id_informacion INT NOT NULL,
    FOREIGN KEY (codigo_idioma) REFERENCES IDIOMA(codigo_iso),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);

CREATE TABLE TRAILER (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_video VARCHAR(255) NOT NULL,
    duracion DECIMAL(5, 2) NOT NULL,
    id_informacion INT NOT NULL,
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);

CREATE TABLE PELICULA (
    id_informacion INT NOT NULL,
    duracion TIME NOT NULL,
    link_video VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (id_informacion),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);

CREATE TABLE SERIE (
    id_informacion INT NOT NULL,
    duracion DECIMAL(5, 2) NOT NULL,
    cantidad_temporadas INT,
    PRIMARY KEY (id_informacion),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);

CREATE TABLE TEMPORADA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT NOT NULL,
    id_serie INT NOT NULL,
    cantidad_capitulos INT,
    FOREIGN KEY (id_serie) REFERENCES SERIE(id_informacion)
);

CREATE TABLE CAPITULO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    link_video VARCHAR(255) NOT NULL,
    duracion DECIMAL(10, 2) NOT NULL,
    id_temporada INT NOT NULL,
    FOREIGN KEY (id_temporada) REFERENCES TEMPORADA(id)
);

CREATE TABLE ESTRENO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    id_informacion INT NOT NULL,
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);


CREATE TABLE R_ACTOR_INFORMACION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_artistico VARCHAR(100) NOT NULL,
    rol ENUM('principal', 'secundario', 'reparto', 'extra', 'cameo') NOT NULL,
    id_actor INT NOT NULL,
    id_informacion INT NOT NULL,
    FOREIGN KEY (id_actor) REFERENCES ACTOR(id_persona),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id)
);

CREATE TABLE R_INFORMACION_PREMIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha YEAR NOT NULL,
    tipo ENUM('pelicula', 'serie') NOT NULL,
    id_informacion INT NOT NULL,
    id_premio INT NOT NULL,
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id),
    FOREIGN KEY (id_premio) REFERENCES PREMIO(id)
);

CREATE TABLE R_INFORMACION_GENERO (
    id_informacion INT NOT NULL,
    id_genero INT NOT NULL,
    PRIMARY KEY (id_informacion, id_genero),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id),
    FOREIGN KEY (id_genero) REFERENCES GENERO(id)
);

CREATE TABLE R_INFORMACION_EMPRESA (
    costo DECIMAL(7, 2) NOT NULL,
    id_informacion INT NOT NULL,
    id_empresa INT NOT NULL,
    PRIMARY KEY (id_informacion, id_empresa),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id),
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id)
);

CREATE TABLE R_INFORMACION_FORMATO (
    id_informacion INT NOT NULL,
    id_formato INT NOT NULL,
    PRIMARY KEY (id_informacion, id_formato),
    FOREIGN KEY (id_informacion) REFERENCES INFORMACION(id),
    FOREIGN KEY (id_formato) REFERENCES FORMATO(id)
);

CREATE TABLE H_OFERTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_oferta INT NOT NULL,
    nueva_fecha_inicio DATE NOT NULL,
    nueva_fecha_fin DATE NOT NULL,
    FOREIGN KEY (id_oferta) REFERENCES OFERTA(id)
);
