CREATE VIEW [dbo].[vw_Database_last_Backuptime]      
AS
SELECT @@SERVERNAME                 as 'Servername'  
     , db.name                      as 'DatabaseName'
     , db.recovery_model_desc 
     , db.is_read_only        
     , db.database_id         
     , bs.type                      as 'backup_type'          
     , CASE                                                   
          WHEN bs.type = 'D'  THEN 'Database'                 
          WHEN bs.type = 'I'  THEN 'Differential database'    
          WHEN bs.type = 'L'  THEN 'Log'                      
          WHEN bs.type = 'F'  THEN 'File or filegroup'        
          WHEN bs.type = 'G'  THEN 'Differential file'        
          WHEN bs.type = 'P'  THEN 'Partial'                  
          WHEN bs.type = 'Q'  THEN 'Differential partial'     
          ELSE                      NULL                      
       END                          as 'backup_type_desc'     
       ----  https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/backupset-transact-sql
     , MAX(bs.backup_finish_date)   as 'last_db_backup_date'  
FROM   sys.databases db        
left   join                    
       msdb.dbo.backupset bs   
ON     db.name                 = bs.database_name  
  and  db.recovery_model_desc  = bs.recovery_model 
GROUP  by                      
       db.name                 
     , db.recovery_model_desc  
     , db.is_read_only         
     , db.database_id          
     , bs.type                 
--  end VIEW
GO