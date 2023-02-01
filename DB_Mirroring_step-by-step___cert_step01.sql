select @@SERVERNAME
-- FRAISDBP8347  principal

use master
GO

select *
from   sys.symmetric_keys

-- 1st
CREATE MASTER KEY ENCRYPTION
by PASSWORD = 'Pa$$w0rd_4_DBmirroring_with_Cert'

-- 2nd
CREATE CERTIFICATE cert4_Mirroring
  WITH SUBJECT = 'Certificate for Host FRAISDBP8347'
, EXPIRY_DATE  = '06/01/2019'

-- 3rd 
CREATE ENDPOINT dbMirror
  STATE = STARTED
  AS TCP ( Listener_Port = 50222
         , Listener_IP = ALL
         )
  FOR DATABASE_MIRRORING ( Authentication = CERTIFICATE cert4_Mirroring 
                         , ENCRYPTION = REQUIRED Algorithm AES
                         , Role = ALL
                         )     
                         
-- 4th Backup Certificate >> to Disk:
BACKUP CERTIFICATE cert4_Mirroring
TO FILE = 'G:\MSSQL10.MSSQLSERVER\MSSQL\BACKUP\cert_FRAISDBP8347.cer'     


---------------------------------------------------------------------
---------------------------------------------------------------------
--  change Server-Connection to Mirror-Server
select @@SERVERNAME
-- FRAISDBB8347  mirrorserver

use master
GO

select *
from   sys.symmetric_keys

-- 1st
CREATE MASTER KEY ENCRYPTION
by PASSWORD = 'Pa$$w0rd_4_DBmirroring_with_Cert'

-- 2nd
CREATE CERTIFICATE cert4_Mirroring
  WITH SUBJECT = 'Certificate for Host FRAISDBP8347'
, EXPIRY_DATE  = '06/01/2019'

-- 3rd 
CREATE ENDPOINT dbMirror
  STATE = STARTED
  AS TCP ( Listener_Port = 50222
         , Listener_IP = ALL
         )
  FOR DATABASE_MIRRORING ( Authentication = CERTIFICATE cert4_Mirroring 
                         , ENCRYPTION = REQUIRED Algorithm AES
                         , Role = ALL
                         )     
                         
-- 4th Baclup Certificate >> to Disk:
BACKUP CERTIFICATE cert4_Mirroring
TO FILE = 'G:\MSSQL10.MSSQLSERVER\MSSQL\BACKUP\cert_FRAISDBB8347.cer'    

---------------------------------------------------------------------
---------------------------------------------------------------------                   