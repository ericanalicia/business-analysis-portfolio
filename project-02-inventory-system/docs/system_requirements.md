# System Requirements Document (SRD)
## StyleStock — Inventory Management System

---

**Document Version:** 1.0
**Prepared By:** Erica (Junior System Analyst)
**Date:** 2024
**Status:** Draft

---

## 1. Business Context

StyleStock is an Australian fashion wholesaler supplying approximately 40 boutique stores across NSW and VIC. They stock 3 product categories: Women's Clothing, Men's Clothing, and Accessories.

**Current Problem:** Inventory is tracked in a shared Excel spreadsheet. This causes:
- Frequent stockouts (products run out before new stock is ordered)
- Overstock situations (too much cash tied up in slow-moving items)
- No visibility into which products need to be reordered
- Manual data entry errors

---

## 2. Stakeholders

| Stakeholder | Role | Needs |
|---|---|---|
| Operations Manager | Primary | Real-time stock visibility |
| Warehouse Team | User | Ability to log stock in/out |
| Finance Team | Secondary | Stock valuation reports |
| Buying Team | Secondary | Reorder alerts and recommendations |

---

## 3. Functional Requirements

These are the things the system **must do**:

| ID | Requirement |
|---|---|
| FR-01 | System must store a list of all products with their details |
| FR-02 | System must track current stock level for each product |
| FR-03 | System must record every stock movement (stock in / stock out) |
| FR-04 | System must identify products where stock is below the reorder level |
| FR-05 | System must calculate the total value of current inventory |
| FR-06 | System must show stock movement history for any product |

---

## 4. Non-Functional Requirements

These describe **how** the system should behave:

| ID | Requirement |
|---|---|
| NFR-01 | Data must be stored in a structured relational database |
| NFR-02 | Dashboard must refresh daily |
| NFR-03 | System must be accessible to non-technical staff via Power BI |
| NFR-04 | Data must be backed up weekly |

---

## 5. Out of Scope

- Integration with supplier ordering systems (future phase)
- Customer-facing inventory visibility
- Barcode scanning (future phase)

---

## 6. System Entities (What Data We Need to Store)

Based on the requirements above, we need to store data about:

| Entity | Description |
|---|---|
| **Products** | What we sell — name, category, price, reorder level |
| **Stock Levels** | How much of each product we currently have |
| **Stock Movements** | Every time stock comes in or goes out |
| **Suppliers** | Who we buy from |

---

## ✏️ Learning Note

A **System Requirements Document** is what separates a System Analyst from a data technician. Before designing any database or building any system, you must:
1. Understand the **business problem**
2. Identify **who** will use the system
3. List **what** the system must do (functional requirements)
4. List **how well** it must do it (non-functional requirements)

Employers in Australia — especially in fashion retail (e.g. The Iconic, Cotton On, Myer, David Jones) — look for analysts who can write clear, structured requirements documents.
