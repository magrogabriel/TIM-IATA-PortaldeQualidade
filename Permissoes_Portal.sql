-- CONSULTANDO SITUAÇÃO CADASTRAL DE USUARIOS INDIVIDUAIS

select * from <schema>.usuario
WHERE LOGIN='00000000';


-- EM CASO DE AUSÊNCIA DA INFORMAÇÃO LOGIN, PESQUISAR PELO NOME DO COLABORADOR (USUARIO)

select * from <schema>.usuario
WHERE UPPER(USUARIO) LIKE 'PEDRO%';


-- CONSULTA AGREGADA CONTENDO INFORMAÇÕES GERAIS E OS GRUPOS ESPECÍFICOS QUE O USUÁRIO POSSUI ACESSO

SELECT u.ID_USUARIO, u.LOGIN, u.USUARIO, u.ATIVO, gu.ID_GRUPO, gps.GRUPO FROM <schema>.usuario u
inner join <schema>.grupo_usuario gu
on u.ID_USUARIO=gu.ID_USUARIO
inner join (select * from <schema>.grupos) gps
on gu.ID_GRUPO=gps.ID_GRUPO
WHERE LOGIN='00000000';  --USUARIO='' ID_USUARIO='';


-- LISTA DE TODOS OS GRUPOS EXISTENTS NO PORTAL E SEUS IDS 

select * from <schema>.grupos;


-- ATUALIZAÇÃO DE INFORMAÇÕES CADASTRAIS DOS USUÁRIOS

-- PERMIITNDO ACESSO AO PORTAL
UPDATE <schema>.usuario SET ATIVO='S'
WHERE LOGIN='00000000';

-- ATULIZANDO EMAIL
UPDATE <schema>.usuario SET EMAIL='email@timbrasil.com.br'
WHERE LOGIN='00000000';

-- ZERANDO TENTATIVAS DE ACERTO DE SENHA
UPDATE <schema>.usuario SET FLG_TENTATIVA=0
WHERE LOGIN='00000000';

-- AUMENTANDO EM 1 ANO O TEMPO DE EXPIRAÇÃO DE ACESSO
UPDATE <schema>.usuario SET DT_EXPIRACAO = sysdate + 365
WHERE LOGIN='00000000';


-- INSERIR PERMISSÕES A GRUPOS MANUALMENTE

INSERT INTO <schema>.usuario (ID_GRUPO, ID_USUARIO, ATIVO, DT_CADASTRO) VALUES (24, 1900, 'S', TRUNC(SYSDATE));


-- DELETANDO UM USUARIO DO PORTAL

DELETE FROM <schema>.usuario WHERE LOGIN = '00000000';
DELETE FROM <schema>.grupo_usuario WHERE ID_USUARIO = 949;
DELETE FROM <schema>.historico_senha WHERE ID_USUARIO = 949;
DELETE FROM <schema>.LOG_ACESSO WHERE ID_USUARIO = 949;
DELETE FROM <schema>.PERMISSAO2 WHERE ID_USUARIO = 949;


-- HISTÓRICO DE SENHAS DOS USUÁRIOS

select * from <schema>.historico_senha;


--DELETANDO PROCESSOS CRIADOS NO PORTAL

SELECT * FROM <schema>.PROCESSO
where PARENTID = '2.6.17';


-- FINALIZANDO

COMMIT;

ROLLBACK;