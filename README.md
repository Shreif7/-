# SQL & Relational Data Engineering
---

## 📌 Project Overview

This project is an **end-to-end Traffic Data Engineering System** built to **collect, structure, and maintain large-scale urban traffic and accident data**.  

Key objectives:

- Design a normalized relational database schema  
- Handle high-volume traffic data generation  
- Implement ETL pipelines for efficient data ingestion  
- Maintain referential integrity across multiple tables  
- Prepare datasets for analytics and predictive modeling  

This project highlights **advanced SQL skills** and **database engineering expertise** within the context of urban traffic data.

---

## 🎯 Business Problem

Urban traffic management faces several challenges:

1. Fragmented traffic and accident data from multiple sources  
2. Inconsistent and incomplete datasets  
3. Lack of a structured repository to integrate **time, road, area, and event data**  
4. Difficulty in generating insights due to poor data quality  
5. Need for scalable pipelines for future live traffic data  

The project demonstrates **how to build a robust data foundation** to support analytics and predictive modeling.

---

## 🛠 Tools & Technologies Used

- **SQL Server** → Database design, normalization, ETL pipelines  
- **CTEs & Views** → Advanced data transformation  
- **Stored Procedures** → Batch data insertion and automated updates  
- **Python (Pandas, SQLAlchemy)** → Data generation, validation, and loading  
- **Power BI / BI Tools** → Optional visualization layer  
- **Data Modeling Concepts** → Star schema, dimensional modeling for traffic facts  

---

## 🧹 Data Engineering & Transformation

Key steps performed:

- Designed **Areas, Roads, TimeDim, TrafficFacts, AccidentsFacts** tables  
- Implemented **foreign key constraints** for referential integrity  
- Generated **50,000+ traffic records** and **5,000+ accident records**  
- Built **TimeDim** for a full year (8760 hours)  
- Simulated realistic traffic patterns for **peak hours, weekends, and special events**  
- Used SQL **CTEs and random data generation** for scalable dataset creation  

---

## 📊 Database Schema Highlights

| Table | Purpose | Key Columns |
|-------|--------|------------|
| Areas | Define city areas | AreaID, AreaName, Population, Type, Latitude, Longitude |
| Roads | Store road info | RoadID, RoadName, AreaID, Lanes, LengthKM, SpeedLimit |
| TimeDim | Hour-level timestamps | TimeID, Date, Year, Month, Day, Hour, TimePeriod |
| TrafficFacts | Hourly traffic metrics | TrafficID, RoadID, TimeID, TotalVehicles, AvgSpeed, CongestionLevel, VehicleTypes |
| AccidentsFacts | Accident events | AccidentID, RoadID, TimeID, VehiclesInvolved, InjuriesCount, FatalitiesCount, Cause |

---

## 🔎 Key Engineering Tasks

1. **Data Generation** → Python & SQL scripts to simulate realistic traffic & accident records  
2. **ETL Pipelines** → Extract, Transform, Load into structured schema  
3. **Referential Integrity** → Ensure valid RoadID and TimeID in all fact tables  
4. **Scalability & Maintenance** → Batch insert procedures, ready for live data ingestion  
5. **Optimizations** → Indexing, partitioning potential for high performance  

---

## 💡 Best Practices Applied

- Dimension tables for Areas, Roads, Time  
- Fact tables for TrafficFacts & AccidentsFacts  
- Data validation for speed, vehicles, travel time  
- Scripts ensure reproducible test data  
- Schema designed for high scalability  

---

## 🚀 Skills Demonstrated

- Advanced SQL & Database Design  
- Data Modeling & Normalization  
- ETL Pipeline Design  
- High-Volume Data Generation & Loading  
- Referential Integrity & Constraint Management  
- Preparing Data for Analytics & Predictive Modeling  

---

## ⭐ Conclusion

This **Traffic Data Engineering Project** demonstrates the ability to:

- Build a robust, normalized database from scratch  
- Manage and scale large volumes of traffic & accident data  
- Maintain high-quality, referentially-integrated datasets  
- Provide a strong foundation for analytics, dashboards, and predictive models  

It highlights **SQL expertise**, **data engineering skills**, and readiness to handle **complex real-world datasets**.

---

## 👤 Author

**Sherif Elfiky**  
Data Analyst | Building robust pipelines and data foundations for urban analytics
