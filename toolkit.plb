create or replace PACKAGE BODY toolkit AS
 
  g_key     RAW(32767)  := UTL_RAW.cast_to_raw('12345678');
  g_pad_chr VARCHAR2(1) := '~';
  PROCEDURE padstring (p_text  IN OUT  VARCHAR2);
  -- --------------------------------------------------
  FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW IS
  -- --------------------------------------------------
    l_text       VARCHAR2(32767) := p_text;
    l_encrypted  RAW(32767);
  BEGIN
    padstring(l_text);
    DBMS_OBFUSCATION_TOOLKIT.desencrypt(input          => UTL_RAW.cast_to_raw(l_text),
                                        key            => g_key,
                                        encrypted_data => l_encrypted);
    RETURN l_encrypted;
  END;
  -- --------------------------------------------------
  -- --------------------------------------------------
  FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2 IS
  -- --------------------------------------------------
    l_decrypted  VARCHAR2(32767);
  BEGIN
    DBMS_OBFUSCATION_TOOLKIT.desdecrypt(input => p_raw,
                                        key   => g_key,
                                        decrypted_data => l_decrypted);
    RETURN RTrim(UTL_RAW.cast_to_varchar2(l_decrypted), g_pad_chr);
  END;
  -- --------------------------------------------------
  -- --------------------------------------------------
  FUNCTION F_LOGIN (p_username IN VARCHAR2, p_password VARCHAR2) RETURN BOOLEAN IS
    l_return number;
    l_usuario apex_usuario.usuario%type;
    l_password apex_usuario.password%type;
    begin 
      begin
      select usuario,password into l_usuario, l_password from apex_usuario where UPPER(usuario) = UPPER(p_username);
      if toolkit.encrypt(p_password) = l_password and UPPER(l_usuario) = UPPER(p_username) then
        return true;
        else
        return false;
      end if;
      exception when no_data_found then
        return false;  
      end;
  END;
  -- --------------------------------------------------
  -- --------------------------------------------------
  PROCEDURE padstring (p_text  IN OUT  VARCHAR2) IS
  -- --------------------------------------------------
    l_units  NUMBER;
  BEGIN
    IF LENGTH(p_text) MOD 8 > 0 THEN
      l_units := TRUNC(LENGTH(p_text)/8) + 1;
      p_text  := RPAD(p_text, l_units * 8, g_pad_chr);
    END IF;
  END;
  -- --------------------------------------------------
END toolkit;
/