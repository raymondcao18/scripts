set pagesize 0 head off feed off linesize 999

column dbname new_value dbname noprint
select name dbname from v$pdbs;

spool /home/oracle/scripts/sql/create_container_users/create_users_&dbname..sql
select 'CREATE USER '|| name ||' IDENTIFIED BY VALUES '''|| spare4 ||';'|| password ||''' DEFAULT TABLESPACE USERS PROFILE USERS;' 
FROM sys.user$ 
WHERE name in (select username from dba_users where profile='USERS' and common='NO')
and spare4 is not null
union all
select 'CREATE USER '|| name ||' IDENTIFIED BY VALUES '''|| password ||''' DEFAULT TABLESPACE USERS PROFILE USERS;'
FROM sys.user$
WHERE name in (select username from dba_users where profile='USERS' and common='NO')
and spare4 is null;
spool off;
