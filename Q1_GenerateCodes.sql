CREATE PROCEDURE [dbo].[generate_codes]
AS   
BEGIN  

-- Kod üretimi için gerekli algoritma
-- Temsili olarak 1.000 adet kod üretilebilir
-- Burada üretilen her kod [check_code] ile doğrulanabilmelidir.

SET NOCOUNT ON  
DECLARE @GenerateCode VARCHAR(8), @CharacterList VARCHAR(21), @Character VARCHAR(1)
DECLARE @GenerateCodeLength INT, @CodeCount INT, @CharacterListCount INT
DECLARE @CheckGenerateCode BIT;

SET @GenerateCode = ''  
SET @Character = ''  
SET @CharacterList = 'ACDEFGHKLMNPRTXYZ234579'  
SET @GenerateCodeLength = 0
SET @CodeCount = 0
SET @CharacterListCount = DATALENGTH(@CharacterList)

WHILE (@CodeCount < 1000)
BEGIN

   SET @CodeCount = @CodeCount + 1;

   WHILE (@GenerateCodeLength <= 8)  
    BEGIN  
	    SET @GenerateCodeLength = @GenerateCodeLength + 1;
		SET @Character = SUBSTRING(@CharacterList, (ABS(CONVERT(BIGINT, CHECKSUM(NEWID()))) % @CharacterListCount) + 1, 1)
        SET @GenerateCode += @Character
    END  
	
	EXEC [dbo].[check_code] @Code = @GenerateCode,
    @IsValid = @CheckGenerateCode OUTPUT;
	IF (@CheckGenerateCode = 1)
	BEGIN
		PRINT @GenerateCode;
	END
	ELSE
	BEGIN
	  SET @CodeCount = @CodeCount - 1
	END
	SET @GenerateCode = ''
	SET @GenerateCodeLength = 0
END
END