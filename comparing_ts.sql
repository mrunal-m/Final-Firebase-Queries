--Calculating TS for Actual session_time_hourly
SELECT date(event_start_time), app_id, (SUM(time_spent_millis)/(1000*60*60)) as timespent_hr
from maximal-furnace-783.feed_pod_data.session_time_hourly
WHERE date(event_start_time) IN ("2022-07-08", "2022-07-09", "2022-07-10") 
GROUP BY 1, 2
ORDER BY 1, 2 DESC


--Calculating TS for Our test3_session_time_hourly
SELECT date(event_start_time), app_id, (SUM(time_spent_millis)/(1000*60*60)) as timespent_hr
from maximal-furnace-783.data_platform_temp1.test3_session_time_hourly
WHERE date(event_start_time) IN ("2022-07-08", "2022-07-09", "2022-07-10") 
GROUP BY 1, 2
ORDER BY 1, 2 DESC
