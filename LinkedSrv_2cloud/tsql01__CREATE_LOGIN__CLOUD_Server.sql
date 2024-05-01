-- connect to 
-- Server:  testfabrik-verlag.database.windows.net
-- check...
-- SELECT @@SERVERNAME

--       SQLlogin__LSrv__mAz__server01  ..  der DB_Name entfällt, der SQLlogin_LSrv...  "bedient" alle DBs
-- pwd:  Pa$$w0rd__LSrv__mAz__server01__>hex12.guid<__202402
--       Pa$$w0rd__LSrv__mAz__server01__04e9b71cc1c6__202402
-- SELECT 'Pa$$w0rd__' + 'LSrv__mAz__server01' + '__' + LOWER(LEFT(REPLACE( NewID(), '-', ''), 12)) + '__' + Format(GetDate(), 'yyyyMM')


DECLARE @ServerName    sysname = 'testfabrik-verlag'
      , @DatabaseName  sysname = 'Verlag'
      , @CloudProvider sysname = 'MicrosoftAzure'  -- [ mAz.MicrosoftAzure | aws | gcp.GoogleCloudPlatform ]

DECLARE @sqlCmd        nvarchar(4000)
      , @Login         sysname 
      , @pwdString     sysname = 'Pa$$w0rd__' + 'LSrv__mAz__' + @ServerName + '__' + LOWER(LEFT(REPLACE( NewID(), '-', ''), 12)) + '__' + Format(GetDate(), 'yyyyMM')

SET @Login       = QUOTENAME( 'SQLlogin__LSrv__'
                              + 'mAz'   --  @CloudProvider = [ mAz.MicrosoftAzure | aws | gcp.GoogleCloudPlatform ]
                              + '__'
                              + @ServerName
                            )
SET @pwdString   = N'Pa$$w0rd__LSrv__' 
                 + 'mAz'   --  @CloudProvider = [ mAz.MicrosoftAzure | aws | gcp.GoogleCloudPlatform ]
                 + '__'
                 + @ServerName 
                 + '__' + LOWER(LEFT(REPLACE( NewID(), '-', ''), 12)) 
                 + '__' + Format(GetDate(), 'yyyyMM')

-- new Login:
SET @sqlCmd = 
  N'  CREATE LOGIN '   -- '  ' blanks are mandatory
+     @Login
+ N'  WITH PASSWORD = '''
+     @pwdString
+ N''' '

--select @sqlCmd 
EXEC sp_executeSQL @sqlCmd

-- verify
-- SELECT *
-- FROM   sys.server_principals

-- RETURN
SELECT @@SERVERNAME   as 'ServerName'
     , @Login         as 'Login'
     , @pwdString     as 'Password'
     , ' keep all values for next steps ...'   as '!! info'
----  end  ----
