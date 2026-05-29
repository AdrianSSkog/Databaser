USE BookStore;
GO

--Move books from one store to another

CREATE PROCEDURE MoveBooks
    @FromLocation int,
    @ToLocation int,
    @ISBN VARCHAR(13),
    @quantity Int = 1
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;
            IF NOT EXISTS (
                SELECT 1 FROM StockBalance
                WHERE ISBN = @ISBN AND Store_ID = @FromLocation AND InStock >= @quantity
            )
                BEGIN
                    THROW 50001, 'Not enough books in stock', 1;
                END;
            
            UPDATE StockBalance
            SET InStock = InStock - @quantity
            WHERE Store_ID = @FromLocation AND ISBN = @ISBN;

            IF EXISTS (
                SELECT 1 FROM StockBalance
                WHERE Store_ID = @ToLocation AND ISBN = @ISBN
            )
                BEGIN
                    UPDATE StockBalance
                    SET InStock = InStock + @quantity
                    WHERE Store_ID = @ToLocation AND ISBN = @ISBN;
                END;
            ELSE
                BEGIN 
                    INSERT INTO StockBalance (Store_ID, ISBN, InStock)
                    VALUES (@ToLocation, @ISBN, @quantity)
                END;
        COMMIT TRAN; 
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        THROW;
    END CATCH
END;
GO

-- Test stored procedure

EXEC MoveBooks
    @FromLocation = 1,
    @ToLocation = 2,
    @ISBN = '9780307743664',
    @quantity = 1;
GO