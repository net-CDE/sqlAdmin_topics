CREATE OR ALTER PROC [dbo].[usp_create_copyFullBackup_4migration]
      @databaseName  sysname       = 'model'             
    , @networkShare  nvarchar(400) = '\\serverName\share'
    , @subFolder     nvarchar(100) = 'subFolder'         
AS
BEGIN

DECLARE @sqlCmd      nvarchar(4000)
      , @backupDate  nvarchar(8)

SET @backupDate = Format( GetDate(), 'yyyyMMdd' )
----select @backupDate

SET @sqlCmd =                            
  N'  BACKUP DATABASE ' + @databaseName  
+ N'  TO DISK = N''' + @networkShare     
+               N'\' + @subFolder        
+               N'\' + @databaseName     
+               N'__copyFull_' + @backupDate + '_4migration.bak''  '
+ N'  WITH                                                         '
+ N'    COPY_ONLY                                                  '     -- !! to keep CommVault backup-chain
+ N'  , NO_COMPRESSION                                             '
+ N'  , NOFORMAT, NOINIT                                           '
+ N'  , NAME = N''copy Database Backup 4migration''                '
+ N'  , SKIP, NOREWIND, NOUNLOAD,  STATS = 5                       '

----select @sqlCmd  -- check
EXEC sp_executesql @sqlCmd  

END  --  end PROC
