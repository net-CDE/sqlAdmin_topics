CREATE Proc spTool_hexadecimal
            @binValue  varbinary(256)  
          , @hexValue  varchar(514)  OUTPUT
AS
BEGIN

DECLARE @charvalue  varchar(514)
      , @ii         int
      , @lenght     int
      , @hexstring  char(16)

SELECT  @charvalue = '0x'
SELECT  @ii        = 1
SELECT  @lenght    = DATALENGTH( @binValue )
SELECT  @hexstring = '0123456789ABCDEF'

WHILE ( @ii <= @lenght )
BEGIN
    DECLARE @tempint   int
          , @firstint  int
          , @secondint int

    SELECT  @tempint   = CONVERT( int, Substring( @binvalue, @ii, 1 ))
    SELECT  @firstint  = FLOOR( @tempint/ 16 )
    SELECT  @secondint = @tempint - ( @firstint * 16 )

    SELECT  @charvalue = @charvalue 
                       + SubString( @hexstring , @firstint  + 1, 1 )
                       + SubString( @hexString , @secondint + 1, 1 )

    ----
    Set @ii = @ii + 1
END  -- end WHILE

-- Return
SELECT @hexValue = @charvalue

END  -- end Proc
