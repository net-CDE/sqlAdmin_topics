CREATE VIEW dbo.vw_Logins_cross_ServerRoles
AS
SELECT sp.name
     , MAX(CASE WHEN rm.role_principal_id =  3 THEN 1 END)  as  sysadmin       
     , MAX(CASE WHEN rm.role_principal_id =  4 THEN 1 END)  as  securityadmin  
     , MAX(CASE WHEN rm.role_principal_id =  5 THEN 1 END)  as  serveradmin    
     , MAX(CASE WHEN rm.role_principal_id =  6 THEN 1 END)  as  setupadmin     
     , MAX(CASE WHEN rm.role_principal_id =  7 THEN 1 END)  as  processadmin   
     , MAX(CASE WHEN rm.role_principal_id =  8 THEN 1 END)  as  diskadmin      
     , MAX(CASE WHEN rm.role_principal_id =  9 THEN 1 END)  as  dbcreator      
     , MAX(CASE WHEN rm.role_principal_id = 10 THEN 1 END)  as  bulkadmin      
FROM  sys.server_principals   AS sr            
JOIN  sys.server_role_members AS rm            
ON    sr.principal_id = rm.role_principal_id   
JOIN  sys.server_principals AS sp              
ON    rm.member_principal_id = sp.principal_id 
GROUP BY  sp.name                              
--  end  VIEW                                  
