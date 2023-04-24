
  CREATE TABLE "APEX_USUARIO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"USUARIO" VARCHAR2(255), 
	"EMAIL" VARCHAR2(255), 
	"PASSWORD" VARCHAR2(255), 
	"ROLES" VARCHAR2(255), 
	"CREATED" DATE NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255) NOT NULL ENABLE, 
	"UPDATED" DATE NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255) NOT NULL ENABLE
   ) ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "APEX_USUARIO_BIU" 
  before insert or update on apex_usuario
  for each row
DECLARE
V_CLAVE NUMBER:=0;
begin
  if inserting then
  select MAX(t.id)+1 INTO V_CLAVE from APEX_USUARIO t;
  if :new.id is null then
    :new.id := V_CLAVE;
  end if;
    :new.created    := sysdate;
    :new.created_by := NVL(v('APP_USER'), USER);
    :NEW.PASSWORD   := toolkit.encrypt(p_text => :NEW.PASSWORD);
  end if;
  IF UPDATING AND :NEW.PASSWORD IS NOT NULL THEN
    :NEW.PASSWORD   := toolkit.encrypt(p_text => :NEW.PASSWORD);
  END IF;
  :new.updated    := sysdate;
  :new.updated_by := NVL(v('APP_USER'), USER);
end apex_usuario_biu;

/
ALTER TRIGGER "APEX_USUARIO_BIU" ENABLE;