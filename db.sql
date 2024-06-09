DROP DATABASE IF EXISTS muchocine;
CREATE DATABASE muchocine;
USE muchocine;


CREATE TABLE IDIOMA (
    codigo_iso CHAR(2) NOT NULL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE FORMATO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE CONTINENTE (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE PAIS (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    id_continente INT NOT NULL,
    FOREIGN KEY (id_continente) REFERENCES CONTINENTE(id)
);

CREATE TABLE CIUDAD (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    id_pais INT NOT NULL,
    FOREIGN KEY (id_pais) REFERENCES PAIS(id)
);

CREATE TABLE EMPRESA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE GENERO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE PREMIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    categoria VARCHAR(100) NOT NULL
);

CREATE TABLE RESTRICCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    tipo_restriccion ENUM('ATP', 'TP', 'MPAA', 'PG-15', 'R-Rated')
);

CREATE TABLE PAQUETE (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('personal', 'duo', 'familiar') NOT NULL,
    descripcion TEXT NOT NULL,
    duracion DECIMAL(5, 2) NOT NULL
);


CREATE TABLE PERSONA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(30),
    apellido_materno VARCHAR(30),
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('F', 'M', 'N'),
    id_ciudad_residencia INT NOT NULL,
    FOREIGN KEY (id_ciudad_residencia) REFERENCES CIUDAD(id)
);

CREATE TABLE ACTOR (
    id_persona INT NOT NULL,
    id_ciudad_origen INT NOT NULL,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id),
    FOREIGN KEY (id_ciudad_origen) REFERENCES CIUDAD(id)
);

CREATE TABLE CUENTA (
    id_persona INT NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    usuario VARCHAR(100) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id)
);

CREATE TABLE SUBCUENTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    clave_acceso VARCHAR(255),
    activo BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id_persona)
);

CREATE TABLE OFERTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT NOT NULL,
    precio DECIMAL(3, 2) NOT NULL,
    descuento DECIMAL(3, 2),
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,
    id_paquete INT NOT NULL,
    FOREIGN KEY (id_paquete) REFERENCES PAQUETE(id)
);

CREATE TABLE FORMA_PAGO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    monto DECIMAL(5, 2) NOT NULL
);

CREATE TABLE CREDITO (
    id_forma_pago INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    PRIMARY KEY (id_forma_pago),
    FOREIGN KEY (id_forma_pago) REFERENCES FORMA_PAGO(id)
);

CREATE TABLE TRANSACCION_CREDITO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    multa DECIMAL(2, 2) NOT NULL,
    id_credito INT NOT NULL,
    FOREIGN KEY (id_credito) REFERENCES CREDITO(id_forma_pago)
);

CREATE TABLE CONTADO (
    id_forma_pago INT NOT NULL,
    descuento DECIMAL(2, 2) NOT NULL,
    PRIMARY KEY (id_forma_pago),
    FOREIGN KEY (id_forma_pago) REFERENCES FORMA_PAGO(id)
);

CREATE TABLE SUSCRIPCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha_adquisicion DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    tipo_tarjeta ENUM('credito', 'debito') NOT NULL,
    id_paquete INT NOT NULL,
    id_cuenta INT NOT NULL,
    id_forma_pago INT NOT NULL,
    FOREIGN KEY (id_paquete) REFERENCES PAQUETE(id),
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id_persona),
    FOREIGN KEY (id_forma_pago) REFERENCES FORMA_PAGO(id)
);


CREATE TABLE CONTENIDO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    -- estreno YEAR NOT NULL,
    link_foto_propaganda VARCHAR(255) NOT NULL,
    id_restriccion INT NOT NULL,
    id_genero INT NOT NULL,
    FOREIGN KEY (id_restriccion) REFERENCES RESTRICCION(id),
    FOREIGN KEY (id_genero) REFERENCES GENERO(id)
);

CREATE TABLE AUDIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_audio VARCHAR(255) NOT NULL,
    codigo_idioma CHAR(2) NOT NULL,
    id_contenido INT NOT NULL,
    FOREIGN KEY (codigo_idioma) REFERENCES IDIOMA(codigo_iso),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE VISUALIZACION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_subcuenta INT NOT NULL,
    id_contenido INT NOT NULL,
    FOREIGN KEY (id_subcuenta) REFERENCES SUBCUENTA(id),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE SUBTITULO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_subtitulo VARCHAR(255) NOT NULL,
    codigo_idioma CHAR(2) NOT NULL,
    id_contenido INT NOT NULL,
    FOREIGN KEY (codigo_idioma) REFERENCES IDIOMA(codigo_iso),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE TRAILER (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_video VARCHAR(255) NOT NULL,
    duracion TIME NOT NULL,
    id_contenido INT,
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE PELICULA (
    id_contenido INT NOT NULL,
    duracion TIME NOT NULL,
    link_video VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (id_contenido),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE SERIE (
    id_contenido INT NOT NULL,
    duracion DECIMAL(5, 2) NOT NULL,
    cantidad_temporadas INT,
    PRIMARY KEY (id_contenido),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE TEMPORADA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    id_serie INT NOT NULL,
    cantidad_capitulos INT,
    fecha_estreno DATE,
    FOREIGN KEY (id_serie) REFERENCES SERIE(id_contenido)
);

CREATE TABLE CAPITULO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    link_video VARCHAR(255) NOT NULL,
    duracion DECIMAL(10, 2) NOT NULL,
    fecha_estreno DATE NOT NULL,
    id_temporada INT NOT NULL,
    FOREIGN KEY (id_temporada) REFERENCES TEMPORADA(id)
);

CREATE TABLE ESTRENO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    descripcion TEXT,
    id_contenido INT NOT NULL,
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE TELEFONO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo_pais INT NOT NULL,
    numero INT NOT NULL,
    id_cuenta INT NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id_persona)
);

CREATE TABLE NOMINADO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_contenido INT NOT NULL,
    id_premio INT NOT NULL,
    fecha_nominacion DATE,
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id),
    FOREIGN KEY (id_premio) REFERENCES PREMIO(id)
);


CREATE TABLE R_CONTENIDO_ACTOR (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_artistico VARCHAR(100) NOT NULL,
    rol ENUM('principal', 'secundario', 'reparto', 'extra', 'cameo') NOT NULL,
    id_actor INT NOT NULL,
    id_contenido INT NOT NULL,
    FOREIGN KEY (id_actor) REFERENCES ACTOR(id_persona),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id)
);

CREATE TABLE R_CONTENIDO_EMPRESA (
    costo DECIMAL(7, 2) NOT NULL,
    duracion DECIMAL(5, 2),
    id_contenido INT NOT NULL,
    id_empresa INT NOT NULL,
    PRIMARY KEY (id_contenido, id_empresa),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id),
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id)
);

CREATE TABLE R_CONTENIDO_FORMATO (
    id_contenido INT NOT NULL,
    id_formato INT NOT NULL,
    PRIMARY KEY (id_contenido, id_formato),
    FOREIGN KEY (id_contenido) REFERENCES CONTENIDO(id),
    FOREIGN KEY (id_formato) REFERENCES FORMATO(id)
);
