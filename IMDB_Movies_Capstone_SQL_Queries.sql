-- PHASE:1 (SQL Problem Queries)

use project_movie_database;
show tables;

-- a)	Can you get all data about movies? 
select*from movies;

-- b)	How do you get all data about directors?
select*from directors;

-- c)	Check how many movies are present in IMDB.
select count(*) as total_movies from movies;

-- d)	Find these 3 directors: James Cameron ; Luc Besson ; John Woo
select*from directors
where name in('james cameron', 'luc besson', 'john woo');

-- e)	Find all directors with name starting with S.
select*from directors
where name like 'S%';

-- f)	Count female directors.
select count(*) as female_directors from directors
where gender =1;

-- g)	Find the name of the 10th first women directors?

select * from directors 
where gender = 1 order by id asc limit 1 offset 9;

-- h)	What are the 3 most popular movies?
select original_title, popularity from movies
order by popularity desc
limit 3;

-- i)	What are the 3 most bankable movies?

select original_title, (revenue - budget) as profit from movies
order by profit desc
limit 3;

-- j)	What is the most awarded average vote since the January 1st, 2000?
select original_title, vote_average, release_date from movies
where release_date >= '2000-01-01'
order by vote_average desc
limit 1; 

-- k)	Which movie(s) were directed by Brenda Chapman?

select * from directors
where name = 'Brenda Chapman';

select id, original_title, director_id
from movies
where director_id = 4801;

select count(*) as total_movies,
       count(director_id) as movies_with_director
from movies;

select id, original_title, director_id
from movies
where director_id = 59803;

select distinct director_id
from movies
order by director_id;

select id, name
from directors
where id between 4762 and 4801
order by id;

select d.id, d.name, m.original_title, m.director_id
from directors d
left join movies m
    on d.id = m.director_id
where d.id between 4762 and 4801
order by d.id;
-- DATA NOT AVAILABLE / NO MATCH

-- l)	Which director made the most movies?
select director_id, count(*) as movie_count
from movies
group by director_id
order by movie_count desc
limit 1;

SELECT id, name
FROM directors
WHERE id = 4777;

-- m)	Which director is the most bankable?

SELECT d.name, SUM(m.revenue - m.budget) AS total_profit
FROM movies m
JOIN directors d ON m.director_id = d.id
GROUP BY d.id, d.name
ORDER BY total_profit DESC
LIMIT 1;

-- PHASE:2 (Get the actual dataset out of SQL)
-- SQL Data Export
    
select
    count(*) as total_rows,
    count(distinct m.id) as unique_movies
from movies m
left join directors d
    on m.director_id = d.id;
    
    
select
    m.id as movie_id,
    m.original_title,
    m.budget,
    m.popularity,
    m.release_date,
    m.revenue,
    m.title,
    m.vote_average,
    m.vote_count,
    m.overview,
    m.tagline,
    m.uid as movie_uid,
    d.id as director_id,
    d.name as director_name,
    d.gender as director_gender,
    d.uid as director_uid,
    d.department
from movies m
left join directors d
    on m.director_id = d.id;

select count(*) as total_rows
from (
    select
        m.id as movie_id,
        d.id as director_id
    from movies m
    left join directors d
        on m.director_id = d.id
) as final_dataset;
