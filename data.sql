START TRANSACTION;

INSERT INTO IDIOMA (codigo_iso, nombre) VALUES
  ('en', 'Inglés'),
  ('es', 'Español'),
  ('fr', 'Francés'),
  ('de', 'Alemán'),
  ('it', 'Italiano'),
  ('pt', 'Portugués'),
  ('zh', 'Mandarín'),
  ('ja', 'Japonés'),
  ('ko', 'Coreano'),
  ('ru', 'Ruso'),
  ('ar', 'Árabe'),
  ('hi', 'Hindi'),
  ('bn', 'Bengalí'),
  ('ur', 'Urdu'),
  ('tr', 'Turco'),
  ('nl', 'Holandés'),
  ('sv', 'Sueco'),
  ('no', 'Noruego'),
  ('da', 'Danés'),
  ('fi', 'Finlandés'),
  ('el', 'Griego'),
  ('pl', 'Polaco'),
  ('cs', 'Checo'),
  ('hu', 'Húngaro'),
  ('he', 'Hebreo'),
  ('th', 'Tailandés'),
  ('vi', 'Vietnamita'),
  ('id', 'Indonesio'),
  ('ms', 'Malayo'),
  ('sw', 'Swahili'),
  ('yo', 'Yoruba'),
  ('zu', 'Zulú'),
  ('am', 'Amárico'),
  ('ha', 'Hausa'),
  ('ig', 'Igbo'),
  ('tl', 'Tagalo'),
  ('ta', 'Tamil'),
  ('lo', 'Lao'),
  ('my', 'Birmano'),
  ('ro', 'Rumano'),
  ('uk', 'Ucraniano'),
  ('sr', 'Serbio'),
  ('sk', 'Eslovaco'),
  ('lt', 'Lituano'),
  ('lv', 'Letón'),
  ('et', 'Estonio'),
  ('qu', 'Quechua'),
  ('gn', 'Guaraní'),
  ('ay', 'Aimara'),
  ('mi', 'Maorí'),
  ('sm', 'Samoano'),
  ('fj', 'Fiyiano'),
  ('eo', 'Esperanto');

INSERT INTO FORMATO (nombre, descripcion) VALUES
  ('MP4', 'Formato de archivo multimedia comprimido que es ampliamente utilizado para transmisión de video en línea'),
  ('MKV', 'Formato contenedor de video que admite múltiples pistas de audio y subtítulos'),
  ('AVI', 'Formato contenedor de video desarrollado por Microsoft'),
  ('MOV', 'Formato de archivo multimedia desarrollado por Apple para QuickTime'),
  ('WEBM', 'Formato de archivo multimedia abierto y gratuito desarrollado para la web'),
  ('FLV', 'Formato de archivo Flash Video, ampliamente utilizado para transmisión de video en línea'),
  ('WMV', 'Formato de archivo desarrollado por Microsoft para Windows Media'),
  ('OGG', 'Formato de archivo multimedia contenedor abierto y gratuito'),
  ('HLS', 'Protocolo de transmisión de video HTTP Live Streaming utilizado para la entrega de contenido multimedia a través de Internet'),
  ('MPEG-DASH', 'Estándar para la transmisión adaptativa de video a través de HTTP'),
  ('AAC', 'Formato de compresión de audio avanzado, comúnmente utilizado para transmisión de audio en línea'),
  ('MP3', 'Formato de compresión de audio comúnmente utilizado para transmisión de audio en línea');

INSERT INTO CONTINENTE (nombre, descripcion) VALUES
  ('África', 'El segundo continente más grande de la Tierra, conocido por su diversidad cultural, su vida salvaje y sus paisajes impresionantes.'),
  ('América', 'El continente donde se encuentra la mayor parte de la cordillera de los Andes y el lago Titicaca, conocido por su diversidad geográfica y cultural.'),
  ('Asia', 'El continente más grande y poblado del mundo, conocido por su historia antigua, su tecnología avanzada y su diversidad cultural.'),
  ('Europa', 'El continente donde se encuentra la mayor parte de la península balcánica y los Alpes, conocido por su historia, su arte y su diversidad lingüística.'),
  ('Oceanía', 'El continente más pequeño del mundo, conocido por su gran cantidad de islas, su vida marina y sus paisajes paradisíacos.');

INSERT INTO PAIS ( nombre, descripcion, id_continente) VALUES
  ( 'ESTADOS UNIDOS', 'País ubicado en América del Norte, conocido por su diversidad cultural y económica.', 2),
  ( 'CANADA', 'País norteamericano conocido por su vasto territorio, belleza natural y calidad de vida.', 2),
  ( 'BRASIL', 'País sudamericano reconocido por su vibrante cultura, vasta selva amazónica y playas espectaculares.', 2),
  ( 'ALEMANIA', 'País europeo líder en tecnología, economía y cultura, ubicado en el centro de Europa.', 4),
  ( 'SERBIA', 'País balcánico con una rica historia y patrimonio cultural, ubicado en el sureste de Europa.', 4),
  ( 'SAMOA', 'Nación insular del Pacífico conocida por sus paisajes tropicales, playas y cultura polinesia.', 1),
  ( 'JAPON', 'País asiático conocido por su tecnología avanzada, cultura única y hermosos paisajes.', 3),
  ( 'INGLATERRA', 'País en el Reino Unido conocido por su historia, cultura, monarquía y hermosos paisajes.', 4),
  ( 'ESPAÑA', 'País en el suroeste de Europa famoso por su historia, cultura, arte y deliciosa gastronomía.', 4),
  ( 'FRANCIA', 'País europeo conocido por su moda, arte, gastronomía y sitios históricos icónicos.', 4),
  ( 'BOLIVIA', 'País sudamericano conocido por su diversidad geográfica, cultura indígena y hermosos paisajes.', 1);

INSERT INTO CIUDAD (id, nombre, descripcion, id_pais) VALUES
  (1, 'NEW YORK', 'La ciudad más poblada de Estados Unidos, conocida por su diversidad cultural, rascacielos emblemáticos y vida urbana vibrante.', 1),
  (2, 'Vancouver', 'Ciudad costera en Canadá conocida por su impresionante belleza natural, calidad de vida y actividades al aire libre.', 2),
  (3, 'Santa Mónica', 'Ciudad costera en California, famosa por sus playas, estilo de vida relajado y ambiente playero.', 1),
  (4, 'Río de Janeiro', 'Ciudad brasileña famosa por su icónica estatua del Cristo Redentor, playas impresionantes y carnaval animado.', 3),
  (5, 'Berlín', 'Capital de Alemania conocida por su historia, arte urbano, vida nocturna y vibrante escena cultural.', 4),
  (6, 'Florida', 'Estado en Estados Unidos conocido por su clima cálido, playas espectaculares y parques temáticos famosos.', 1),
  (7, 'Texas', 'Estado en Estados Unidos conocido por su tamaño, diversidad geográfica, industria petrolera y cultura texana única.', 1),
  (8, 'Cincinnati', 'Ciudad en Ohio, Estados Unidos, conocida por su historia, arquitectura, arte y comida.', 1),
  (9, 'Novi Sad', 'Ciudad en Serbia, conocida por su hermoso casco antiguo, festivales de música y patrimonio cultural.', 5),
  (10, 'Apia', 'Capital de Samoa, conocida por sus playas de arena blanca, arrecifes de coral y rica cultura polinesia.', 6),
  (11, 'Tokio', 'Capital de Japón, conocida por su tecnología avanzada, cultura única, moda vanguardista y vida nocturna.', 7),
  (12, 'Los Ángeles', 'Ciudad en California, conocida por ser el centro de la industria del entretenimiento, el sol, las playas y la diversidad cultural.', 1);
  
INSERT INTO GENERO (nombre, descripcion) VALUES
  ('Acción', 'Películas o series que se caracterizan por escenas llenas de energía, con combates, persecuciones y situaciones de alta tensión.'),
  ('Aventura', 'Historias emocionantes que suelen implicar viajes, descubrimientos y desafíos en entornos exóticos o fantásticos.'),
  ('Comedia', 'Producciones destinadas a hacer reír al público, con situaciones divertidas, humor físico o diálogos ingeniosos.'),
  ('Drama', 'Películas o series que se centran en conflictos emocionales y personales, explorando temas profundos y conmovedores.'),
  ('Ciencia ficción', 'Historias que presentan avances tecnológicos, futuros alternativos o viajes espaciales, explorando posibilidades más allá de la realidad actual.'),
  ('Fantasía', 'Mundos imaginarios, criaturas mágicas y poderes sobrenaturales son características comunes de este género.'),
  ('Terror', 'Películas o series diseñadas para asustar y provocar miedo en el público, a menudo con elementos de suspenso, monstruos y situaciones escalofriantes.'),
  ('Suspense', 'Historias llenas de intriga y tensión, manteniendo al público en vilo sobre lo que sucederá a continuación.'),
  ('Romance', 'Historias de amor y relaciones personales, con énfasis en los aspectos emocionales y románticos de los personajes.'),
  ('Animación', 'Producciones en las que los personajes y entornos son creados mediante animación, ya sea tradicional o por computadora.'),
  ('Documental', 'Películas o series que presentan hechos reales, personas reales y eventos históricos, con el objetivo de informar, educar o concientizar al público.'),
  ('Musical', 'Historias en las que la música y el baile desempeñan un papel importante en la narrativa, a menudo con números musicales integrados en la trama.'),
  ('Western', 'Historias ambientadas en el viejo oeste americano, con tiroteos, duelos y paisajes desérticos como elementos característicos.'),
  ('Crimen', 'Películas o series que se centran en la comisión y resolución de crímenes, a menudo con detectives, policías y criminales como protagonistas.'),
  ('Misterio', 'Historias que giran en torno a la resolución de un enigma o la búsqueda de la verdad, manteniendo al público intrigado hasta el final.');

INSERT INTO PREMIO (nombre, descripcion, categoria) VALUES
  ('Oscar', 'Los premios de la Academia de las Artes y las Ciencias Cinematográficas, otorgados anualmente por logros destacados en la industria cinematográfica.', 'Cine'),
  ('Emmy', 'Premios otorgados por la Academia de Artes y Ciencias de la Televisión para reconocer la excelencia en la industria de la televisión estadounidense.', 'Televisión'),
  ('Globo de Oro', 'Premios otorgados por la Asociación de Prensa Extranjera de Hollywood, que reconoce la excelencia en cine y televisión.', 'Cine, Televisión'),
  ('BAFTA', 'Premios de la Academia Británica de las Artes Cinematográficas y de la Televisión, que reconoce la excelencia en cine, televisión y videojuegos.', 'Cine, Televisión, Videojuegos'),
  ('Cannes Film Festival', 'Uno de los festivales de cine más prestigiosos del mundo, celebrado anualmente en Cannes, Francia.', 'Cine'),
  ('Festival de Sundance', 'Festival de cine independiente que se celebra anualmente en Utah, Estados Unidos, considerado como una plataforma importante para cineastas emergentes.', 'Cine'),
  ('Premios Tony', 'Premios otorgados por la Liga de Teatros Americanos y Productores, que reconoce la excelencia en producciones teatrales de Broadway.', 'Teatro'),
  ('Festival de Venecia', 'Uno de los festivales de cine más antiguos y prestigiosos del mundo, celebrado anualmente en Venecia, Italia.', 'Cine'),
  ('Premios MTV', 'Premios otorgados por MTV para reconocer logros en música, cine y televisión, con énfasis en la cultura juvenil.', 'Música, Cine, Televisión');

INSERT INTO RESTRICCION (nombre, descripcion, tipo_restriccion) VALUES
  ('Apta para todo público (ATP)', 'La película o serie es apta para todo público. No contiene contenido que pueda considerarse inapropiado para niños.', 'ATP'),
  ('Todo público (TP)', 'La película o serie es apta para todo público. No contiene contenido que pueda considerarse inapropiado para niños.', 'TP'),
  ('Clasificación por edades', 'La clasificación de películas establecida por la MPAA. Incluye categorías como G, PG, PG-13, R y NC-17.', 'MPAA'),
  ('Parental Guidance', 'La película o serie puede contener contenido inapropiado para niños menores de 15 años. Se recomienda la supervisión de un adulto.', 'PG-15'),
  ('Restricted', 'La película o serie contiene contenido para adultos. No se recomienda para menores de 17 años sin la compañía de un adulto.', 'R-Rated');

INSERT INTO CONTENIDO (id, titulo, link_foto_propaganda, id_restriccion, id_genero) VALUES
  (1, 'Deadpool 2', 'https://images.app.goo.gl/FjAK19n6qCW4AtAo6', 5, 1),
  (2, 'Avengers: Endgame', 'https://images.app.goo.gl/ptqnCQgtLc1FUjha6', 2, 1),
  (3, 'Joker', 'https://images.app.goo.gl/yoFeAztULUCMWsNh8', 5, 4),
  (4, 'Scary Stories to Tell in the Dark', 'https://images.app.goo.gl/UQoGdHWfZTSmX3d38', 4, 7),
  (5, 'Hunt for the Wilderpeople', 'https://images.app.goo.gl/rHFr2hKsSmTCJxup8', 4, 2),
  (6, 'Game of Thrones', 'https://images.app.goo.gl/XGtZ9xzbUqrUfCwM6', 5, 6),
  (7, 'Breaking Bad', 'https://images.app.goo.gl/uUiNmbjRgVYJb3db6', 5, 4),
  (8, 'The Walking Dead', 'https://images.app.goo.gl/iv7y7FFmSBe97kT57', 4, 2),
  (9, 'Friends', 'https://images.app.goo.gl/vMw4yvFYH5Deuk786', 1, 3),
  (10, 'The Office', 'https://images.app.goo.gl/R7JUtUrDiHTaPzbo8', 1, 3);

INSERT INTO PELICULA (id_contenido, duracion, link_video) VALUES
  (1, "1.48", 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdga'),
  (2, "3.02", 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdgs'),
  (3, "2.2", 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdgddd'),
  (4, "1.51", 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdgfdf'), 
  (5, "1.41", 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdgasdfasd'); 

INSERT INTO TEMPORADA (id, nombre, descripcion, id_serie, cantidad_capitulos, fecha_estreno) VALUES
  (1, 'Game of Thrones: temp 1', 'Primera temporada de la serie', 6, 2, '2011-04-17'),
  (2, 'Game of Thrones: temp 2', 'Segunda temporada de la serie', 6, 2, '2012-04-01'),
  (3, 'Breaking Bad: temp 1', 'Primera temporada de la serie', 7, 2, '2008-01-20'),
  (4, 'Breaking Bad: temp 2', 'Segunda temporada de la serie', 7, 2, '2009-03-08'),
  (5, 'The Walking Dead: temp 1', 'Primera temporada de la serie', 8, 2, '2010-10-31'),
  (6, 'The Walking Dead: temp 2', 'Segunda temporada de la serie', 8, 2, '2011-10-16'),
  (7, 'La Ley y El orden UV: temp 1', 'Primera temporada de la serie', 9, 2, '1999-09-20'),
  (8, 'La Ley y El orden UV: temp 2', 'Segunda temporada de la serie', 9, 2, '2000-10-20'),
  (9, 'The Office: temp 1', 'Primera temporada de la serie', 10, 2, '2005-03-24'),
  (10, 'The Office: temp 2', 'Segunda temporada de la serie', 10, 2, '2005-09-20');

INSERT INTO CAPITULO (id, nombre, link_video, duracion, fecha_estreno, id_temporada) VALUES
  -- Game of Thrones Temporada 1
  (1, 'Winter Is Coming', 'https://www.youtube.com/watch?v=522lKp3QVDo', 62, '2011-04-17', 1),
  (2, 'The Kingsroad', 'https://www.youtube.com/watch?v=522lKp3QVDo', 56, '2011-04-24', 1),

  -- Game of Thrones Temporada 2
  (3, 'The North Remembers', 'https://www.youtube.com/watch?v=522lKp3QVDo', 54, '2012-04-01', 2),
  (4, 'The Night Lands', 'https://www.youtube.com/watch?v=522lKp3QVDo', 56, '2012-04-08', 2),

  -- Breaking Bad Temporada 1
  (5, 'Pilot', 'https://www.youtube.com/watch?v=522lKp3QVDo', 58, '2008-01-20', 3),
  (6, 'Cat''s in the Bag...', 'https://www.youtube.com/watch?v=522lKp3QVDo', 48, '2008-01-27', 3),

  -- Breaking Bad Temporada 2
  (7, 'Seven Thirty-Seven', 'https://www.youtube.com/watch?v=522lKp3QVDo', 55, '2009-03-08', 4),
  (8, 'Grilled', 'https://www.youtube.com/watch?v=522lKp3QVDo', 50, '2009-03-15', 4),-- La Ley y El orden UV Temporada 1
  (9, 'The One Where Monica Gets a Roommate', 'https://www.youtube.com/watch?v=522lKp3QVDo', 23, '1994-09-22', 5),
  (10, 'The One with the Sonogram at the End', 'https://www.youtube.com/watch?v=522lKp3QVDo', 22, '1994-09-29', 5),

  -- La Ley y El orden UV Temporada 2
  (11, 'The One with Ross''s New Girlfriend', 'https://www.youtube.com/watch?v=522lKp3QVDo', 25, '1995-09-21', 6),
  (12, 'The One with the Breast Milk', 'https://www.youtube.com/watch?v=522lKp3QVDo', 24, '1995-09-28', 6)  ,

  -- The Walking Dead Temporada 1
  (13, 'Days Gone Bye', 'https://www.youtube.com/watch?v=522lKp3QVDo', 67, '2010-10-31', 7),
  (14, 'Guts', 'https://www.youtube.com/watch?v=522lKp3QVDo', 60, '2010-11-07', 7),

  -- The Walking Dead Temporada 2
  (15, 'What Lies Ahead', 'https://www.youtube.com/watch?v=522lKp3QVDo', 62, '2011-10-16', 8),  
  (16, 'Bloodletting', 'https://www.youtube.com/watch?v=522lKp3QVDo', 55, '2011-10-23', 8),

  -- The Office Temporada 1
  (17, 'Pilot', 'https://www.youtube.com/watch?v=522lKp3QVDo', 23, '2005-03-24', 9),
  (18, 'Diversity Day', 'https://www.youtube.com/watch?v=522lKp3QVDo', 22, '2005-03-29', 9),

  -- The Office Temporada 2
  (19, 'The Dundies', 'https://www.youtube.com/watch?v=522lKp3QVDo', 21, '2005-09-20', 10),
  (20, 'Sexual Harassment', 'https://www.youtube.com/watch?v=522lKp3QVDo', 23, '2005-09-27', 10);
INSERT INTO EMPRESA (id, nombre, descripcion) VALUES
  (1, '20th Century Fox', 'Century Studios, anteriormente conocida como 20th Century Fox, es una de las principales productoras y distribuidoras de cine en el mundo. Fundada en 1935, ha sido responsable de la producción de una amplia gama de películas, desde clásicos de Hollywood hasta éxitos contemporáneos.'),
  (2, 'Marvel Studios', 'Marvel Entertainment es una subsidiaria de The Walt Disney Company y una de las mayores editoriales de cómics del mundo. Además de la publicación de cómics, Marvel es conocida por su vasto universo cinematográfico de superhéroes, que incluye películas de gran éxito como las de la serie Avengers.'),
  (3, 'Warner Bros. Pictures', 'Warner Bros. Pictures es una de las principales productoras y distribuidoras de cine en el mundo. Forma parte de Warner Bros. Entertainment, una de las mayores compañías de entretenimiento del mundo, y ha sido responsable de numerosas películas icónicas a lo largo de los años.'),
  (4, 'CBS Films', 'CBS Films es una división de CBS Corporation dedicada a la producción y distribución de películas. Ha producido una variedad de películas de diferentes géneros y ha sido conocida por sus colaboraciones con otros estudios y productores.'),
  (5, 'Piki Films', 'Piki Films es una productora cinematográfica con sede en Nueva Zelanda. Se ha destacado en la producción de películas independientes y de autor, con un enfoque en contar historias auténticas y originales.');

INSERT INTO R_CONTENIDO_EMPRESA (costo, duracion, id_contenido, id_empresa) VALUES
  (58.1, 1.18, 1, 1),
  (356.1, 7.2, 2, 2),
  (55.7, 0.1, 3, 3),
  (2.5, 1.4, 4, 4),
  (2.5, 1.5, 5, 5);

INSERT INTO PERSONA (id, nombre, apellido_paterno, apellido_materno, fecha_nacimiento, sexo, id_ciudad_residencia) VALUES
  (1, 'William Bradley', 'Pitt', '', '1963-12-18', 'M', 24),
  (2, 'Mary Louise', 'Streep', '', '1949-06-22', 'F', 25),
  (3, 'Leonardo Wilhelm', 'DiCaprio', '', '1974-11-11', 'M', 26),
  (4, 'Thomas Jeffrey', 'Hanks', '', '1956-07-09', 'M', 26),
  (5, 'Jennifer Shrader', 'Lawrence', '', '1990-08-15', 'F', 27),
  (6, 'Denzel Hayes', 'Washington', 'Jr.', '1954-12-28', 'M', 1),
  (7, 'Scarlett Ingrid', 'Johansson', '', '1984-11-22', 'F', 1),
  (8, 'Willard Carroll', 'Smith', 'Jr.', '1968-09-25', 'M', 28),
  (9, 'Julia Fiona', 'Roberts', '', '1967-10-28', 'F', 29),
  (10, 'Robert John', 'Downey', 'Jr.', '1965-04-04', 'M', 1),(11, 'Ryan', 'Reynolds', '', '1976-10-23', 'M', 2), -- Deadpool 2
  (12, 'Joshua', 'Brolin', '', '1972-02-12', 'M', 3), -- Deadpool 2
  (13, 'Morena', 'Baccarin', 'Teissott Franco', '1979-03-22', 'F', 4), -- Deadpool 2
  (14, 'Zazie', 'Beetz', '', '1991-05-25', 'F', 5), -- Deadpool 2
  (15, 'Timothy', 'Miller', '', '1982-06-04', 'M', 6), -- Deadpool 2
  (16, 'Brianna', 'Hildebrand', '', '1996-08-14', 'F', 7), -- Deadpool 2
  (17, 'Leslie', 'Uggams', 'Stephens', '1935-05-25', 'F', 8), -- Deadpool 2
  (18, 'Stefan', 'Kapičić', '.', '1978-08-17', 'M', 9), -- Deadpool 2
  (19, 'JJulian', 'Dennison', '', '2001-05-26', 'M', 10), -- Deadpool 2
  (20, 'Shiori', 'Kutsuna', '', '1988-12-22', 'F', 11),-- Deadpool 2(21, 'Matthew', 'McConaughey', NULL, '1969-11-04', 'M', 9),
  (22, 'Anne', 'Hathaway', NULL, '1982-11-12', 'F', 6),
  (23, 'Jessica', 'Chastain', NULL, '1977-03-24', 'F', 6),
  (24, 'Michael', 'Caine', NULL, '1933-03-14', 'M', 8),
  (25, 'Casey', 'Affleck', NULL, '1975-08-12', 'M', 1),
  (26, 'John', 'Lithgow', NULL, '1945-10-19', 'M', 1),
  (27, 'Topher', 'Grace', NULL, '1978-07-12', 'M', 1),
  (28, 'Ellen', 'Burstyn', NULL, '1932-12-07', 'F', 6),
  (29, 'David', 'Gyasi', NULL, '1980-01-02', 'M', 7),
  (30, 'Mackenzie', 'Foy', NULL, '2000-11-10', 'F', 1),(31, 'Emilia', 'Clarke', NULL, '1986-10-23', 'F', 15), -- Game of Thrones
  (32, 'Kit', 'Harington', NULL, '1986-12-26', 'M', 15), -- Game of Thrones
  (33, 'Peter', 'Dinklage', NULL, '1969-06-11', 'M', 25), -- Game of Thrones
  (34, 'Bryan', 'Cranston', NULL, '1956-03-07', 'M', 26), -- Breaking Bad
  (35, 'Aaron', 'Paul', NULL, '1979-08-27', 'M', 30), -- Breaking Bad
  (36, 'Anna', 'Gunn', NULL, '1968-08-11', 'F', 31), -- Breaking Bad
  (37, 'Jennifer', 'Aniston', NULL, '1969-02-11', 'F', 26), -- La Ley y El orden UV
  (38, 'Courteney', 'Cox', NULL, '1964-06-15', 'F', 32), -- La Ley y El orden UV
  (39, 'Matthew', 'Perry', NULL, '1969-08-19', 'M', 33), -- La Ley y El orden UV
  (40, 'Steve', 'Carell', NULL, '1962-08-16', 'M', 33), -- The Office (US)(41, 'Rainn', 'Wilson', NULL, '1966-01-20', 'M', 34), -- The Office (US)
  (42, 'John', 'Krasinski', NULL, '1979-10-20', 'M', 33), -- The Office (US)
  (43, 'Andrew', 'Lincoln', NULL, '1973-09-14', 'M', 15), -- The Walking Dead
  (44, 'Norman', 'Reedus', NULL, '1969-01-06', 'M', 6), -- The Walking Dead
  (45, 'Danai', 'Gurira', NULL, '1978-02-14', 'F', 35), -- The Walking Dead
  (46, 'Isai', 'Quispe', NULL, '2000-01-08', 'M', 36),
  (47, 'Eddy', 'Sejas', NULL, '2004-03-07', 'M', 36),
  (48, 'Jhonny', 'Fernandez', NULL, '2001-11-13', 'M', 36),
  (49, 'Eduardo', 'Kilibarda', NULL, '2002-09-25', 'M', 36),
  (50, 'Jhonathan', 'Quispe', NULL, '2002-11-10', 'M', 36);

INSERT INTO ACTOR (id_persona, id_ciudad_origen) VALUES
  (1, 24),
  (2, 25),
  (3, 26),
  (4, 26),
  (5, 27),
  (6, 1),
  (7, 1),
  (8, 28),
  (9, 29),
  (10, 1),
  (11, 2),
  (12, 3),
  (13, 4),
  (14, 5),
  (15, 6),
  (16, 7),
  (17, 8),
  (18, 9),
  (19, 10),
  (20, 11),
  (21, 9),
  (22, 6),
  (23, 6),
  (24, 8),
  (25, 1),
  (26, 1),
  (27, 1),
  (28, 6),
  (29, 7),
  (30, 1),
  (31, 15),
  (32, 15),
  (33, 25),
  (34, 26),
  (35, 30),
  (36, 31),
  (37, 26),
  (38, 32),
  (39, 33),
  (40, 33),
  (41, 34),
  (42, 33),
  (43, 15),
  (44, 6),
  (45, 35);

INSERT INTO R_CONTENIDO_ACTOR (nombre_artistico, rol, id_actor, id_contenido) VALUES
  ('Deadpool','Principal',11,1),
  ('Vanessa Carlysle','Principal',12,1),
  ('Thanos','Principal',13,2),
  ('Hombre de funeral','Cameo',14,2),
  ('Sophie Dumond','Secundario',15,3),
  ('un cameo','Cameo',16,3),
  ('Stella Nicholls','Principal',17,4),
  ('persona del fondo','Cameo',18,4),
  ('Ricky Baker','Principal',19,5),
  ('persona del fondo','Cameo',20,5);

INSERT INTO CUENTA (id_persona, correo, usuario, clave) VALUES
  (46, 'isaiQuis@outlook.com', 'ElQuispe',  'HolaMundo' ), 
 (47, 'eddysejas@gmail.com', 'EddyS',  'NewMaster' ),  
 (48, 'jhonnyfer@gmail.com', 'Joule',  'Contraseña' ),  
 (49, 'eduakil@outlook.com', 'EduardoKil',  'Elementos' ),  
 (50, 'jhonathanquis@hotmaill.com', 'Jhona',  'Programacion' );

INSERT INTO SUBCUENTA (id, id_cuenta, nombre, clave_acceso, activo) VALUES
  (1, 46, 'cuenta101', '1111', 1),
  (2, 46, 'cuenta102', '1133', 0),
  (3, 46, 'cuenta103', '1144', 0),
  (4, 47, 'cuenta201', '2211', 0),
  (5, 47, 'cuenta202', '2222', 1),
  (6, 47, 'cuenta203', '2233', 0),
  (7, 48, 'cuenta301', '3311', 0),
  (8, 48, 'cuenta302', '3322', 0),
  (9, 48, 'cuenta303', '3333', 1),
  (10, 49, 'cuenta401', '4411', 0),
  (11, 49, 'cuenta402', '4422', 1),
  (12, 49, 'cuenta403', '4433', 0),
  (13, 50, 'cuenta501', '5511', 1),
  (14, 50, 'cuenta502', '5522', 0),
  (15, 50, 'cuenta503', '5533', 0);

INSERT INTO TELEFONO   (id, codigo_pais, numero, id_cuenta) VALUES
  (1, 591, 71764495, 46),
  (2, 591, 70762346, 47),
  (3, 591, 78764557, 47),
  (4, 591, 71776543, 48),
  (5, 591, 77764900, 48),
  (6, 591, 76761222, 49),
  (7, 591, 79778788, 49),
  (8, 591, 71761258, 50),
  (9, 591, 71715154, 50),
  (10, 591, 71769696, 50);

INSERT INTO PAQUETE   (id, tipo, descripcion, duracion) VALUES 
  (1, 'personal', 'El paquete consta de una subcuenta y dura 4 semanas con 2 días', 4.2),
  (2, 'duo', 'El paquete consta de dos subcuentas y dura 4 semanas y 2 días', 4.2),  
  (3, 'familiar', 'El paquete consta de tres subcuentas y dura 4 semanas y 2 días', 4.2),
  (4, 'personal', 'El paquete consta de una subcuenta y dura 25 semanas y 5 días', 25.5),
  (5, 'duo', 'El paquete consta de dos subcuentas y dura 25 semanas y 5 días', 25.5),  
  (6, 'familiar', 'El paquete consta de tres subcuentas y dura 25 semanas y 5 días', 25.5),
  (7, 'personal', 'El paquete consta de una subcuenta y dura 52 semanas y 1 día', 52.1),
  (8, 'duo', 'El paquete consta de dos subcuentas y dura 52 semanas y 1 día', 52.1),
  (9, 'familiar', 'El paquete consta de tres subcuentas y dura 52 semanas y 1 día', 52.1);

INSERT INTO FORMA_PAGO   (id, monto) VALUES
  (1, 30),
  (2, 30),
  (3, 30),
  (4, 30),
  (5, 300),
  (6, 160),
  (7, 30),
  (8, 30),
  (9, 160),
  (10, 300);

INSERT INTO CREDITO   (id_forma_pago, fecha_inicio, fecha_fin, multa, frecuencia_pago) VALUES
  (5, '2024-04-23', '2025-04-23', 0.05, 'anual'),
  (5, '2024-04-23', '2024-10-23', 0.03, 'semestral'),
  (6, '2024-04-23', '2024-10-23', 0.02, 'semestral'),
  (10, '2024-04-23', '2025-04-23', 0.07, 'anual'),
  (10, '2024-04-23', '2024-10-23', 0.05, 'semestral');

INSERT INTO CONTADO   (id_forma_pago, descuento) VALUES
  (1, 0),
  (2, 0),
  (3, 0),
  (4, 0),
  (7, 0),
  (8, 0);

INSERT INTO SUSCRIPCION   (id, fecha_adquisicion, fecha_fin, id_paquete, id_cuenta, id_forma_pago) VALUES
  (1, '2023-01-01', '2023-02-01', 1, 46, 1),
  (2, '2023-01-15', '2023-02-15', 2, 47, 2), 
  (3, '2023-01-20', '2023-02-20', 3, 48, 3),
  (4, '2023-01-23', '2023-02-23', 1, 49, 4),
  (5, '2023-02-07', '2024-02-07', 9, 50, 5),
  (6, '2023-02-12', '2023-08-12', 5, 46, 6), 
  (7, '2023-02-18', '2023-03-18', 2, 47, 7),
  (8, '2023-02-20', '2023-03-20', 3, 48, 8),
  (9, '2023-03-19', '2023-09-19', 4, 46, 9),
  (10, '2023-04-12', '2024-04-12',8, 48, 10);
 INSERT INTO VISUALIZACION (id_subcuenta, id_contenido) VALUES
  (1, 2),   -- Subcuenta ID 1 viendo Avengers: Endgame (ID de contenido 2),
  (2, 3),   -- Subcuenta ID 2 viendo Joker (ID de contenido 3),
  (3, 4),   -- Subcuenta ID 3 viendo Scary Stories to Tell in the Dark (ID de contenido 4)
  (4, 6),   -- Subcuenta ID 4 viendo Game of Thrones (ID de contenido 6)
  (5, 7),   -- Subcuenta ID 5 viendo Breaking Bad (ID de contenido 7)
  (6, 8),   -- Subcuenta ID 6 viendo The Walking Dead (ID de contenido 8)
  (7, 9),   -- Subcuenta ID 7 viendo Friends (ID de contenido 9)
  (8, 10);  -- Subcuenta ID 8 viendo The Office (ID de contenido 10) 





  ROLLBACK;