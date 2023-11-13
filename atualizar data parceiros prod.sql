





DECLARE @CODPARC_PROD INT, @DTALTER_PROD DATETIME, @CODPARC_ATUA INT, @DTALTER_ATUA DATETIME


DECLARE BUSCAR_PROD CURSOR FOR

SELECT PAR.CODPARC, PAR.DTALTER
FROM SANKHYA_PRODUCAO.SANKHYA.TGFPAR PAR 
WHERE PAR.AD_ATUALIZADO='S' AND PAR.CODUSU = 165

OPEN BUSCAR_PROD

FETCH NEXT FROM BUSCAR_PROD INTO @CODPARC_PROD, @DTALTER_PROD

WHILE @@FETCH_STATUS = 0
BEGIN
	
	
		DECLARE BUSCAR_ATUA CURSOR FOR
		SELECT PAR.CODPARC, PAR.DTALTER
		FROM TGFPAR PAR 
		WHERE PAR.CODPARC = @CODPARC_PROD
		
		OPEN BUSCAR_ATUA
		
		FETCH NEXT FROM BUSCAR_ATUA INTO @CODPARC_ATUA, @DTALTER_ATUA
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF(@DTALTER_PROD <> @DTALTER_ATUA)
			BEGIN
				UPDATE SANKHYA_PRODUCAO.SANKHYA.TGFPAR SET DTALTER = @DTALTER_ATUA WHERE CODPARC = @CODPARC_ATUA
			END

		FETCH NEXT FROM BUSCAR_ATUA INTO @CODPARC_ATUA, @DTALTER_ATUA
		END
		CLOSE BUSCAR_ATUA
		DEALLOCATE BUSCAR_ATUA
		
	
FETCH NEXT FROM BUSCAR_PROD INTO @CODPARC_PROD, @DTALTER_PROD	
END
CLOSE BUSCAR_PROD
DEALLOCATE BUSCAR_PROD