
--Move books
CREATE PROCEDURE MoveBooks
    @CurrentLocation int,
    @NewLocation int,
    @ISBN CHAR(13),
    @quantity Int = 1
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;
            IF NOT EXISTS (
                SELECT 1 FROM StockBalance
                WHERE ISBN = @ISBN AND Store_ID = @CurrentLocation AND InStock >= @quantity
            )
                BEGIN
                    RAISERROR ('Not enough books in stock', 16, 1)
                END;
            
            UPDATE StockBalance
            SET InStock = InStock - @quantity
            WHERE Store_ID = @CurrentLocation AND ISBN = @ISBN;

            IF EXISTS (
                SELECT 1 FROM StockBalance
                WHERE Store_ID = @NewLocation AND ISBN = @ISBN
            )
                BEGIN
                    UPDATE StockBalance
                    SET InStock = InStock + @quantity
                    WHERE Store_ID = @NewLocation AND ISBN = @ISBN;
                END;
            ELSE
                BEGIN 
                    INSERT INTO StockBalance (Store_ID, ISBN, InStock)
                    VALUES (@NewLocation, @ISBN, @quantity)
                END;
        COMMIT TRAN; 
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        PRINT ERROR_MESSAGE()
    END CATCH
END;