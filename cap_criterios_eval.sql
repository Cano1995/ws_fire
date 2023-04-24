
  CREATE TABLE "CAP_CRITERIOS_EVAL" 
   (	"CRI_CLAVE" NUMBER NOT NULL ENABLE, 
	"CRI_DESCRIPCION" VARCHAR2(250), 
	"CRI_NOMBRE" VARCHAR2(50), 
	 CONSTRAINT "PK_CRITERIO" PRIMARY KEY ("CRI_CLAVE")
  USING INDEX  ENABLE
   ) ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_CAP_CRITERIO_BI" 
  before insert
  on CAP_CRITERIOS_EVAL 
  for each row
declare
  -- local variables here
begin
  select nvl(max(e.cri_clave),0)+1 into :new.cri_clave from cap_criterios_eval e;
end tr_cap_criterio_bi;

/
ALTER TRIGGER "TR_CAP_CRITERIO_BI" ENABLE;