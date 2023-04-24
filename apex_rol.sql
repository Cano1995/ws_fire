
  CREATE TABLE "APEX_ROL" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"NOMBRE" VARCHAR2(255), 
	"DESCRIPCION" VARCHAR2(255), 
	"CREATED" DATE NOT NULL ENABLE, 
	"CREATED_BY" VARCHAR2(255) NOT NULL ENABLE, 
	"UPDATED" DATE NOT NULL ENABLE, 
	"UPDATED_BY" VARCHAR2(255) NOT NULL ENABLE, 
	 CONSTRAINT "APEX_ROL_ID_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   ) ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "APEX_ROL_BIU" 
    before insert or update
    on apex_rol
    for each row
DECLARE 
V_CLAVE NUMBER:=0;
begin
  select NVL(MAX(id),0)+1
    into V_CLAVE
    from apex_rol;
    if :new.id is null then
        :new.id := V_CLAVE;
    end if;
    if inserting then
        :new.created := sysdate;
        :new.created_by := NVL(v('APP_USER'), USER);
    end if;
    :new.updated := sysdate;
    :new.updated_by := NVL(v('APP_USER'), USER);
end apex_rol_biu;

/
ALTER TRIGGER "APEX_ROL_BIU" ENABLE;