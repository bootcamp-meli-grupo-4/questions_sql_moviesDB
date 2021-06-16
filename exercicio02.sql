/* 1 - Explique o conceito de normalização e para que é usado.
 R: Normalizacao é utilizado como um processo de padronizacao validacao de dados que visa eliminar inconsistencias e pelo minimizar ao maximo a redundancia do banco. 
	É utilizado no processo de modelagem de banco de dados.
*/
-- 2 - Adicione um filme à tabela de filmes.
INSERT INTO movies (created_at, updated_at, title, rating, awards, release_date, length, genre_id) 
values('2021-01-02', '2021-02-01', 'Movie 2', 60, 5, '2021-01-04', 60, 1);

-- 3 - Adicione um gênero à tabela de gêneros.
INSERT INTO `movies_db`.`genres` (`created_at`, `name`, `ranking`, `active`) VALUES ('2021-06-21', 'Documentario 2', '2', '13');

-- 4 - Associe o filme do Ex 2. ao gênero criado no Ex. 3.
UPDATE `movies_db`.`movies` SET `genre_id` = '14' WHERE (`id` = '22');

-- 5 - Modifique a tabela de atores para que pelo menos um ator tenha como favorito o filme
UPDATE `movies_db`.`actors` SET `favorite_movie_id` = 14 WHERE id <> 0;
ALTER TABLE actors
MODIFY COLUMN favorite_movie_id INT NOT NULL;

-- 6 - Crie uma cópia temporária da tabela de filmes.
CREATE TEMPORARY TABLE movies_temporary AS (SELECT * FROM movies);

-- 7 - Elimine desta tabela temporária todos os filmes que ganharam menos de 5 prêmios.
DELETE FROM movies_temporary WHERE awards < 5;

-- 8 - Obtenha a lista de todos os gêneros que possuem pelo menos um filme.
SELECT COUNT(genre_id) AS qtd, name FROM genres 
LEFT JOIN movies on genres.id = movies.genre_id
GROUP BY name
HAVING qtd > 0;

-- 9 - Obtenha a lista de atores cujo filme favorito ganhou mais de 3 prêmios.
SELECT * FROM actors 
INNER JOIN movies on actors.favorite_movie_id = movies.id
WHERE movies.awards > 3; 

-- 10 - Use o plano de execução para analisar as consultas nos Ex 6 e 7.
EXPLAIN SELECT * FROM movies;
EXPLAIN DELETE FROM movies_temporary WHERE awards < 5;

/* 11 - O que são os índices? Para que servem?
   R: Um recurso para otimizar consultas ao banco. É uma forma de criarmos atributos unicos.
*/

-- 12 - Crie um índice sobre o nome na tabela de filmes.
ALTER TABLE `movies_db`.`movies` 
ADD INDEX `title_indice` (`title` ASC) VISIBLE;

-- 13 - Verifique se o índice foi criado corretamente.
SHOW INDEX FROM movies WHERE key_name = 'title_indice';
