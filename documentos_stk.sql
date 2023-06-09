
  CREATE TABLE "DOCUMENTOS_STK" 
   (	"DOCS_CLAVE" NUMBER NOT NULL ENABLE, 
	"DOCS_NRO" NUMBER NOT NULL ENABLE, 
	"DOCS_TIPO_OPER" NUMBER NOT NULL ENABLE, 
	"DOCS_FECHA" DATE NOT NULL ENABLE, 
	"DOCS_LOGIN" VARCHAR2(10) NOT NULL ENABLE, 
	"DOCS_ESTADO" VARCHAR2(1) NOT NULL ENABLE, 
	"DOCS_FEC_GRAB" TIMESTAMP (6) WITH LOCAL TIME ZONE, 
	 CONSTRAINT "DOCUMENTOS_STK_PK" PRIMARY KEY ("DOCS_CLAVE")
  USING INDEX  ENABLE
   ) ;

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_DOCUMENTOS_STK" 
  before insert on "DOCUMENTOS_STK"               
  for each row  
begin   
  if :NEW."DOCS_CLAVE" is null then 
    select "DOCUMENTOS_STK_SEQ".nextval into :NEW."DOCS_CLAVE" from sys.dual; 
    :new.docs_fec_grab:=sysdate;
  end if; 
end;

/
ALTER TRIGGER "BI_DOCUMENTOS_STK" ENABLE;