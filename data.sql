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
  (10, 'The Office', 'https://images.app.goo.gl/R7JUtUrDiHTaPzbo8', 1, 3);

INSERT INTO PELICULAS (id_contenido, duracion, link_video) VALUES
  (1, 1.48, 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdg'),
  (2, 3.02, 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdg'),
  (3, 2.2, 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdg'),
  (4, 1.51, 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdg'), 
  (5, 1.41, 'https://youtu.be/6Kb7a8ASs8M?si=oRm6hQ-wyx2gXUdg'); 

INSERT INTO VISUALIZACION (id_subcuenta, id_contenido) VALUES
  (1, 2),   -- Subcuenta ID 1 viendo Avengers: Endgame (ID de contenido 2),
  (2, 3),   -- Subcuenta ID 2 viendo Joker (ID de contenido 3),
  (3, 4),   -- Subcuenta ID 3 viendo Scary Stories to Tell in the Dark (ID de contenido 4)
  (4, 6),   -- Subcuenta ID 4 viendo Game of Thrones (ID de contenido 6)
  (5, 7),   -- Subcuenta ID 5 viendo Breaking Bad (ID de contenido 7)
  (6, 8),   -- Subcuenta ID 6 viendo The Walking Dead (ID de contenido 8)
  (7, 9),   -- Subcuenta ID 7 viendo Friends (ID de contenido 9)
  (8, 10);  -- Subcuenta ID 8 viendo The Office (ID de contenido 10)