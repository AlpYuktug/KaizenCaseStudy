CREATE PROCEDURE [dbo].[check_code]
@Code varchar(8),
@IsValid int out
AS
BEGIN  

-- Kod kontrolü için gerekli algoritma
-- [generate_codes] ile üretilen her kod [check_code] ile doğrulanabilmelidir.
-- Bu aşamada kod bir tabloda aranmayacaktır!

	DECLARE @GenerateCodeLength INT
	SET @GenerateCodeLength = DATALENGTH(@Code)

	IF (@GenerateCodeLength = 8)
	BEGIN
	      SELECT @IsValid = 1;
	END
	ELSE
	BEGIN
	      SELECT @IsValid = 0;
	END

END;