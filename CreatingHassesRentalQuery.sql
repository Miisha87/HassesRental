USE master 
GO 

--DROP DATABASE HassesRental
--GO 

CREATE DATABASE HassesRental
GO 

USE HassesRental
GO 

CREATE TABLE Genre (
GenreId int PRIMARY KEY Identity, 
GenreName nvarchar(50) not null
) 
GO 

CREATE TABLE Rating (
RatingId int PRIMARY KEY Identity,
RatingScore decimal(3,1) NOT NULL 
) 
GO

CREATE TABLE Offer (
OfferId int PRIMARY KEY Identity, 
OfferName nvarchar(50) NOT NULL,
PriceModifier decimal(3,2) NOT NULL
) 
GO 

CREATE TABLE Address (
AddressId int PRIMARY KEY Identity, 
StreetName nvarchar(100) NOT NULL, 
ZipCode int NOT NULL, 
City nvarchar(50) NOT NULL
) 
GO 

CREATE TABLE MembershipLevel ( 
MembershipLevelId int PRIMARY KEY Identity, 
LevelName nvarchar(50) NOT NULL, 
PriceModifier decimal(3,2) NOT NULL
) 
GO 

CREATE TABLE PaymentMethod (
PaymentMethodId int PRIMARY KEY Identity, 
MethodName nvarchar(50) NOT NULL, 
) 
GO 


CREATE TABLE Person ( 
PersonId int PRIMARY KEY Identity, 
FirstName nvarchar(50) NOT NULL, 
LastName nvarchar(50) NOT NULL, 
AddressId int NOT NULL REFERENCES Address(AddressId)
)
GO 

CREATE TABLE Customer ( 
CustomerId int PRIMARY KEY Identity,
PersonId int NOT NULL REFERENCES Person(PersonId),
MembershipLevelId int NOT NULL REFERENCES MembershipLevel(MembershipLevelId)
) 
GO 


CREATE TABLE PriceLevel ( 
PriceLevelId int PRIMARY KEY Identity,
Price decimal(4,2) NOT NULL,
)
GO

CREATE TABLE Movie (
MovieId int PRIMARY KEY Identity, 
MovieTitle nvarchar(50) NOT NULL, 
GenreId int NOT NULL REFERENCES Genre(GenreId), 
PriceLevelId int NOT NULL REFERENCES PriceLevel(PriceLevelId),
RatingId int NOT NULL REFERENCES Rating(RatingId), 
OfferId int NOT NULL REFERENCES Offer(OfferId),
LocationId int NOT NULL REFERENCES Address(AddressId)

)
GO 

CREATE TABLE Rental ( 
RentalId int PRIMARY KEY Identity, 
MovieId int NOT NULL REFERENCES Movie(MovieId),
CustomerId int NOT NULL REFERENCES Customer(CustomerId), 
PickUpDate date NOT NULL, 
ReturnDate date NOT NULL 
) 
GO 

CREATE TABLE Payment (
PaymentId int PRIMARY KEY Identity, 
PaymentMethodId int NOT NULL REFERENCES PaymentMethod(PaymentMethodId),
RentalId int NOT NULL REFERENCES Rental(RentalId),
PaymentDate date NOT NULL
) 
GO 

CREATE TABLE Actor (
ActorId int PRIMARY KEY Identity, 
PersonId int NOT NULL REFERENCES Person(PersonId)
) 
GO 

CREATE TABLE Director (
DirectorId int PRIMARY KEY Identity, 
PersonId int NOT NULL REFERENCES Person(PersonId)
) 
GO 

CREATE TABLE MovieActor (
MovieId int FOREIGN KEY REFERENCES Movie(MovieId) NOT NULL,
ActorId int FOREIGN KEY REFERENCES Actor(ActorId) NOT NULL,
PRIMARY KEY (MovieId, ActorId)
) 
GO 


CREATE TABLE MovieDirector (
MovieId int REFERENCES Movie(MovieId) NOT NULL,
DirectorId int REFERENCES Director(DirectorId) NOT NULL,
PRIMARY KEY (MovieId, DirectorId)
) 
GO 

INSERT PriceLevel(Price)
VALUES 
(19.00),
(29.00),
(39.00), 
(49.00),
(59.00)
GO 

INSERT PaymentMethod(MethodName)
VALUES 
('Creditcard'),
('Cash'),
('DebitCard'),
('Swish') 
GO 

INSERT Address(StreetName, ZipCode, City)
VALUES ('Apostrofgatan 13', 78455, 'Kalix'),
('Hejsanvägen 11', 74564, 'Haparanda'), 
('Magigatan 123', 89765, 'Falun'), 
('Bygatan 12', 12344, 'Borlänge'),
('Tingelingvägen 14', 12345, 'Västerås'),
('Clooneygatan 1', 12333, 'Ödeshög'),
('Kändisgatan 12', 72326, 'Kristinehamn'),
('Shotgunroad 666', 89877, 'Alabama')

GO 

SET IDENTITY_INSERT ADDRESS ON
GO 

INSERT Address (AddressId, StreetName, ZipCode, City)
VALUES (9999, 'The Warehouse', 11111, 'InStore')
GO 

SET IDENTITY_INSERT ADDRESS OFF 
GO 

INSERT Person (FirstName, LastName, AddressId)
VALUES ('Janne', 'Karlsson', 1), 
('Danne', 'Eriksson', 2),
('Nanne', 'Grönwall', 3),
('Manne', 'Kattson', 4),
('Ingmar', 'Bergman', 5),
('George', 'Clooney', 6),
('Demi', 'Moore', 7),
('Quentin', 'Tarantino', 8)
GO

INSERT Actor (PersonId)
VALUES (6), (7)
GO 

INSERT Director (PersonId)
VALUES (5), (8)
GO 

INSERT MembershipLevel (LevelName, PriceModifier)
VALUES ('Standard', 1), ('Silver', 0.9), ('Gold', 0.75)
GO

INSERT Customer (PersonId, MembershipLevelId)
VALUES (1, 1), (2, 2), (3, 3), (4, 3)
GO

INSERT GENRE (GenreName)
VALUES ('Horror'), ('Comedy'), ('Drama'), ('Action'), ('Documentary')
GO

INSERT RATING (RatingScore)
VALUES (1.0), (2.0), (3.0), (4.0), (5.0), (6.0), (7.0), (8.0), (9.0), (10.0)
GO 

INSERT OFFER (OfferName, PriceModifier)
VALUES ('Standard', 1), ('ThreeForTwo', 0.66), ('HalfPriceFriday', 0.5)
GO 

INSERT Movie (MovieTitle, GenreId, RatingId, OfferId, PriceLevelId, LocationId)
VALUES ('Kill Bill', 4, 9, 1, 2, 9999), ('Oceans Eleven', 4, 7, 2, 1, 9999), ('Alien', 1, 5, 3, 4, 9999), ('Titanic', 3, 4, 1, 1, 9999), ('Young at heart', 5, 10, 1, 5, 9999)
GO 


INSERT MovieActor (MovieId, ActorId)
VALUES (2, 1), (1, 1), (3, 1), (4, 1), (5, 2), (5, 1), (3, 2)
GO

INSERT MovieDirector (MovieId, DirectorId)
VALUES (1, 2), (2, 2), (3, 1), (4, 1), (5, 2)
GO

INSERT Rental (MovieId, CustomerId, PickUpDate, ReturnDate)
VALUES (1, 1, '2019-06-13', '2019-06-14'), (1, 2, '2019-07-01', '2019-07-02'), (2, 3, '2019-05-22', '2019-05-23'), (3, 4, '2019-01-02', '2019-01-03'), (4, 1, '2019-02-22', '2019-02-23')


INSERT Payment (PaymentMethodId, RentalId, PaymentDate)
VALUES (1, 1, '2019-06-13'), (2, 2, '2019-07-01'), (3, 3, '2019-05-22'), (1, 4, '2019-01-02'), (1, 5, '2019-02-22')









