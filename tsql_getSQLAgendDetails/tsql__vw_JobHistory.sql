CREATE VIEW [audit].[vw_JobHistory]
AS 

SELECT @@SERVERNAME   as 'Servername'  
     , J.name         as 'Jobname'
     , H.*
     , CASE	                                           
          WHEN  H.run_status  = 0  THEN  'Failed'      
          WHEN  H.run_status  = 1  THEN  'Succeeded'   
          WHEN  H.run_status  = 2  THEN  'Retry'       
          WHEN  H.run_status  = 3  THEN  'Canceled'    
          WHEN  H.run_status  = 4  THEN  'In Progress' 
          ELSE                            NULL         
       END            as 'run_status_desc'             
FROM   msdb.dbo.sysjobs J         
JOIN   msdb.dbo.sysjobhistory H   
ON     J.job_id = H.job_id        
WHERE  J.name like 'job_proj%'    
  and  H.run_status <> 1          

-- end view
GO
