USE Verlag

DECLARE @Login sysname = '[SQLlogin__LSrv__mAz__testfabrik-verlag]'

DECLARE @sqlCmd        nvarchar(4000)

-- new databaseUser:
SET @sqlCmd = 
  N'  CREATE USER '   -- '  ' blanks are mandatory 
+     @Login
+ N'  FROM LOGIN '
+     @Login

--select @sqlCmd 
EXEC sp_executeSQL @sqlCmd

-- verify
-- SELECT *
-- FROM   sys.database_principals
-- WHERE  type_desc = 'SQL_USER'

-- add to Role [db_owner]
SET @sqlCmd = 
  N'  ALTER ROLE [db_owner] '   -- '  ' blanks are mandatory 
+ N'  ADD MEMBER '
+     @Login

--select @sqlCmd 
EXEC sp_executeSQL @sqlCmd

-- RETURN
SELECT @@SERVERNAME   as 'ServerName'
     , @Login         as 'Login'
     , ' copy both values for next steps ...'   as '!! info'
----  end  ----
