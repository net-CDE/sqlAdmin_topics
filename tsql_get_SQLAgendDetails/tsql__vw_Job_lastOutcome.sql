CREATE VIEW audit.vw_Job_lastOutcome
AS

WITH
SubQuery as
(
SELECT J.job_id 
     , J.name               as 'Jobname'         
     , max(H.instance_id)   as 'max_instance_id' 
FROM   msdb.dbo.sysjobs J         
JOIN   msdb.dbo.sysjobhistory H   
ON     J.job_id = H.job_id   
GROUP  by 
       J.job_id
     , J.name
)
SELECT ROW_NUMBER() over (Order by J.Jobname)  as 'rowNr'
     , @@SERVERNAME   as 'Servername'  
     , J.Jobname                       
     , H.instance_id                   
     , H.run_date                      
     , H.run_time                      
--   , CAST(H.run_date as bigint) * 1000000                     
--   + CAST(H.run_time as bigint)             as 'run_date_time'
     , H.step_id   
     , H.run_status
     , CASE	                                           
          WHEN  H.run_status  = 0  THEN  'Failed'      
          WHEN  H.run_status  = 1  THEN  'Succeeded'   
          WHEN  H.run_status  = 2  THEN  'Retry'       
          WHEN  H.run_status  = 3  THEN  'Canceled'    
          WHEN  H.run_status  = 4  THEN  'In Progress' 
          ELSE                            NULL         
       END            as 'run_status_desc'             
FROM   SubQuery J                       
JOIN   msdb.dbo.sysjobhistory H         
ON     J.job_id          = H.job_id     
  and  J.max_instance_id = H.instance_id

-- end view
GO
