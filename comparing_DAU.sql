--DAU comparison queries

-- For Real session_time_hourly
SELECT date(event_start_time) as date, app_id, COUNT(DISTINCT(user_id)) as DAU
from maximal-furnace-783.feed_pod_data.session_time_hourly
WHERE date(event_start_time) in ('2022-07-08', '2022-07-09', '2022-07-10')
GROUP BY 1, 2
ORDER BY 1, 2 DESC

-- For Our Version test3_session_time_hourly
SELECT date(event_start_time) as date, app_id, COUNT(DISTINCT(user_id)) as DAU
from maximal-furnace-783.data_platform_temp1.test3_session_time_hourly
WHERE date(event_start_time) in ('2022-07-08', '2022-07-09', '2022-07-10')
GROUP BY 1, 2
ORDER BY 1, 2 DESC

