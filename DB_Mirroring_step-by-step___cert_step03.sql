-- backup and restore UserDatabase

-- activate Database Mirroring

-- 1st on Mirror
SELECT @@SERVERNAME
-- FRAISDBB8347

ALTER DATABASE HistoryProv02
SET PARTNER = 'TCP://fraisdbp8347.de.db.com:50222'

---------------------------------------------------------------------
---------------------------------------------------------------------
--  change Server-Connection to Principal-Server
select @@SERVERNAME
-- FRAISDBP8347  principal

ALTER DATABASE HistoryProv02
SET PARTNER = 'TCP://fraisdbb8347.de.db.com:50222'

--ALTER DATABASE HistoryHR
--SET PARTNER OFF;
------------------
--ALTER DATABASE HistoryHR
--SET PARTNER FAILOVER;

-- http://msdn.microsoft.com/en-us/library/bb522476.aspx
---------------------------------------------------------------------
---------------------------------------------------------------------