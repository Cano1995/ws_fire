create or replace PACKAGE toolkit AS
  FUNCTION encrypt(p_text IN VARCHAR2) RETURN RAW;
  FUNCTION decrypt(p_raw IN RAW) RETURN VARCHAR2;
  FUNCTION F_LOGIN(p_username IN VARCHAR2, p_password VARCHAR2)
    RETURN BOOLEAN;
END toolkit;
/