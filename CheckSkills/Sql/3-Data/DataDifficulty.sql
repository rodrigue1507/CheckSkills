DECLARE @DifficultyLevel TINYINT
------------------------------DIfficulty-----------------------------------------
SET @DifficultyLevel = 5

IF NOT EXISTS (SELECT NULL FROM Difficulty where DifficultyLevel = @DifficultyLevel)
BEGIN 
  INSERT INTO Difficulty(DifficultyLevel) VALUES (@DifficultyLevel)
END
