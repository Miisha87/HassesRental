USE master 
GO 

DROP DATABASE HassesRental
GO 

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
LastName nvarchar(50) NOT NULL
)
GO 

CREATE TABLE Customer ( 
CustomerId int PRIMARY KEY Identity,
PersonId int NOT NULL REFERENCES Person(PersonId),
MembershipLevelId int NOT NULL REFERENCES MembershipLevel(MembershipLevelId), 
AddressId int NOT NULL REFERENCES Address(AddressId)
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
GenreId int NULL REFERENCES Genre(GenreId), 
PriceLevelId int NULL REFERENCES PriceLevel(PriceLevelId),
RatingId int NOT NULL DEFAULT 1 REFERENCES Rating(RatingId), 
OfferId int NOT NULL DEFAULT 1 REFERENCES Offer(OfferId),
InStock bit NOT NULL DEFAULT 1
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

--CREATE TABLE Actor (
--ActorId int PRIMARY KEY Identity, 
--PersonId int NOT NULL REFERENCES Person(PersonId)
--) 
--GO 

--CREATE TABLE Director (
--DirectorId int PRIMARY KEY Identity, 
--PersonId int NOT NULL REFERENCES Person(PersonId)
--) 
--GO 

CREATE TABLE MovieActor (
MovieId int FOREIGN KEY REFERENCES Movie(MovieId) NOT NULL,
ActorId int FOREIGN KEY REFERENCES Person(PersonId) NOT NULL,
PRIMARY KEY (MovieId, ActorId)
) 
GO 


CREATE TABLE MovieDirector (
MovieId int REFERENCES Movie(MovieId) NOT NULL,
DirectorId int REFERENCES Person(PersonId) NOT NULL,
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

INSERT Person (FirstName, LastName) VALUES 
('Janne', 'Karlsson'), 
('Danne', 'Eriksson'),
('Nanne', 'Grönwall'),
('Manne', 'Kattson'),
('Ingmar', 'Bergman'),
('George', 'Clooney'),
('Demi', 'Moore'),
('Quentin', 'Tarantino')
GO

--INSERT Actor (PersonId)
--VALUES (6), (7)
--GO 

--INSERT Director (PersonId)
--VALUES (5), (8)
--GO 

INSERT MembershipLevel (LevelName, PriceModifier)
VALUES ('Standard', 1), ('Silver', 0.9), ('Gold', 0.75)
GO

INSERT Customer (PersonId, MembershipLevelId, AddressId) VALUES 
(1, 1, 1), 
(2, 2, 2), 
(3, 3, 3), 
(4, 3, 4)
GO

INSERT GENRE (GenreName)
VALUES ('Horror'), ('Comedy'), ('Drama'), ('Action'), ('Documentary')
GO

INSERT RATING (RatingScore)
VALUES (1.0), (2.0), (3.0), (4.0), (5.0), (6.0), (7.0), (8.0), (9.0), (10.0)
GO 

INSERT OFFER (OfferName, PriceModifier) VALUES 
('Standard', 1), 
('ThreeForTwo', 0.66), 
('HalfPriceFriday', 0.5)
GO 

INSERT Movie (MovieTitle, GenreId, RatingId, OfferId, PriceLevelId) VALUES 
('Kill Bill', 4, 9, 1, 2), 
('Oceans Eleven', 4, 7, 2, 1), 
('Alien', 1, 5, 3, 4), 
('Titanic', 3, 4, 1, 1), 
('Young at heart', 5, 10, 1, 5)
GO 


INSERT MovieActor (MovieId, ActorId) VALUES 
(2, 6), 
(1, 6), 
(3, 6), 
(4, 6), 
(5, 7), 
(5, 6), 
(3, 7)
GO

INSERT MovieDirector (MovieId, DirectorId) VALUES 
(1, 8), 
(2, 8), 
(3, 5), 
(4, 5), 
(5, 8)
GO

INSERT Rental (MovieId, CustomerId, PickUpDate, ReturnDate)
VALUES (1, 1, '2019-06-13', '2019-06-14'), (1, 2, '2019-07-01', '2019-07-02'), (2, 3, '2019-05-22', '2019-05-23'), (3, 4, '2019-01-02', '2019-01-03'), (4, 1, '2019-02-22', '2019-02-23')


INSERT Payment (PaymentMethodId, RentalId, PaymentDate)
VALUES (1, 1, '2019-06-13'), (2, 2, '2019-07-01'), (3, 3, '2019-05-22'), (1, 4, '2019-01-02'), (1, 5, '2019-02-22')




--SELECT ActorId, COUNT(MovieId) NumberofMovies FROM MovieActor
--GROUP BY ActorId

