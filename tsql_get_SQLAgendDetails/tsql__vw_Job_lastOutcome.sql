CREATE VIEW [audit].[vw_Job_lastOutcome]
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
SELECT distinct
       ROW_NUMBER() over 
       (Order by @@SERVERNAME, J.Jobname)      as 'rowNr'       
     , @@SERVERNAME                            as 'Servername'  
     , J.Jobname    
     , H.instance_id    
     , H.run_date   
     , H.run_time   
     , COALESCE(D.step_name, '')               as 'Stepname'       
     , CASE                                                        
          WHEN H.run_status <> 1   THEN  CAST(D.step_id as char(3))
          ELSE                           ''                        
       END                                     as 'StepId'         
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
join   msdb.dbo.sysjobhistory H 
ON     J.job_id          = H.job_id     
  and  J.max_instance_id = H.instance_id
left   join   
       msdb.dbo.sysjobhistory D  -- Step-Details
ON     D.job_id     =  H.job_id
 and   D.run_date   >= H.run_date
 and   D.run_time   >= H.run_time
 and   D.run_status =  0
WHERE  1=1

-- end view
GO
