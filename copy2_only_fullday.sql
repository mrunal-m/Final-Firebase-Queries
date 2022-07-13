--Only Events Full day

MERGE `maximal-furnace-783.data_platform_temp1.test3_session_time_hourly` t USING
    (with t1 as 
(
select * except(event_timestamp), event_timestamp from `sharechat-firebase.analytics_163194662.events_*`, UNNEST(event_params) as evt_prms
	where evt_prms.key = 'engagement_time_msec'
    and app_info.id in ('in.mohalla.sharechat', 'in.mohalla.video', 'in.mohalla.video.lite')
		and user_id is not null
    AND _table_suffix NOT LIKE '%intraday_%'
    and parse_DATE("%Y%m%d", SUBSTR(_table_suffix, 1)) IN ("2022-07-08", "2022-07-09", "2022-07-10") 
),

t2 as 
(select 
    timestamp_millis(cast(event_timestamp/1000-(select evt_prms.value.int_value from UNNEST(event_params) as evt_prms where evt_prms.key = 'engagement_time_msec') as int64)) event_start_time,
    (select user.value.string_value from UNNEST(user_properties) as user where user.key = 'android_device_id') as deviceid,
    user_id as user_id,
    (select evt_prms.value.int_value from UNNEST(event_params) as evt_prms where evt_prms.key = 'ga_session_id') as ga_session_id,
    (select evt_prms.value.int_value from UNNEST(event_params) as evt_prms where evt_prms.key = 'ga_session_number') as ga_session_number,

    app_info.id as app_id,
		event_timestamp-1000*(select evt_prms.value.int_value from UNNEST(event_params) as evt_prms where evt_prms.key = 'engagement_time_msec') as event_start_timestamp,
    (select evt_prms.value.int_value from UNNEST(event_params) as evt_prms where evt_prms.key = 'engagement_time_msec') as time_spent_millis,
    event_server_timestamp_offset
	from t1)
  
  select distinct * from t2 
  where time_spent_millis > 0
  and date(event_start_time) IN ("2022-07-08", "2022-07-09", "2022-07-10") )  AS s  

--event_start_time, user_id, device_id, ga_session_id, ga_session_number

ON false
--source = query
--target = session_time_hourly
WHEN NOT MATCHED BY SOURCE AND date(event_start_time) IN ("2022-07-08", "2022-07-09", "2022-07-10")  THEN DELETE
WHEN NOT MATCHED BY TARGET THEN
insert
(event_start_time, deviceid, user_id, ga_session_id, ga_session_number, app_id, event_start_timestamp, time_spent_millis, event_server_timestamp_offset)
values
(event_start_time, deviceid, user_id, ga_session_id, ga_session_number, app_id, event_start_timestamp, time_spent_millis, event_server_timestamp_offset)

