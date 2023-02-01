select @@SERVERNAME
-- FRAISDBP8347  principal

CREATE CERTIFICATE cert4_Mirroring_partner
FROM FILE = 'G:\MSSQL10.MSSQLSERVER\MSSQL\BACKUP\cert_FRAISDBB8347.cer' 

CREATE LOGIN [##MirrorProxy##] 
FROM CERTIFICATE cert4_Mirroring_partner

CREATE USER [##MirrorProxy##]

GRANT CONNECT ON ENDPOINT::dbMirror to [##MirrorProxy##]

---------------------------------------------------------------------
---------------------------------------------------------------------
--  change Server-Connection to Mirror-Server
select @@SERVERNAME
-- FRAISDBB8347  mirrorserver

CREATE CERTIFICATE cert4_Mirroring_partner
FROM FILE = 'G:\MSSQL10.MSSQLSERVER\MSSQL\BACKUP\cert_FRAISDBP8347.cer' 

CREATE LOGIN [##MirrorProxy##] 
FROM CERTIFICATE cert4_Mirroring_partner

CREATE USER [##MirrorProxy##]

GRANT CONNECT ON ENDPOINT::dbMirror to [##MirrorProxy##]

---------------------------------------------------------------------
---------------------------------------------------------------------