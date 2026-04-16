#📊 computer_sales_data_engineering_project 

🚀 Project Overview
This project demonstrates the design and implementation of an end-to-end data engineering pipeline for a computer sales business.
The goal is to transform raw transactional data into high-quality, analytics-ready datasets that support data-driven decision-making.

🧠 Business Problem
The business lacked:

*Centralized sales reporting

*Visibility into product profitability

*Insights into customer purchasing behavior

*Performance tracking for sales employees

This project solves these challenges by building a scalable and automated data platform.
**Repository structure**

DATA ARCHITECTURE

<img width="958" height="495" alt="data modelling planning " src="https://github.com/user-attachments/assets/3b69feb7-d567-45f0-9760-8d6ab2280aef" />

<img width="771" height="731" alt="Untitled Diagram" src="https://github.com/user-attachments/assets/c40f9987-aba8-4eb8-9839-7d9169b1dcd5" />

DATA SECURITY 

## 🔐 Data Security & Governance

To ensure secure and reliable data handling:

### 🔒 Access Control

* Role-Based Access Control (RBAC):

  * Data Engineer → Full access
  * Data Analyst → Read-only
  * Business manager → Restricted views

<img width="352" height="335" alt="andile_data_engineer_server_roles" src="https://github.com/user-attachments/assets/2cc3b679-b742-4e6d-80fc-16edb8ee742d" />

<img width="350" height="332" alt="ketro_data_analyst_server_roles" src="https://github.com/user-attachments/assets/263c8d38-faa6-4e01-8365-a4f13c724412" />

<img width="353" height="335" alt="rhofiwa_business_manager_server_roles" src="https://github.com/user-attachments/assets/51974f51-dbe8-49b5-b5a7-edcc812113d5" />

DATASET

<img width="422" height="59" alt="image" src="https://github.com/user-attachments/assets/b0bfac0c-c3e1-4afc-b2cb-033808e0a685" />


SCRIPTS

<img width="502" height="243" alt="image" src="https://github.com/user-attachments/assets/0835c8b8-3b32-4d47-b4ce-f58f68a899c5" />


VERSION CONTROL
## 🔁 Version Control

Version control was implemented using Git:

### Key Practices:

* Feature-based branching
* Meaningful commit messages
* Code version tracking
* Collaboration-ready structure

<img width="449" height="116" alt="image" src="https://github.com/user-attachments/assets/c6676697-9b2e-4c90-9c36-d7a26833bcfd" />


LICENSE

<img width="356" height="196" alt="image" src="https://github.com/user-attachments/assets/52c589d3-2bed-4830-b560-63590a4ad5f4" />


README.md



``` 🏗️ Data Architecture


Source (CSV) → Ingestion → Data Lake → Transformation → Data Warehouse → BI Dashboard
```

### Components:

* **Data Source:** Raw PC sales dataset
* **Ingestion: SQL scripts
* **Storage:** Data lake (raw, processed, curated layers)
* **Transformation:** SQL + Python
* **Warehouse:** Structured star schema


---

## 🔄 Data Engineering Workflow

### 1. Data Ingestion

* Loaded raw CSV data using Python
* Stored data in the **raw layer** of the data lake

---

### 2. Data Storage (Medallion Architecture)

* **Raw Layer:** Original dataset**
* **Processed Layer:** Cleaned and standardized data
* **Curated Layer:** Business-ready datasets

---

### 3. Data Transformation

* Handled missing values and inconsistencies
* Standardized formats (dates, pricing, categories)


### 4. Data Modelling (Star Schema ⭐)

#### Fact Table:

#### Dimension Tables:


## 🔐 Data Security & Governance

To ensure secure and reliable data handling:

### 🔒 Access Control

* Role-Based Access Control (RBAC):

  * Data Engineer → Full access
  * Data Analyst → Read-only
  * Business manager → Restricted views



## 🧪 Data Quality Checks

Implemented validation checks:

* Null value detection
* Duplicate removal
* Invalid pricing checks

Ensures **high data reliability and trust**.

---

## ⚙️ Pipeline Automation

* Automated workflows using orchestration (Airflow-ready design)
* Scheduled data refreshes
* Reduced manual intervention

---

## ☁️ Scalability & Future Improvements

* Cloud migration (AWS / Azure)
* Real-time streaming pipelines
* Integration with APIs
* Advanced analytics (ML models)

---

## 📈 Business Impact

This solution enables:

* Better pricing strategies
* Improved sales performance tracking
* Data-driven decision making
* Increased operational efficiency

---

## 🛠️ Tech Stack

* Python
* SQL
* Power BI
* Git & GitHub
* (Optional: Airflow, Snowflake, AWS/Azure)

---

## 👨‍💻 Author

Andile Dube


