USE [HotelManagement]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[EmployeeID] [int] NOT NULL,
	[Password] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[GuestID] [int] NOT NULL,
	[RoomID] [int] NOT NULL,
	[CheckInDate] [date] NOT NULL,
	[CheckOutDate] [date] NOT NULL,
	[TotalPrice] [int] NOT NULL,
	[BookingStatus] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Position] [nvarchar](100) NOT NULL,
	[Department] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Guest]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guest](
	[GuestID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GuestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[RoomType] [nvarchar](100) NOT NULL,
	[FloorNumber] [int] NOT NULL,
	[BedType] [nvarchar](100) NOT NULL,
	[Price] [int] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([GuestID])
REFERENCES [dbo].[Guest] ([GuestID])
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
/****** Object:  StoredProcedure [dbo].[CheckAccount]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckAccount]
	@EmployeeID INT,
	@Password NVARCHAR(255)
AS
BEGIN 
	SELECT * FROM Account WHERE EmployeeID = @EmployeeID AND Password = @Password; 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteBooking]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteBooking]
    @BookingID INT
AS
BEGIN
    DELETE FROM Booking
    WHERE BookingID = @BookingID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteEmployee]
    @EmployeeID INT
AS
BEGIN
    DELETE FROM Employee
    WHERE EmployeeID = @EmployeeID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteGuest]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteGuest] 
	@GuestID INT 
AS 
BEGIN 
	DELETE FROM Guest 
	WHERE GuestID = @GuestID 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteRoom]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteRoom]
    @RoomID INT
AS
BEGIN
    DELETE FROM Room WHERE RoomID = @RoomID
END
GO
/****** Object:  StoredProcedure [dbo].[InsertBooking]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBooking]
	@GuestID INT,  
	@RoomID INT,
	@CheckInDate DATE,
	@CheckOutDate DATE, 
	@TotalPrice INT,
	@BookingStatus NVARCHAR(20) 
AS 
BEGIN 
	INSERT INTO Booking (GuestID, RoomID, CheckInDate, CheckOutDate, TotalPrice, BookingStatus) 
	VALUES (@GuestID, @RoomID, @CheckInDate, @CheckOutDate, @TotalPrice, @BookingStatus)

	UPDATE Room SET Status = 'Not Available' WHERE RoomID = @RoomID
END
GO
/****** Object:  StoredProcedure [dbo].[InsertEmployee]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	-- Employee

CREATE PROCEDURE [dbo].[InsertEmployee]
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @Position NVARCHAR(100),
    @Department NVARCHAR(100),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20)
AS
BEGIN
    INSERT INTO Employee (FirstName, LastName, Position, Department, Email, Phone)
    VALUES (@FirstName, @LastName, @Position, @Department, @Email, @Phone)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertGuest]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	-- GUEST 

CREATE PROCEDURE [dbo].[InsertGuest]
    @Name NVARCHAR(100),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @Address NVARCHAR(200)
AS
BEGIN
    INSERT INTO Guest (Name, Email, Phone, Address)
    VALUES (@Name, @Email, @Phone, @Address)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertRoom]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	-- Room 

CREATE PROCEDURE [dbo].[InsertRoom]
    @RoomType NVARCHAR(100),
    @FloorNumber INT,
    @BedType NVARCHAR(100),
    @Price INT,
    @Status NVARCHAR(20)
AS
BEGIN
    INSERT INTO Room (RoomType, FloorNumber, BedType, Price, Status)
    VALUES (@RoomType, @FloorNumber, @BedType, @Price, @Status)
END
GO
/****** Object:  StoredProcedure [dbo].[SearchBooking]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchBooking]
    @BookingID NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Booking
    WHERE BookingID LIKE '%' + @BookingID + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[SearchEmployee]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchEmployee]
    @EmployeeID NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Employee
    WHERE EmployeeID LIKE '%' + @EmployeeID + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[SearchGuest]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchGuest]
    @Name NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Guest
    WHERE Name LIKE '%' + @Name + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[SearchRoom]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchRoom]
    @RoomID INT
AS
BEGIN
    SELECT * FROM Room
    WHERE RoomID LIKE '%' + CAST(@RoomID AS NVARCHAR) + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateBooking]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateBooking]
    @BookingID INT,
    @GuestID INT,
    @RoomID INT,
    @CheckInDate DATE,
    @CheckOutDate DATE,
    @TotalPrice INT,
    @BookingStatus NVARCHAR(20)
AS
BEGIN
    UPDATE Booking
    SET GuestID = @GuestID,
        RoomID = @RoomID,
        CheckInDate = @CheckInDate,
        CheckOutDate = @CheckOutDate,
        TotalPrice = @TotalPrice,
        BookingStatus = @BookingStatus
    WHERE BookingID = @BookingID
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateEmployee]
    @EmployeeID INT,
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @Position NVARCHAR(100),
    @Department NVARCHAR(100),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20)
AS
BEGIN
    UPDATE Employee
    SET FirstName = @FirstName,
        LastName = @LastName,
        Position = @Position,
        Department = @Department,
        Email = @Email,
        Phone = @Phone
    WHERE EmployeeID = @EmployeeID
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateGuest]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateGuest]
    @GuestID INT,
    @Name NVARCHAR(100),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @Address NVARCHAR(200)
AS
BEGIN
    UPDATE Guest
    SET Name = @Name,
        Email = @Email,
        Phone = @Phone,
        Address = @Address
    WHERE GuestID = @GuestID
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateRoom]    Script Date: 26/11/2024 9:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateRoom]
    @RoomID INT,
    @RoomType NVARCHAR(100),
    @FloorNumber INT,
    @BedType NVARCHAR(100),
    @Price INT,
    @Status NVARCHAR(20)
AS
BEGIN
    UPDATE Room
    SET RoomType = @RoomType,
        FloorNumber = @FloorNumber,
        BedType = @BedType,
        Price = @Price,
        Status = @Status
    WHERE RoomID = @RoomID
    
END
GO
