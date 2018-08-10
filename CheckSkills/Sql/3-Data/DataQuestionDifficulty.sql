DECLARE @QuestionDifficultyLevel TINYINT
------------------------------DIfficulty-----------------------------------------
SET @QuestionDifficultyLevel = 5

IF NOT EXISTS (SELECT NULL FROM QuestionDifficulty where QuestionDifficultyLevel = @QuestionDifficultyLevel)
BEGIN 
  INSERT INTO QuestionDifficulty(QuestionDifficultyLevel) VALUES (@QuestionDifficultyLevel)
END
