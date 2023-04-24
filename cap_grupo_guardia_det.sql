
  CREATE TABLE "CAP_GRUPO_GUARDIA_DET" 
   (	"GRUD_CLAVE" NUMBER NOT NULL ENABLE, 
	"GRUD_PERSONA" NUMBER, 
	"GRUD_ESTADO" VARCHAR2(1), 
	"GRUD_ITEM" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "PKGD_CLAVE" PRIMARY KEY ("GRUD_CLAVE", "GRUD_ITEM")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "CAP_GRUPO_GUARDIA_DET" ADD CONSTRAINT "FK_G_CLAVE" FOREIGN KEY ("GRUD_CLAVE")
	  REFERENCES "CAP_GRUPO_GUARDIA" ("GRU_CLAVE") ON DELETE CASCADE ENABLE;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_GRUPO_DET_BE_I" 
  before insert
  on CAP_GRUPO_GUARDIA_DET 
  for each row
declare
  -- local variables here
begin
  if :new.grud_item is null then
    select nvl(max(d.grud_item),0)+1 into :new.grud_item from CAP_GRUPO_GUARDIA_DET d where d.grud_clave=:new.grud_clave;
    :new.grud_estado:=1;
  end if;
end tr_grupo_det_be_i;

/
ALTER TRIGGER "TR_GRUPO_DET_BE_I" ENABLE;