# Data Overview

Column definitions, keys and relationships:
[Synthea CSV Data Dictionary](https://github.com/synthetichealth/synthea/wiki/CSV-File-Data-Dictionary)
(describes the latest Synthea version; checked against v4.0.0 output on 2026-10-15).

Findings per table (keys, missing values, codes) with the queries behind them:
[notebooks/01_data_overview.ipynb](../notebooks/01_data_overview.ipynb).

### General
Dental data uses different coding systems than the rest of the dataset:
ICD10 in `conditions` and CDT in `procedures` (SNOMED-CT elsewhere).
In several tables one code has two descriptions that differ only in letter case,
punctuation or spacing (`conditions`, `medications`, `observations`, `procedures`),
or a short and a long form (`immunizations`).

## Core tables

| Table        |      Rows | Size (MB) | One row =                                               |
|--------------|----------:|----------:|---------------------------------------------------------|
| patients     |     1,154 |       0.3 | one patient                                             |
| encounters   |   193,633 |      64.1 | one encounter                                           |
| conditions   |   105,497 |      15.4 | one condition recorded for one patient at one encounter |
| medications  |   111,345 |      29.4 | one medication order for one patient                    |
| observations | 2,328,638 |     402.3 | one measurement or answer for one patient               |
| procedures   |   454,904 |      92.2 | one procedure for one patient at one encounter          |

## Other tables

| Table             |    Rows | Size (MB) | One row =                                     |
|-------------------|--------:|----------:|-----------------------------------------------|
| imaging_studies   | 117,837 |      41.3 | one image (117,837 images from 4,648 studies) |
| immunizations     |  61,740 |       8.5 | one vaccination for one patient at encounter  |
| payer_transitions |  41,902 |       7.1 | one insurance period for one patient          |
| supplies          |  21,235 |       3.2 | one supply item for one patient at encounter  |
| careplans         |  10,098 |       2.0 | care plan for one patient                     |
| devices           |   3,266 |       0.8 | med device for one patient                    |
| allergies         |   1,283 |       0.2 | one allergy or intolerance for one patient    |
| providers         |     858 |       0.2 | one provider                                  |
| organizations     |     858 |       0.1 | one organization                              |
| payers            |      10 |     0.002 | one payer                                     |

Total: ~667 MB.

## Excluded tables
`claims`, `claims_transactions`, `patient_expenses`: billing data, see `decisions.md`.