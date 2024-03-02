CREATE DATABASE IF NOT EXISTS muchocine;

USE muchocine;

CREATE TABLE informacion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE genero (
    id INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES informacion(id)
);

CREATE TABLE restriccion (
    id INT NOT NULL PRIMARY KEY,
    categoria ENUM('ATP', 'TP', 'MPAA', 'PG-15', 'R-Rated'),
    FOREIGN KEY (id) REFERENCES informacion(id)
);

CREATE TABLE temporada (
    id NOT NULL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES informacion(id)
);

CREATE TABLE video (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    duracion DECIMAL(10, 2) NOT NULL,
    id_restriccion INT NOT NULL,
    FOREIGN KEY (id_restriccion) REFERENCES restriccion(id)
    -- TODO: trailer, banner, etc...
);

CREATE TABLE video_genero (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_video INT NOT NULL,
    id_genero INT NOT NULL,
    FOREIGN KEY (id_video) REFERENCES video(id),
    FOREIGN KEY (id_genero) REFERENCES genero(id)
);

CREATE TABLE pelicula (
    id INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES video(id)
    -- TODO: agregar mas informacion
);

CREATE TABLE serie (
    id INT NOT NULL PRIMARY KEY,
    -- TODO: agregar mas informacion
    FOREIGN KEY (id) REFERENCES video(id)
);

CREATE TABLE direccion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(100),
    pais VARCHAR(100) NOT NULL
);

CREATE TABLE actor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    apellido_paterno VARCHAR(50),
    apellido_materno VARCHAR(50),
    nombre_artistico VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_residencia INT NOT NULL,
    id_origen INT NOT NULL,
    sexo CHAR(1),
    -- sexo EMUM('F', 'M', 'N'),
    FOREIGN KEY (id_residencia) REFERENCES direccion(id),
    FOREIGN KEY (id_origen) REFERENCES direccion(id)
);

CREATE TABLE actuacion (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rol ENUM('principal', 'secundario', 'reparto', 'extra', 'cameo') NOT NULL,
    id_actor INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_actor) REFERENCES actor(id),
    FOREIGN KEY (id_video) REFERENCES video(id)
);


