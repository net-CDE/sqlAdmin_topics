CREATE OR ALTER PROC dbo.usp_get_randPassword 

                  @pwdLen   int          = 18 -- Length of Password
                , @brChar   varchar(1)   = '#'
                , @result   varchar(100) = '' -- output 

AS
BEGIN

DECLARE @loop_I    int  = 0
      , @charII    int  = 0
      , @tmpChar   char = ''


WHILE @loop_I <= @pwdLen
BEGIN

SET @charII  = ROUND(RAND()*100,0)
SET @tmpChar = CHAR(@charII)

    IF  @charII >  48   -- 0
    AND @charII < 122   -- z
    BEGIN
        SET @result = @result +  @tmpChar
        ----
        SET @loop_I   = @loop_I + 1
    END  -- end IF

END  -- end WHILE

-- add bracketCharacters
SET @result = @brChar + @result + @brChar

-- RETURN
SELECT @result as 'randPassword' 

END  -- end PROC
