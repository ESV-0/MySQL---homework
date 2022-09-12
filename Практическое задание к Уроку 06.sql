-- ПЗ к Уроку 06

-- 1.   Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения

-- 2.	Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
USE vk;
 SELECT
    from_user_id
    , COUNT(*) as send 
FROM messages 
WHERE to_user_id=1
GROUP BY from_user_id
ORDER BY send DESC;
 
-- 3.	Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
-- Типы для лайков
SELECT * FROM target_types;
-- Выбираем профили с сортировкой по дате рождения
SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10;
-- Выбираем количество лайков
SELECT 
  (SELECT COUNT(*)
  FROM likes 
  WHERE target_id = profiles.user_id
	AND target_type_id = 2
  ) AS likes_total  
FROM profiles 
ORDER BY birthday DESC
LIMIT 10;
-- Подбиваем сумму внешним запросом
SELECT SUM(likes_total) FROM  
  (SELECT 
    (SELECT COUNT(*) FROM likes WHERE target_id = profiles.user_id AND target_type_id = 2) AS likes_total  
    FROM profiles 
    ORDER BY birthday 
    DESC LIMIT 10) AS user_likes
;  

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender
FROM likes; 
-- Группируем и сортируем
SELECT
	(SELECT gender
    FROM profiles
    WHERE user_id = likes.user_id
    ) AS gender,
	COUNT(*) AS total
FROM likes
GROUP BY gender
ORDER BY total DESC
LIMIT 1;  

  -- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.     
SELECT 
  name, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
FROM users
ORDER BY overall_activity
LIMIT 10;