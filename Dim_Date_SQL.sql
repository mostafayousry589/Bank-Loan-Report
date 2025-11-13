
CREATE TABLE dbo.Dim_Date (
    [Date] DATE PRIMARY KEY,
	[Year] INT,
    [Month] INT,
    [Month_Name] NVARCHAR(20),
    [Day] INT,
    [Quarter] INT
);
GO

declare @earliest_date date=
	(SELECT MIN(issue_date) from Fact_Loan)

declare @last_date date=
	(SELECT max(issue_date) from Fact_Loan)

WHILE @earliest_date <= @last_date
BEGIN
   INSERT INTO dbo.Dim_Date (
      [Date],
	  [Year],
      [Month],
      [Month_Name],
      [Day],
      [Quarter]
      )
   SELECT
        @earliest_date,
		YEAR(@earliest_date),
        MONTH(@earliest_date),
        FORMAT(@earliest_date, 'MMMM'),
        DAY(@earliest_date),
        DATEPART(qq, @earliest_date)

   SET @earliest_date = DATEADD(day, 1, @earliest_date);
END
GO


