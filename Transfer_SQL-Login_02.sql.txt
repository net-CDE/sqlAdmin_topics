-- transfer SQL-Logins

Declare @Login  sysname = 'SQLLogin01'
SELECT  @Login, @@SERVERNAME

Declare @SID_varbinary varbinary(85)
      , @PWD_varbinary varbinary(256)

Declare @SID_string    varchar(514)
      , @PWD_string    varchar(514)

----
SET @SID_varbinary = ( select sid 
                       from   sys.server_principals 
					   where  name = @Login )

SET @PWD_varbinary = CAST( LoginProperty( @Login, 'PasswordHash' ) as varbinary(256) )

EXEC dbo.spTool_hexadecimal  @SID_varbinary, @SID_string  OUTPUT
EXEC dbo.spTool_hexadecimal  @PWD_varbinary, @PWD_string  OUTPUT

SELECT @SID_string as 'SID_string'
     , @PWD_string as 'PWD_string'


--------------------------
--------------------------
-- >>  SELECT @@SERVERNAME
Declare @sqlCmd     nvarchar(4000)
Declare @new_Login  sysname = 'SQLLogin01'

Declare @new_SID_string    varchar(514) = '0x29086E56846EE545895888ED951703F1'
      , @new_PWD_string    varchar(514) = '0x0200158E9D9FA9EECFB7D487C9A58484D0BB13C39F6C4ADFDDA83927F91530DD401956C6F3EFDB8350AB4C52392421F9B31A508F9A4E8E55A37EDD269F627D73B5CE08E2134E'

Set @sqlCmd = ' CREATE LOGIN ' 
            + QUOTENAME( @new_Login )
			+ ' WITH PASSWORD = '
			+ @new_PWD_string + ' HASHED, '
			+ ' SID = '
			+ @new_SID_string
			
exec sp_executesql @sqlCmd 

----  end	

------------------
--  compare Logins
select sp.name
     , sp.sid
	 , sp.type_desc
	 , sl.password
	 , CAST( sl.password as varbinary(256))
from   sys.server_principals sp
join   sys.syslogins sl
on     sp.sid = sl.sid
where  sp.name = 'SQLLogin01'

select @@servername		 