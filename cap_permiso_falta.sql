
  CREATE TABLE "CAP_PERMISO_FALTA" 
   (	"FAL_CLAVE" NUMBER NOT NULL ENABLE, 
	"FAL_VOLUNTARIO" NUMBER, 
	"FAL_FECHA" DATE, 
	"FAL_FEC_GRABACION" DATE, 
	"FAL_MOTIVO" VARCHAR2(500), 
	"FAL_USUARIO" VARCHAR2(10), 
	"FAL_ESTADO" VARCHAR2(1) DEFAULT 'P', 
	 CONSTRAINT "CAP_PERMISO_FALTA_PK" PRIMARY KEY ("FAL_CLAVE")
  USING INDEX  ENABLE
   ) ;

   COMMENT ON COLUMN "CAP_PERMISO_FALTA"."FAL_ESTADO" IS 'A:APROBADO R:RECHAZADO P:PENDIENTE';

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_CAP_PERMISO_FALTA" 
  before insert on "CAP_PERMISO_FALTA"               
  for each row  
begin   
  if :NEW."FAL_CLAVE" is null then 
    select "CAP_PERMISO_FALTA_SEQ".nextval into :NEW."FAL_CLAVE" from sys.dual; 
    :NEW.FAL_USUARIO:=gen_devuelve_user;
    :NEW.FAL_MOTIVO:='P';
  end if; 
end;

/
ALTER TRIGGER "BI_CAP_PERMISO_FALTA" ENABLE;