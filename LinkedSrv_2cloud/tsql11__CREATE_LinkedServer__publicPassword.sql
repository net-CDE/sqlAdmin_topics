USE [master]
GO

-- Naming-Schema:
-- LSrv__mAz__Sql__testfabrik-verlag__Verlag
--       ^^^     -->   [ mAz.MicrosoftAzure | aws | gcp.GoogleCloudPlatform ]
--            ^^^ -->  [ Sql | Syn.apse | Cos.mos | ... ]
--                 ServerName
--                                    DatabaseName  
--    "__" = seperator
-- **************************************************************************
SELECT @@SERVERNAME


-- all Parameters
DECLARE @ServerName    sysname = 'testfabrik-verlag'
      , @DatabaseName  sysname = 'Verlag'
      , @CloudProvider sysname = 'MicrosoftAzure'  -- [ mAz.MicrosoftAzure | aws | gcp.GoogleCloudPlatform ]
      , @Login         sysname = 'verlagLogin'     -- !! without '[' and ']'
      , @Password      sysname = 'Pa$$w0rdG3he1m'


----
-- internal variables:
DECLARE @vServer        sysname 
      , @vCloudSuffix   sysname
      , @vDataSource    sysname

SET @vServer = N''
             + N'LSrv__'
             + N'mAz'   --  @CloudProvider = [ mAz.MicrosoftAzure | aws | gcp.GoogleCloudPlatform ]
             + N'__'
             + N'Sql'   --  [ Sql | Syn.apse | Cos.mos | ... ]
             + N'__'
             + @ServerName
             + N'__'
             + @DatabaseName

SET @vCloudSuffix = N'.database.windows.net'

SET @vDataSource  = @ServerName + @vCloudSuffix

-- select @vServer, @vDataSource, @DatabaseName


/******  Object:  LinkedServer  ******/
EXEC master.dbo.sp_addlinkedserver 
            @server      = @vServer  -- alias
          , @srvproduct  = N''
          , @provider    = N'sqlncli'
          , @datasrc     = @vDataSource
          , @catalog     = @DatabaseName
;

EXEC master.dbo.sp_addlinkedsrvlogin 
            @rmtsrvname  = @vServer  -- alias
          , @locallogin  = NULL 
          , @useself     = N'False'
          , @rmtuser     = @Login
          , @rmtpassword = @Password
;

EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'collation compatible'              , @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'data access'                       , @optvalue=N'true' 
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'dist'                              , @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'pub'                               , @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'rpc'                               , @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'rpc out'                           , @optvalue=N'true' 
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'sub'                               , @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'connect timeout'                   , @optvalue=N'0'    
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'collation name'                    , @optvalue=  null  
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'lazy schema validation'            , @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'query timeout'                     , @optvalue=N'0'    
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'use remote collation'              , @optvalue=N'true' 
EXEC master.dbo.sp_serveroption @server=  @vServer  , @optname=N'remote proc transaction promotion' , @optvalue=N'true' 
GO

----  end  ----
