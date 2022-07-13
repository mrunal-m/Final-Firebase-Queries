--Comparing hourly numbers actual session_time_hourly
SELECT TIMESTAMP_TRUNC(event_start_time, HOUR) as hour, 
COUNT (*) as rowCount
from maximal-furnace-783.feed_pod_data.session_time_hourly
WHERE date(event_start_time) = "2022-07-09"
GROUP BY 1
ORDER BY 1

--Comparing hourly numbers for us
SELECT TIMESTAMP_TRUNC(event_start_time, HOUR) as hour, 
COUNT (*) as rowCount
from maximal-furnace-783.data_platform_temp1.test3_session_time_hourly
WHERE date(event_start_time) = "2022-07-09"
GROUP BY 1
ORDER BY 1

