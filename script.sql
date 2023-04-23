DROP DATABASE IF EXISTS desafio3-larissonrivero-504; -- Elimina la database si existe
CREATE DATABASE "desafio3-larissonrivero-504"; -- Crea la database 
\c desafio3-larissonrivero-504; -- Conecta a la database

CREATE TABLE usuarios ( -- Crea la tabla users
    id SERIAL,
    email VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    rol VARCHAR
);

--Cargar los Datos a la tabla usuarios
INSERT INTO usuarios (email, nombre, apellido, rol) VALUES ('larissonrivero@gmail.com', 'larisson', 'rivero', 'administrador');
INSERT INTO usuarios (email, nombre, apellido, rol) VALUES ('lennymolleja@gmail.com', 'lenny', 'molleja', 'usuario');
INSERT INTO usuarios (email, nombre, apellido, rol) VALUES ('analiarivero@gmail.com', 'analia', 'rivero', 'usuario');
INSERT INTO usuarios (email, nombre, apellido, rol) VALUES ('anahisrivero@gmail.com', 'anahis', 'rivero', 'usuario');
INSERT INTO usuarios (email, nombre, apellido, rol) VALUES ('ramonaoviedo@gmail.com', 'ramona', 'oviedo', 'usuario');

CREATE TABLE posts ( -- Crea la tabla posts
    id SERIAL,
    titulo VARCHAR(50),
    contenido TEXT,
    fecha_creacion TIMESTAMP NOT NULL,
    fecha_actualizacion TIMESTAMP,
    destacado BOOLEAN,
    usuario_id BIGINT
);

--Cargar los Datos a la tabla post
INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('titulo1', 'contenido1', '2023-04-20 16:14:25', '2023-04-20 16:14:25', 'true', '1');
INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('titulo2', 'contenido2', '2023-04-20 16:14:25', '2023-04-20 16:14:25', 'true', '1');
INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('titulo3', 'contenido3', '2023-04-20 16:14:25', '2023-04-20 16:14:25', 'true', '3');
INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('titulo4', 'contenido4', '2023-04-20 16:14:25', '2023-04-20 16:14:25', 'true', '4');
INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES ('titulo5', 'contenido5', '2023-04-20 16:14:25', '2023-04-20 16:14:25', 'true', '5');

CREATE TABLE comentarios ( -- Crea la tabla comentarios
    id SERIAL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL,
    usuario_id BIGINT,
    posts_id BIGINT
);

--Cargar los Datos a la tabla comentarios
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, posts_id) VALUES ('comentario1', '2023-04-20 16:14:25', '1', '1');
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, posts_id) VALUES ('comentario2', '2023-04-20 16:14:25', '1', '2');
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, posts_id) VALUES ('comentario3', '2023-04-20 16:14:25', '1', '3');
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, posts_id) VALUES ('comentario4', '2023-04-20 16:14:25', '2', '1');
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, posts_id) VALUES ('comentario5', '2023-04-20 16:14:25', '2', '2');

--REQUERIMIENTOS;
--1. Crea y agrega al entregable las consultas para completar el setup de acuerdo a lo pedido

--2. Cruza los datos de la tabla usuarios y posts mostrando las siguientes columnas nombre e email del usuario junto al título y contenido del post:
SELECT nombre, email, titulo, contenido FROM usuarios INNER JOIN posts ON usuarios.id = posts.usuario_id;

--3. Muestra el id, título y contenido de los posts de los administradores. El administrador puede ser cualquier id y debe ser seleccionado dinámicamente:
SELECT id, titulo, contenido FROM posts WHERE usuario_id = 1;

--4. Cuenta la cantidad de posts de cada usuario. La tabla resultante debe mostrar el id e email del usuario junto con la cantidad de posts de cada usuario:
SELECT usuarios.id, usuarios.email, COUNT(posts.id) AS cantidad_posts FROM usuarios INNER JOIN posts ON usuarios.id = posts.usuario_id GROUP BY usuarios.id, usuarios.email;

--5. Muestra el email del usuario que ha creado más posts. Aquí la tabla resultante tiene un único registro y muestra solo el email:
SELECT email FROM usuarios INNER JOIN posts ON usuarios.id = posts.usuario_id GROUP BY usuarios.email ORDER BY COUNT(posts.id) DESC LIMIT 1;

--6. Muestra la fecha del último post de cada usuario:(muestra todos los usuarios debido a que al momento de cargar los datso se le asigno a todos la misma fecha)
SELECT usuarios.id, usuarios.email, MAX(posts.fecha_creacion) AS fecha_ultimo_post FROM usuarios INNER JOIN posts ON usuarios.id = posts.usuario_id GROUP BY usuarios.id, usuarios.email;

--7. Muestra el título y contenido del posts (artículo) con más comentarios:
SELECT posts.titulo, posts.contenido, COUNT(comentarios.id) AS cantidad_comentarios FROM posts INNER JOIN comentarios ON posts.id = comentarios.posts_id GROUP BY posts.titulo, posts.contenido ORDER BY cantidad_comentarios DESC LIMIT 1;

--8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido de cada comentario asociado a los posts mostrados, junto con el email del usuario que lo escribió:
SELECT posts.titulo, posts.contenido, comentarios.contenido, usuarios.email FROM posts INNER JOIN comentarios ON posts.id = comentarios.posts_id INNER JOIN usuarios ON comentarios.usuario_id = usuarios.id;

--9. Muestra el contenido del último comentario de cada usuario:
SELECT usuarios.id, usuarios.email, comentarios.contenido FROM usuarios INNER JOIN comentarios ON usuarios.id = comentarios.usuario_id GROUP BY usuarios.id, usuarios.email, comentarios.contenido ORDER BY comentarios.fecha_creacion DESC LIMIT 1;

--10. Muestra los emails de los usuarios que no han escrito ningún comentario:
SELECT usuarios.email FROM usuarios LEFT JOIN comentarios ON usuarios.id = comentarios.usuario_id WHERE comentarios.usuario_id IS NULL;
