CREATE DATABASE muchocine;

USE muchocine;

CREATE TABLE informacion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE audio (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_audio VARCHAR(255) NOT NULL
);

CREATE TABLE subtitulo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_subtitulo VARCHAR(255) NOT NULL
);

CREATE TABLE premio (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL
    -- PRIMARY KEY (id),
    -- FOREIGN KEY (id) REFERENCES informacion(id)
);

CREATE TABLE direccion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(100),
    pais VARCHAR(100) NOT NULL
);

CREATE TABLE genero (
    id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES informacion(id)
);

CREATE TABLE restriccion (
    id INT NOT NULL,
    categoria ENUM('ATP', 'TP', 'MPAA', 'PG-15', 'R-Rated'),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES informacion(id)
);

CREATE TABLE persona (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    apellido_paterno VARCHAR(50),
    apellido_materno VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    id_residencia INT NOT NULL,
    sexo CHAR(1),
    FOREIGN KEY (id_residencia) REFERENCES direccion(id)
);

CREATE TABLE video (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    duracion DECIMAL(10, 2) NOT NULL,
    id_restriccion INT NOT NULL,
    FOREIGN KEY (id_restriccion) REFERENCES restriccion(id)
    -- TODO: trailer, banner, etc...
);

CREATE TABLE actor (
    id INT NOT NULL,
    nombre_artistico VARCHAR(100) NOT NULL,
    id_origen INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (id_origen) REFERENCES direccion(id)
);

CREATE TABLE serie (
    id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES video(id)
);

CREATE TABLE temporada (
    id INT NOT NULL,
    id_serie INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES informacion(id),
    FOREIGN KEY (id_serie) REFERENCES serie(id)
);

CREATE TABLE capitulo (
    id INT NOT NULL,
    link_video VARCHAR(255) NOT NULL,
    duracion DECIMAL(10, 2),
    id_temporada INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES informacion(id),
    FOREIGN KEY (id_temporada) REFERENCES temporada(id)
);

CREATE TABLE pelicula (
    id INT NOT NULL,
    link_video VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES video(id)
);

CREATE TABLE cliente (
    id INT NOT NULL,
    correo VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE suscripcion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id)
    -- TODO: AGREGAR INFORMACION
);

CREATE TABLE oferta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    -- TODO: AGREGAR INFORMACION
);

CREATE TABLE paquete (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    -- TODO: AGREGAR INFORMACION
);

CREATE TABLE subcuenta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_suscripcion INT NOT NULL,
    FOREIGN KEY (id_suscripcion) REFERENCES suscripcion(id)
);

CREATE TABLE reproduccion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_video INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE estreno (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_video INT NOT NULL,
    tipo ENUM('pelicula', 'serie') NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE empresa (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);



CREATE TABLE actuacion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rol ENUM('principal', 'secundario', 'reparto', 'extra', 'cameo') NOT NULL,
    id_actor INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_actor) REFERENCES actor(id),
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE premiacion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha YEAR NOT NULL,
    id_video INT NOT NULL,
    id_premio INT NOT NULL,
    FOREIGN KEY (id_video) REFERENCES video(id),
    FOREIGN KEY (id_premio) REFERENCES premio(id)
);

CREATE TABLE video_genero (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_video INT NOT NULL,
    id_genero INT NOT NULL,
    FOREIGN KEY (id_video) REFERENCES video(id),
    FOREIGN KEY (id_genero) REFERENCES genero(id)
);

CREATE TABLE video_audio (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_audio INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_audio) REFERENCES audio(id),
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE video_subtitulo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_subtitulo INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_subtitulo) REFERENCES subtitulo(id),
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE subcuenta_genero (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_subcuenta INT NOT NULL,
    id_genero INT NOT NULL,
    FOREIGN KEY (id_subcuenta) REFERENCES subcuenta(id),
    FOREIGN KEY (id_genero) REFERENCES genero(id)
);

CREATE TABLE produccion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_video INT NOT NULL,
    id_empresa INT NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_video) REFERENCES video(id),
    FOREIGN KEY (id_empresa) REFERENCES empresa(id)
);


/*
+---------------------+
| Tables_in_muchocine |
+---------------------+
| actor               |
| actuacion           |
| audio               |
| capitulo            |
| cliente             |
| direccion           |
| empresa             |
| estreno             |
| genero              |
| informacion         |
| oferta              |
| paquete             |
| pelicula            |
| persona             |
| premiacion          |
| premio              |
| produccion          |
| reproduccion        |
| restriccion         |
| serie               |
| subcuenta           |
| subcuenta_genero    |
| subtitulo           |
| suscripcion         |
| temporada           |
| video               |
| video_audio         |
| video_genero        |
| video_subtitulo     |
+---------------------+
*/
