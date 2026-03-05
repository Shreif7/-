




--=== Create database ===

CREATE DATABASE Traffic_Analytics;
GO

USE Traffic_Analytics;
GO




--=== Create dimensions table ======

CREATE TABLE Dim_Area (
    Area_ID INT PRIMARY KEY IDENTITY(1,1),
    Area_Name VARCHAR(100) NOT NULL,
    Population INT,
    Area_Type VARCHAR(50),
    Avg_Income FLOAT,
    Latitude FLOAT,
    Longitude FLOAT
);

--==============================================================

--======== Create Roads Table ======

CREATE TABLE Dim_Road (
    Road_ID INT PRIMARY KEY IDENTITY(1,1),
    Road_Name VARCHAR(150) NOT NULL,
    Area_ID INT NOT NULL,
    Road_Type VARCHAR(50),
    Lanes_Count INT,
    Road_Length_KM FLOAT,
    Speed_Limit INT,
    Has_Traffic_Light BIT,

    CONSTRAINT FK_Road_Area
    FOREIGN KEY (Area_ID) REFERENCES Dim_Area(Area_ID)
);


--==============================================================

--============ Create schedule =======

CREATE TABLE Dim_Time (
    Time_ID INT PRIMARY KEY IDENTITY(1,1),
    Date DATE NOT NULL,
    Year INT,
    Month INT,
    Day INT,
    Day_Name VARCHAR(20),
    Is_Weekend BIT,
    Hour INT,
    Time_Period VARCHAR(20)
);

--==============================================================

--=========== Create weather table ==========

CREATE TABLE Dim_Weather (
    Weather_ID INT PRIMARY KEY IDENTITY(1,1),
    Date DATE NOT NULL,
    Temperature FLOAT,
    Humidity FLOAT,
    Wind_Speed FLOAT,
    Visibility_KM FLOAT,
    Weather_Condition VARCHAR(50)
);



--==============================================================

--=========== Create a table of vehicle types ==========

CREATE TABLE Dim_Vehicle_Type (
    Vehicle_Type_ID INT PRIMARY KEY IDENTITY(1,1),
    Vehicle_Type_Name VARCHAR(50) NOT NULL,
    Avg_Size FLOAT
);



--==============================================================

--=========== Create traffic signs table =====

CREATE TABLE Dim_Traffic_Light (
    Traffic_Light_ID INT PRIMARY KEY IDENTITY(1,1),
    Road_ID INT NOT NULL,
    Signal_Cycle_Time INT,
    Has_Smart_System BIT,

    CONSTRAINT FK_TrafficLight_Road
    FOREIGN KEY (Road_ID) REFERENCES Dim_Road(Road_ID)
);



--==============================================================

--======= Create basic traffic table == Fact Tables ======


CREATE TABLE Fact_Traffic (
    Traffic_ID INT PRIMARY KEY IDENTITY(1,1),
    Road_ID INT NOT NULL,
    Time_ID INT NOT NULL,
    Weather_ID INT NOT NULL,
    Total_Vehicles INT,
    Avg_Speed FLOAT,
    Travel_Time_Min FLOAT,
    Congestion_Level VARCHAR(20),
    Congestion_Score FLOAT,

    CONSTRAINT FK_Traffic_Road
    FOREIGN KEY (Road_ID) REFERENCES Dim_Road(Road_ID),

    CONSTRAINT FK_Traffic_Time
    FOREIGN KEY (Time_ID) REFERENCES Dim_Time(Time_ID),

    CONSTRAINT FK_Traffic_Weather
    FOREIGN KEY (Weather_ID) REFERENCES Dim_Weather(Weather_ID)
);


--==============================================================

--============ Create Vehicles Details Table ========

CREATE TABLE Fact_Traffic_Details (
    Traffic_Detail_ID INT PRIMARY KEY IDENTITY(1,1),
    Traffic_ID INT NOT NULL,
    Vehicle_Type_ID INT NOT NULL,
    Vehicle_Count INT,

    CONSTRAINT FK_TrafficDetails_Traffic
    FOREIGN KEY (Traffic_ID) REFERENCES Fact_Traffic(Traffic_ID),

    CONSTRAINT FK_TrafficDetails_VehicleType
    FOREIGN KEY (Vehicle_Type_ID) REFERENCES Dim_Vehicle_Type(Vehicle_Type_ID)
);

--==============================================================

--======= Create Incidents Table ==========

CREATE TABLE Fact_Accidents (
    Accident_ID INT PRIMARY KEY IDENTITY(1,1),
    Road_ID INT NOT NULL,
    Time_ID INT NOT NULL,
    Weather_ID INT NOT NULL,
    Vehicles_Involved INT,
    Injuries_Count INT,
    Fatalities_Count INT,
    Accident_Cause VARCHAR(200),
    Response_Time_Min FLOAT,

    CONSTRAINT FK_Accident_Road
    FOREIGN KEY (Road_ID) REFERENCES Dim_Road(Road_ID),

    CONSTRAINT FK_Accident_Time
    FOREIGN KEY (Time_ID) REFERENCES Dim_Time(Time_ID),

    CONSTRAINT FK_Accident_Weather
    FOREIGN KEY (Weather_ID) REFERENCES Dim_Weather(Weather_ID)
);


--==============================================================

--============ Create Violations Table =============

CREATE TABLE Fact_Violations (
    Violation_ID INT PRIMARY KEY IDENTITY(1,1),
    Road_ID INT NOT NULL,
    Time_ID INT NOT NULL,
    Violation_Type VARCHAR(100),
    Fine_Amount FLOAT,

    CONSTRAINT FK_Violation_Road
    FOREIGN KEY (Road_ID) REFERENCES Dim_Road(Road_ID),

    CONSTRAINT FK_Violation_Time
    FOREIGN KEY (Time_ID) REFERENCES Dim_Time(Time_ID)
);

--==============================================================================================================================
--==============================================================================================================================
--==============================================================================================================================
--==============================================================================================================================


USE Traffic_Analytics;
GO

--------------------------------------------------
-- Reset Identity
--------------------------------------------------
DBCC CHECKIDENT ('AccidentsFacts', RESEED, 0);
DBCC CHECKIDENT ('TrafficFacts', RESEED, 0);
DBCC CHECKIDENT ('TimeDim', RESEED, 0);
DBCC CHECKIDENT ('Roads', RESEED, 0);
DBCC CHECKIDENT ('Areas', RESEED, 0);

--------------------------------------------------
-- Areas („‰«ÿﬁ ÕﬁÌﬁÌ…)
--------------------------------------------------
INSERT INTO Areas (AreaName, Population, AreaType, Latitude, Longitude)
VALUES
('Cairo Downtown', 950000, 'Commercial', 30.0444, 31.2357),
('Nasr City', 1200000, 'Residential', 30.0500, 31.3300),
('Heliopolis', 800000, 'Residential', 30.0910, 31.3300),
('New Cairo', 750000, 'Residential', 30.0300, 31.4700),
('Giza', 1400000, 'Mixed', 30.0131, 31.2089),
('Mohandessin', 600000, 'Commercial', 30.0550, 31.2000),
('6th of October', 900000, 'Residential', 29.9285, 30.9188),
('Maadi', 500000, 'Residential', 29.9600, 31.2569),
('Shubra', 1100000, 'Mixed', 30.0800, 31.2450),
('Dokki', 650000, 'Commercial', 30.0380, 31.2120);

--------------------------------------------------
-- Roads (ÿ—ﬁ ÕﬁÌﬁÌ…)
--------------------------------------------------
INSERT INTO Roads (RoadName, AreaID, RoadType, LanesCount, RoadLengthKM, SpeedLimit)
VALUES
('Ring Road',5,'Primary',6,20,90),
('Cairo Alexandria Desert Road',7,'Primary',5,18,100),
('Salah Salem Street',1,'Primary',4,8,60),
('Nasr Road',2,'Primary',4,6,60),
('Makram Ebeid Street',2,'Secondary',3,4,50),
('El Tahrir Street',10,'Primary',3,5,50),
('Gameat El Dowal Street',6,'Primary',4,6,60),
('El Haram Street',5,'Primary',5,7,60),
('Autostrad Road',8,'Primary',5,10,80),
('90 Street',4,'Primary',4,8,70),
('Ahmed Orabi Street',6,'Secondary',3,4,50),
('Ramses Street',1,'Primary',4,6,50),
('Corniche El Nile',1,'Primary',4,10,60),
('Shubra Street',9,'Primary',4,5,50),
('Dokki Street',10,'Secondary',3,4,50);

--------------------------------------------------
-- TimeDim (”‰… ﬂ«„·… 2025 = 8760 ”«⁄…)
--------------------------------------------------
DECLARE @StartDate DATETIME = '2025-01-01 00:00:00';

;WITH Hours AS (
    SELECT TOP (8760)
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS H
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)

INSERT INTO TimeDim
(Date,Year,Month,Day,DayName,IsWeekend,Hour,TimePeriod)

SELECT
DATEADD(HOUR,H,@StartDate),
YEAR(DATEADD(HOUR,H,@StartDate)),
MONTH(DATEADD(HOUR,H,@StartDate)),
DAY(DATEADD(HOUR,H,@StartDate)),
DATENAME(WEEKDAY,DATEADD(HOUR,H,@StartDate)),

CASE 
WHEN DATENAME(WEEKDAY,DATEADD(HOUR,H,@StartDate)) IN ('Friday','Saturday')
THEN 1 ELSE 0 END,

DATEPART(HOUR,DATEADD(HOUR,H,@StartDate)),

CASE
WHEN DATEPART(HOUR,DATEADD(HOUR,H,@StartDate)) BETWEEN 7 AND 10
THEN 'Morning Peak'

WHEN DATEPART(HOUR,DATEADD(HOUR,H,@StartDate)) BETWEEN 16 AND 20
THEN 'Evening Peak'

ELSE 'Normal'
END

FROM Hours;

--------------------------------------------------
--  Ê·Ìœ 50000 —ﬁ„
--------------------------------------------------
;WITH Numbers AS (
SELECT TOP 50000
ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) n
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
)

--------------------------------------------------
-- TrafficFacts (50K)
--------------------------------------------------
INSERT INTO TrafficFacts
(RoadID,TimeID,TotalVehicles,AvgSpeed,TravelTimeMin,
CongestionLevel,CongestionScore,
Temperature,Humidity,WeatherCondition,
VehicleCar,VehicleBus,VehicleTruck)

SELECT

ABS(CHECKSUM(NEWID())) % 15 + 1,

ABS(CHECKSUM(NEWID())) % 8760 + 1,

ABS(CHECKSUM(NEWID())) % 1500 + 300,

ABS(CHECKSUM(NEWID())) % 40 + 20,

ABS(CHECKSUM(NEWID())) % 40 + 10,

CASE 
WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN 'High'
WHEN ABS(CHECKSUM(NEWID())) % 3 = 1 THEN 'Medium'
ELSE 'Low'
END,

CAST(ABS(CHECKSUM(NEWID())) % 100 AS FLOAT)/100,

ABS(CHECKSUM(NEWID())) % 20 + 15,

ABS(CHECKSUM(NEWID())) % 40 + 40,

CASE
WHEN ABS(CHECKSUM(NEWID())) % 6 = 0 THEN 'Rainy'
WHEN ABS(CHECKSUM(NEWID())) % 6 = 1 THEN 'Fog'
ELSE 'Sunny'
END,

ABS(CHECKSUM(NEWID())) % 1200,

ABS(CHECKSUM(NEWID())) % 120,

ABS(CHECKSUM(NEWID())) % 80

FROM Numbers;

--------------------------------------------------
--  Ê·Ìœ 5000 —ﬁ„
--------------------------------------------------
;WITH Numbers AS (
SELECT TOP 5000
ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) n
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
)

--------------------------------------------------
-- AccidentsFacts (5K)
--------------------------------------------------
INSERT INTO AccidentsFacts
(RoadID,TimeID,VehiclesInvolved,InjuriesCount,FatalitiesCount,AccidentCause)

SELECT

ABS(CHECKSUM(NEWID())) % 15 + 1,

ABS(CHECKSUM(NEWID())) % 8760 + 1,

ABS(CHECKSUM(NEWID())) % 4 + 1,

ABS(CHECKSUM(NEWID())) % 6,

ABS(CHECKSUM(NEWID())) % 2,

CASE
WHEN ABS(CHECKSUM(NEWID())) % 4 = 0 THEN 'Speeding'
WHEN ABS(CHECKSUM(NEWID())) % 4 = 1 THEN 'Signal Violation'
WHEN ABS(CHECKSUM(NEWID())) % 4 = 2 THEN 'Driver Distraction'
ELSE 'Road Condition'
END

FROM Numbers;