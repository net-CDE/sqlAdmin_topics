CREATE VIEW [audit].[vw_JobHistory]
AS 

SELECT @@SERVERNAME    as 'Servername'  
     , J.name          as 'Jobname'     
     , H.*
FROM   msdb.dbo.sysjobs J         
JOIN   msdb.dbo.sysjobhistory H   
ON     J.job_id = H.job_id        
WHERE  J.name like 'job_proj%'    
  and  H.run_status <> 1          
                        --  0 = Failed       
                        --  1 = Succeeded    
                        --  2 = Retry        
                        --  3 = Canceled     
                        --  4 = In Progress  
-- end view 
GO