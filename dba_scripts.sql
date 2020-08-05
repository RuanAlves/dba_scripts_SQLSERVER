--- Obter índice e coluna da lista
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id
	 

select s.name, t.name, i.name, c.name from sys.tables t
inner join sys.schemas s on t.schema_id = s.schema_id
inner join sys.indexes i on i.object_id = t.object_id
inner join sys.index_columns ic on ic.object_id = t.object_id
inner join sys.columns c on c.object_id = t.object_id and
        ic.column_id = c.column_id

where i.index_id > 0    
 and i.type in (1, 2) -- clustered & nonclustered only
 and i.is_primary_key = 0 -- do not include PK indexes
 and i.is_unique_constraint = 0 -- do not include UQ
 and i.is_disabled = 0
 and i.is_hypothetical = 0
 and ic.key_ordinal > 0

order by ic.key_ordinal
	 
--- Desativar, ativar índices
SELECT 
	'ALTER INDEX ' + 
	QUOTENAME(I.name) + 
	' ON ' +  
	QUOTENAME(SCHEMA_NAME(T.schema_id))+
	'.'+ 
	QUOTENAME(T.name) + 
	' DISABLE'
	AS query_
FROM 
	sys.indexes I
INNER JOIN 
	sys.tables T ON I.object_id = T.object_id
WHERE 
	I.type_desc = 'NONCLUSTERED'
	AND I.name IS NOT NULL
	AND I.is_disabled = 0

SELECT 
	'ALTER INDEX ' + 
	QUOTENAME(I.name) + 
	' ON ' +  
	QUOTENAME(SCHEMA_NAME(T.schema_id))+
	'.'+ 
	QUOTENAME(T.name) + 
	' REBUILD' 
FROM 
	sys.indexes i
INNER JOIN 
	sys.tables t ON i.object_id = t.object_id
WHERE 
	i.type_desc = 'NONCLUSTERED'
	AND i.name IS NOT NULL
	AND i.is_disabled = 1

-- Partição de lista
select 
    object_schema_name(i.object_id) as [schema],
    object_name(i.object_id) as [object_name],
    t.name as [table_name],
    i.name as [index_name],
    s.name as [partition_scheme]
from sys.indexes i
    join sys.partition_schemes s on i.data_space_id = s.data_space_id
    join sys.tables t on i.object_id = t.object_id

-- Detalhes da partição
SELECT SCHEMA_NAME(o.schema_id) + '.' + OBJECT_NAME(i.object_id) AS [object]
     , p.partition_number AS [p#]
     , fg.name AS [filegroup]
     , p.rows
     , au.total_pages AS pages
     , CASE boundary_value_on_right
       WHEN 1 THEN 'less than'
       ELSE 'less than or equal to' END as comparison
     , rv.value
     , CONVERT (VARCHAR(6), CONVERT (INT, SUBSTRING (au.first_page, 6, 1) +
       SUBSTRING (au.first_page, 5, 1))) + ':' + CONVERT (VARCHAR(20),
       CONVERT (INT, SUBSTRING (au.first_page, 4, 1) +
       SUBSTRING (au.first_page, 3, 1) + SUBSTRING (au.first_page, 2, 1) +
       SUBSTRING (au.first_page, 1, 1))) AS first_page
FROM sys.partitions p
INNER JOIN sys.indexes i
     ON p.object_id = i.object_id
AND p.index_id = i.index_id
INNER JOIN sys.objects o
     ON p.object_id = o.object_id
INNER JOIN sys.system_internals_allocation_units au
     ON p.partition_id = au.container_id
INNER JOIN sys.partition_schemes ps
     ON ps.data_space_id = i.data_space_id
INNER JOIN sys.partition_functions f
     ON f.function_id = ps.function_id
INNER JOIN sys.destination_data_spaces dds
     ON dds.partition_scheme_id = ps.data_space_id
     AND dds.destination_id = p.partition_number
INNER JOIN sys.filegroups fg
     ON dds.data_space_id = fg.data_space_id
LEFT OUTER JOIN sys.partition_range_values rv
     ON f.function_id = rv.function_id
     AND p.partition_number = rv.boundary_id
WHERE i.index_id < 2
     AND o.object_id = OBJECT_ID('acct_bal')
	 
-- Verifique o formato da data
DECLARE @now datetime
SET @now = GETDATE()
select convert(nvarchar(MAX), @now, 0) as output, 0 as style 
union select convert(nvarchar(MAX), @now, 1), 1
union select convert(nvarchar(MAX), @now, 2), 2
union select convert(nvarchar(MAX), @now, 3), 3
union select convert(nvarchar(MAX), @now, 4), 4
union select convert(nvarchar(MAX), @now, 5), 5
union select convert(nvarchar(MAX), @now, 6), 6
union select convert(nvarchar(MAX), @now, 7), 7
union select convert(nvarchar(MAX), @now, 8), 8
union select convert(nvarchar(MAX), @now, 9), 9
union select convert(nvarchar(MAX), @now, 10), 10
union select convert(nvarchar(MAX), @now, 11), 11
union select convert(nvarchar(MAX), @now, 12), 12
union select convert(nvarchar(MAX), @now, 13), 13
union select convert(nvarchar(MAX), @now, 14), 14
--15 a 19 inválido
union select convert(nvarchar(MAX), @now, 20), 20
union select convert(nvarchar(MAX), @now, 21), 21
union select convert(nvarchar(MAX), @now, 22), 22
union select convert(nvarchar(MAX), @now, 23), 23
union select convert(nvarchar(MAX), @now, 24), 24
union select convert(nvarchar(MAX), @now, 25), 25
--26 a 99 inválido
union select convert(nvarchar(MAX), @now, 100), 100
union select convert(nvarchar(MAX), @now, 101), 101
union select convert(nvarchar(MAX), @now, 102), 102
union select convert(nvarchar(MAX), @now, 103), 103
union select convert(nvarchar(MAX), @now, 104), 104
union select convert(nvarchar(MAX), @now, 105), 105
union select convert(nvarchar(MAX), @now, 106), 106
union select convert(nvarchar(MAX), @now, 107), 107
union select convert(nvarchar(MAX), @now, 108), 108
union select convert(nvarchar(MAX), @now, 109), 109
union select convert(nvarchar(MAX), @now, 110), 110
union select convert(nvarchar(MAX), @now, 111), 111
union select convert(nvarchar(MAX), @now, 112), 112
union select convert(nvarchar(MAX), @now, 113), 113
union select convert(nvarchar(MAX), @now, 114), 114
union select convert(nvarchar(MAX), @now, 120), 120
union select convert(nvarchar(MAX), @now, 121), 121
--122 a 125 inválido
union select convert(nvarchar(MAX), @now, 126), 126
union select convert(nvarchar(MAX), @now, 127), 127
--128, 129 inválido
union select convert(nvarchar(MAX), @now, 130), 130
union select convert(nvarchar(MAX), @now, 131), 131
--132 not valid
order BY style

output                   style
Apr 28 2014  9:31AM          0
04/28/14                     1
14.04.28                     2
28/04/14                     3
28.04.14                     4
28-04-14                     5
28 Apr 14                    6
Apr 28, 14                   7
09:31:28                     8
Apr 28 2014  9:31:28:580AM   9
04-28-14                     10
14/04/28                     11
140428                       12
28 Apr 2014 09:31:28:580     13
09:31:28:580                 14
2014-04-28 09:31:28          20
2014-04-28 09:31:28.580      21
04/28/14  9:31:28 AM         22
2014-04-28                   23
09:31:28                     24
2014-04-28 09:31:28.580      25
Apr 28 2014  9:31AM          100
04/28/2014                   101
2014.04.28                   102
28/04/2014                   103
28.04.2014                   104
28-04-2014                   105
28 Apr 2014                  106
Apr 28, 2014                 107
09:31:28                     108
Apr 28 2014  9:31:28:580AM   109
04-28-2014                   110
2014/04/28                   111
20140428                     112
28 Apr 2014 09:31:28:580     113
09:31:28:580                 114
2014-04-28 09:31:28          120
2014-04-28 09:31:28.580      121
2014-04-28T09:31:28.580      126
2014-04-28T09:31:28.580      127
28 جمادى الثانية 1435  9:31:28:580AM    130
28/06/1435  9:31:28:580AM    131

--==============================================================================
-- Consultas usadas para encontrar objetos bloqueados no banco de dados
--==============================================================================
select session_id, wait_type, resource_address, resource_description
from sys.dm_os_waiting_tasks
where blocking_session_id is not null;

SELECT  
    OBJECT_NAME(p.[object_id]) BlockedObject
FROM    sys.dm_exec_connections AS blocking
    INNER JOIN sys.dm_exec_requests blocked
        ON blocking.session_id = blocked.blocking_session_id
    INNER JOIN sys.dm_os_waiting_tasks waitstats
        ON waitstats.session_id = blocked.session_id
    INNER JOIN sys.partitions p ON SUBSTRING(resource_description, 
        PATINDEX('%associatedObjectId%', resource_description) + 19, 
        LEN(resource_description)) = p.partition_id;

SELECT 
db_name(rsc_dbid) AS 'DATABASE_NAME',
case rsc_type when 1 then 'null'
              when 2 then 'DATABASE' 
              WHEN 3 THEN 'FILE'
              WHEN 4 THEN 'INDEX'
              WHEN 5 THEN 'TABLE'
              WHEN 6 THEN 'PAGE'
              WHEN 7 THEN 'KEY'
              WHEN 8 THEN 'EXTEND'
              WHEN 9 THEN 'RID ( ROW ID)'
              WHEN 10 THEN 'APPLICATION' end  AS 'REQUEST_TYPE',

CASE req_ownertype WHEN 1 THEN 'TRANSACTION'
                   WHEN 2 THEN 'CURSOR'
                   WHEN 3 THEN 'SESSION'
                   WHEN 4 THEN 'ExSESSION' END AS 'REQUEST_OWNERTYPE',

OBJECT_NAME(rsc_objid ,rsc_dbid) AS 'OBJECT_NAME', 
PROCESS.spid,
PROCESS.HOSTNAME , 
PROCESS.program_name , 
PROCESS.nt_domain , 
PROCESS.nt_username , 
PROCESS.program_name ,
SQLTEXT.text 
FROM sys.syslockinfo LOCK JOIN 
     SYS.sysprocesses PROCESS
  ON LOCK.req_spid = PROCESS.spid
CROSS APPLY SYS.dm_exec_sql_text(PROCESS.SQL_HANDLE) SQLTEXT

select * from sys.sysprocesses

SELECT resource_type, resource_associated_entity_id,
    request_status, request_mode,request_session_id,
    resource_description, o.object_id, o.name, o.type_desc 
FROM sys.dm_tran_locks l, sys.objects o
WHERE l.resource_associated_entity_id = o.object_id
    and resource_database_id = DB_ID()

SELECT TEXT
FROM sys.dm_exec_connections
CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle)
WHERE session_id = (89)

--==============================================================================
-- ver quem está conectado ao banco de dados
-- analise o que cada spid está fazendo, lê e grava
-- se seguro, você pode copiar e colar o comando kill - last column
-- marcelo miorelli
-- 18 de julho de 2017 - Londres (Reino Unido)
-- testado no sql server 2016
--==============================================================================
USE master
go
SELECT 
        sdes.session_id 
       ,sdes.login_time 
       ,sdes.last_request_start_time
       ,sdes.last_request_end_time
       ,sdes.is_user_process
       ,sdes.host_name
       ,sdes.program_name
       ,sdes.login_name
       ,sdes.status

       ,sdec.num_reads
       ,sdec.num_writes
       ,sdec.last_read
       ,sdec.last_write
       ,sdes.reads
       ,sdes.logical_reads
       ,sdes.writes

       ,sdest.DatabaseName 
       ,sdest.ObjName
    ,sdes.client_interface_name
    ,sdes.nt_domain
    ,sdes.nt_user_name
    ,sdec.client_net_address
    ,sdec.local_net_address
    ,sdest.Query
    ,KillCommand  = 'Kill '+ CAST(sdes.session_id  AS VARCHAR)
FROM sys.dm_exec_sessions AS sdes

INNER JOIN sys.dm_exec_connections AS sdec 
        ON sdec.session_id = sdes.session_id

CROSS APPLY (

                SELECT DB_NAME(dbid) AS DatabaseName
                    ,OBJECT_NAME(objectid) AS ObjName
                    ,COALESCE((
                            SELECT TEXT AS [processing-instruction(definition)]
                            FROM sys.dm_exec_sql_text(sdec.most_recent_sql_handle) 
                            FOR XML PATH('')
                                ,TYPE
                            ), '') AS Query

                FROM sys.dm_exec_sql_text(sdec.most_recent_sql_handle)

    ) sdest
WHERE sdes.session_id <> @@SPID
  --AND sdest.DatabaseName ='base_aa'
  AND sdes.PROGRAM_NAME = 'MICROSOFT SQL SERVER JDBC DRIVER' 
--ORDER BY sdes.last_request_start_time DESC

--==============================================================================
-- Obtenha o número total de conexões
-- E informações sobre sessões ativas
--==============================================================================

Declare @dbName varchar(150)
set @dbName = 'Core'

--Total de conexões da máquina
--SELECT COUNT(dbid) as TotalConnections FROM sys.sysprocesses WHERE dbid > 0

--Conexões disponíveis
DECLARE @SPWHO1 TABLE (DBName VARCHAR(1000) NULL, NoOfAvailableConnections VARCHAR(1000) NULL, LoginName VARCHAR(1000) NULL)
INSERT INTO @SPWHO1 
    SELECT db_name(dbid), count(dbid), loginame FROM sys.sysprocesses WHERE dbid > 0 GROUP BY dbid, loginame
SELECT * FROM @SPWHO1 WHERE DBName = @dbName

--Conexões em execução
DECLARE @SPWHO2 TABLE (SPID VARCHAR(1000), [Status] VARCHAR(1000) NULL, [Login] VARCHAR(1000) NULL, HostName VARCHAR(1000) NULL, BlkBy VARCHAR(1000) NULL, DBName VARCHAR(1000) NULL, Command VARCHAR(1000) NULL, CPUTime VARCHAR(1000) NULL, DiskIO VARCHAR(1000) NULL, LastBatch VARCHAR(1000) NULL, ProgramName VARCHAR(1000) NULL, SPID2 VARCHAR(1000) NULL, Request VARCHAR(1000) NULL)
INSERT INTO @SPWHO2 
    EXEC sp_who2 'Active'
SELECT * FROM @SPWHO2 WHERE DBName = @dbName

--==============================================================================
-- Encontre dependências
--==============================================================================
select * from sys.objects
where object_id in
(select referencing_id from sys.sql_expression_dependencies
where referenced_entity_name = 'con_forex')


select * from sys.objects
where object_id in
(select object_id from sys.sql_modules
where definition like '%parentid%')
--==============================================================================
-- Encontre informações de backup
--==============================================================================
SELECT
  DISTINCT
        a.Name AS DatabaseName ,
        CONVERT(SYSNAME, DATABASEPROPERTYEX(a.name, 'Recovery')) RecoveryModel ,
        COALESCE(( SELECT   CONVERT(VARCHAR(12), MAX(backup_finish_date), 101)
                   FROM     msdb.dbo.backupset
                   WHERE    database_name = a.name
                            AND type = 'D'
                            AND is_copy_only = '0'
                 ), 'No Full') AS 'Full' ,
        COALESCE(( SELECT   CONVERT(VARCHAR(12), MAX(backup_finish_date), 101)
                   FROM     msdb.dbo.backupset
                   WHERE    database_name = a.name
                            AND type = 'I'
                            AND is_copy_only = '0'
                 ), 'No Diff') AS 'Diff' ,
        COALESCE(( SELECT   CONVERT(VARCHAR(20), MAX(backup_finish_date), 120)
                   FROM     msdb.dbo.backupset
                   WHERE    database_name = a.name
                            AND type = 'L'
                 ), 'No Log') AS 'LastLog' ,
        COALESCE(( SELECT   CONVERT(VARCHAR(20), backup_finish_date, 120)
                   FROM     ( SELECT    ROW_NUMBER() OVER ( ORDER BY backup_finish_date DESC ) AS 'rownum' ,
                                        backup_finish_date
                              FROM      msdb.dbo.backupset
                              WHERE     database_name = a.name
                                        AND type = 'L'
                            ) withrownum
                   WHERE    rownum = 2
                 ), 'No Log') AS 'LastLog2'
FROM    sys.databases a
        LEFT OUTER JOIN msdb.dbo.backupset b ON b.database_name = a.name
WHERE   a.name <> 'tempdb'
        AND a.state_desc = 'online'
GROUP BY a.Name ,
        a.compatibility_level
ORDER BY a.name

--- Obter informações do banco de dados
SELECT database_id,
CONVERT(VARCHAR(25), DB.name) AS dbName,
CONVERT(VARCHAR(10), DATABASEPROPERTYEX(name, 'status')) AS [Status],
state_desc,
(SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS DataFiles,
(SELECT SUM((size*8)/1024) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS [Data MB],
(SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS LogFiles,
(SELECT SUM((size*8)/1024) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS [Log MB],
user_access_desc AS [User access],
recovery_model_desc AS [Recovery model],
CASE compatibility_level
WHEN 60 THEN '60 (SQL Server 6.0)'
WHEN 65 THEN '65 (SQL Server 6.5)'
WHEN 70 THEN '70 (SQL Server 7.0)'
WHEN 80 THEN '80 (SQL Server 2000)'
WHEN 90 THEN '90 (SQL Server 2005)'
WHEN 100 THEN '100 (SQL Server 2008)'
END AS [compatibility level],
CONVERT(VARCHAR(20), create_date, 103) + ' ' + CONVERT(VARCHAR(20), create_date, 108) AS [Creation date],
--  Ultimo Back up
ISNULL((SELECT TOP 1
CASE TYPE WHEN 'D' THEN 'Full' WHEN 'I' THEN 'Differential' WHEN 'L' THEN 'Transaction log' END + ' – ' +
LTRIM(ISNULL(STR(ABS(DATEDIFF(DAY, GETDATE(),Backup_finish_date))) + ' days ago', 'NEVER')) + ' – ' +
CONVERT(VARCHAR(20), backup_start_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_start_date, 108) + ' – ' +
CONVERT(VARCHAR(20), backup_finish_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_finish_date, 108) +
' (' + CAST(DATEDIFF(second, BK.backup_start_date,
BK.backup_finish_date) AS VARCHAR(4)) + ' '
+ 'seconds)'
FROM msdb..backupset BK WHERE BK.database_name = DB.name ORDER BY backup_set_id DESC),'-') AS [Last backup],
CASE WHEN is_fulltext_enabled = 1 THEN 'Fulltext enabled' ELSE '' END AS [fulltext],
CASE WHEN is_auto_close_on = 1 THEN 'autoclose' ELSE '' END AS [autoclose],
page_verify_option_desc AS [page verify option],
CASE WHEN is_read_only = 1 THEN 'read only' ELSE '' END AS [read only],
CASE WHEN is_auto_shrink_on = 1 THEN 'autoshrink' ELSE '' END AS [autoshrink],
CASE WHEN is_auto_create_stats_on = 1 THEN 'auto create statistics' ELSE '' END AS [auto create statistics],
CASE WHEN is_auto_update_stats_on = 1 THEN 'auto update statistics' ELSE '' END AS [auto update statistics],
CASE WHEN is_in_standby = 1 THEN 'standby' ELSE '' END AS [standby],
CASE WHEN is_cleanly_shutdown = 1 THEN 'cleanly shutdown' ELSE '' END AS [cleanly shutdown] FROM sys.databases DB
ORDER BY dbName, [Last backup] DESC, NAME

--==============================================================================
--- Listar tabelas, linhas e tamanho
--==============================================================================
SELECT 
	t.NAME AS TableName,
	i.name as indexName,
	p.[Rows],
	sum(a.total_pages) as TotalPages, 
	sum(a.used_pages) as UsedPages, 
	sum(a.data_pages) as DataPages,
	(sum(a.total_pages) * 8) / 1024 as TotalSpaceMB, 
	(sum(a.used_pages) * 8) / 1024 as UsedSpaceMB, 
	(sum(a.data_pages) * 8) / 1024 as DataSpaceMB
FROM 
	sys.tables t
	INNER JOIN 
	sys.indexes i ON t.OBJECT_ID = i.object_id
	INNER JOIN 
	sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
	INNER JOIN 
	sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
	t.NAME NOT LIKE 'dt%' AND
	i.OBJECT_ID > 255 AND 
	i.index_id <= 1
GROUP BY 
	t.NAME, i.object_id, i.index_id, i.name, p.[Rows]
ORDER BY 
	object_name(i.object_id)