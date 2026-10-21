An end-to-end analytics engineering project demonstrating data transformation, warehouse modelling, automated testing, and data quality management using dbt and Snowflake.

## Project Overview

This project implements an ELT (Extract, Load, Transform) workflow for Airbnb data using Snowflake as the cloud data warehouse and dbt Core as the transformation framework.

The objective is to transform source data into structured, reusable, and analytics-ready datasets that can support business intelligence, reporting, and further analytical work.

The project demonstrates practical analytics engineering principles, including layered data modelling, reusable SQL transformations, dependency management, automated data quality testing, historical data tracking, documentation, and warehouse access controls.

Rather than treating data preparation as a collection of isolated SQL queries, the project organises transformations into a maintainable workflow in which dependencies, tests, and configurations are managed through dbt.

## Project at a Glance

- Component

- Description

- Project type

- ELT and analytics engineering

- Domain

- Short-term accommodation and marketplace data

- Data warehouse

- Snowflake

- Transformation framework

- dbt Core

- Languages

- SQL, Python

- Data modelling

- Source preparation and dimensional models

- Quality assurance

- dbt data tests and unit-test resources

- Historical tracking

- dbt snapshots

- Reporting readiness

- Curated warehouse datasets

- Version control

- Git and GitHub

## Business Problem

Marketplace data is often distributed across related entities and may require standardisation, cleaning, and validation before it can be used reliably for analysis.

For an accommodation marketplace such as Airbnb, analysts need consistent information about listings, hosts, pricing, and booking-related attributes to support reporting and operational decisions. Inconsistent source fields, incorrect joins, missing values, and poorly documented transformations can undermine the reliability of downstream analysis.

This project addresses the data preparation challenge by establishing a structured transformation layer in Snowflake. dbt manages the dependencies between models, supports repeatable execution, and enables tests to validate important assumptions about the resulting datasets.

The intended outcome is a more maintainable analytics foundation where data transformations are documented, testable, and reusable.

## Project Objectives

The main objectives are to:

Build a repeatable ELT workflow: Transform data already loaded into Snowflake through version-controlled dbt models.

Establish layered data models: Separate source preparation logic from downstream dimensional datasets.

Improve data reliability: Use automated tests to validate defined data quality expectations.

Optimise warehouse transformations: Apply appropriate materialisations and efficient SQL patterns.

Track historical changes: Use dbt snapshots for sources configured for change tracking.

Promote maintainability: Organise reusable logic, configurations, and dependencies in a structured project.

Improve transparency: Document model relationships, transformation rules, and data dependencies.

Support downstream analytics: Prepare consistent datasets for reporting and further analysis.

### Architecture

The project follows a warehouse-centric ELT architecture. Data is made available in Snowflake before dbt executes the transformation logic.

          Airbnb Source Data
                   |
                   v
          Snowflake Source Tables
                   |
                   v
           dbt Source Definitions
                   |
                   v
         Source Preparation Models
           (src / ephemeral)
                   |
                   v
          Dimensional Data Models
             (dim / tables)
                   |
                   v
         Automated Data Quality Tests
                   |
                   v
        Curated Analytics-Ready Tables
                   |
                   v
         BI, Reporting and Analysis

The diagram represents the logical flow. The actual execution order is determined by the dependencies declared in the dbt project.

## Architecture Components

1. Source layer

The source definitions identify upstream Snowflake tables and provide a consistent way for downstream models to reference them.

2. Preparation layer

Source preparation models centralise transformation logic and make downstream SQL easier to understand and maintain. The project configures the src model directory for ephemeral materialisation by default.

3. Dimensional layer

The dim model directory is configured for table materialisation by default. These models create persisted datasets for repeated querying and downstream analysis.

4. Testing layer

dbt tests validate the assumptions defined in the project. Tests can cover uniqueness, nullability, relationships, accepted values, and custom business rules, depending on the model configuration.

5. Historical tracking

dbt snapshots can preserve historical versions of records according to their configured strategies and unique keys.

6. Audit and access layer

Project hooks provide lightweight run auditing, while configured grants define access for specified Snowflake roles.

Important: This repository primarily implements the transformation stage of ELT. It relies on the required source data already being available in Snowflake; the project should not be interpreted as a complete external ingestion platform unless separate ingestion components are configured.

**Technology Stack**

Technology

Role in the project

- Snowflake

Cloud data warehouse and execution engine

- dbt Core

Model orchestration, transformation dependencies, testing, and documentation

- SQL

Data cleaning, joins, transformations, and dimensional modelling

- Python

Python-based transformation workflows

- Jinja

Templating and reusable dbt logic

- dbt seeds

Loading version-controlled reference datasets

- dbt snapshots

Tracking changes to configured records

- Git and GitHub

Version control and source code management

The project uses dbt packages declared in its package configuration. Run dbt deps to install the dependencies defined in the current repository rather than relying on assumed package versions.

## Data Transformation and Modelling

The project uses a layered modelling approach to separate source preparation from downstream analytical datasets.

Source Preparation Models

Models in the src directory prepare source data for downstream transformations.

This separation helps centralise common logic, improve readability, and reduce repetition across dependent models.

The directory is configured for ephemeral materialisation by default. Ephemeral models are compiled into dependent models as common table expressions rather than being created as standalone warehouse relations.

## Dimensional Models

The dim directory contains dimensional models configured as tables by default. These models provide persisted outputs for downstream queries and analysis.

Examples include:

dim_listing_cleansed — a cleaned Airbnb listing dataset.

dim_hosts_listing — a host and listing-related dataset used for downstream analysis.

dim_listing_night30 — a Python/Snowpark model associated with listings meeting a minimum-night threshold.

The model files are the authoritative source for each model's columns, join logic, filters, and business rules. These details may evolve as the project develops.

## Materialisation Strategy

The project uses a combination of dbt materialisations:

- Views: Provide a queryable transformation without storing the result as a physical table.

- Ephemeral models: Allow common preparation logic to be inlined into downstream SQL.

- Tables: Persist transformation results for repeated downstream access.

The project configuration sets a default materialisation, with directory-level overrides for src and dim. Individual models can override those settings.

The appropriate materialisation depends on the model's purpose, query performance, warehouse cost, and downstream usage.

- Seeds, Macros, Snapshots, and Analyses

- Seeds: Store small reference datasets in version control and load them into Snowflake through dbt.

- Macros: Encapsulate reusable SQL or Jinja logic to improve consistency and reduce duplication.

- Snapshots: Track changes to configured source records over time using the selected snapshot strategy.

- Analyses: Contain analytical SQL that does not necessarily need to be materialised as a dbt model.

Together, these resources extend the project beyond basic SQL transformation and support more maintainable analytics engineering workflows.

## Data Quality and Testing

Data quality is an essential part of a dependable analytics platform. A transformation can execute successfully and still produce incorrect or incomplete results, which is why automated validation is important.

The project contains dbt data tests and a unit-test resource. The exact checks and their current pass/fail status should be verified from the model YAML files and the latest execution output.

Depending on the configured tests, validation may include:

Uniqueness of key fields.

Non-null requirements for mandatory columns.

Referential integrity between related models.

Accepted values for categorical fields.

Row-count or source-to-model consistency expectations.

Custom business rules.

Unit tests for defined transformation behaviour.

Testing Commands

Run the project's data tests:

- dbt test

Build selected resources and execute their associated tests:

- dbt build

A passing result means that the selected tests passed against the data available at execution time. It does not guarantee that every possible data quality issue has been eliminated.

When a test fails, investigate whether the problem originates from the source data, transformation logic, schema changes, or an incorrect testing assumption before modifying the test.

Repository Structure

The repository contains the following main project resources:

AIRBNB-PROJECT---ELT/
├── analyses/          # Analytical SQL
├── assets/            # Supporting project assets
├── docs/              # Documentation resources
├── macros/            # Reusable dbt/Jinja logic
├── models/            # Source preparation and dimensional models
├── seeds/             # Version-controlled reference datasets
├── snapshots/         # Historical tracking definitions
├── tests/             # Test resources
├── dbt_project.yml    # Main dbt configuration
├── packages.yml       # Package dependencies
├── package-lock.yml   # Resolved package versions, if maintained
├── .gitignore         # Git exclusions
└── README.md          # Project documentation

The exact files and subdirectories may vary as the repository evolves. Generated folders such as target/ and installed dependencies such as dbt_packages/ are runtime artefacts rather than the primary project source files.

## Prerequisites

Before running the project, ensure that you have:

A Snowflake account with the necessary permissions.

Python installed and available from your terminal.

dbt Core and a compatible dbt-snowflake adapter.

Git installed.

Access to the configured Snowflake database, warehouse, schema, and roles.

The upstream tables referenced by the project's source definitions already loaded into Snowflake.

The project has previously been developed with dbt Core 1.11.x and the Snowflake adapter 1.11.x. Use compatible versions and verify your environment before running the project.

## Installation and Configuration

1. Clone the Repository

git clone https://github.com/bamzyyyy/AIRBNB-PROJECT---ELT.git
cd AIRBNB-PROJECT---ELT

2. Create a Virtual Environment

For macOS or Linux:

python3 -m venv .venv
source .venv/bin/activate

For Windows PowerShell:

python -m venv .venv
.venv\Scripts\Activate.ps1

3. Install dbt and the Snowflake Adapter

If the project does not provide a pinned requirements file, install the required packages in your active virtual environment:

python -m pip install --upgrade pip
python -m pip install dbt-core dbt-snowflake

Verify the installation:

dbt --version

For reproducible development, use the package versions tested by the project and record them in a dependency file.

4. Configure Snowflake Credentials

The dbt project uses the profile name airbnb. Configure the profile in:

~/.dbt/profiles.yml

Example configuration:

airbnb:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: "<your_snowflake_account_identifier>"
      user: "<your_snowflake_username>"
      password: "<your_snowflake_password>"
      role: "<your_snowflake_role>"
      database: AIRBNB
      warehouse: COMPUTE_WH
      schema: DEV
      threads: 4

Replace all placeholders with your own Snowflake configuration. The database, warehouse, and schema names reflect the development setup used for this project and should be adjusted if your environment differs.

For SSO, key-pair authentication, or another authentication method, use the corresponding dbt-snowflake configuration.

Security note: Keep credentials outside the repository. Never commit passwords, private keys, tokens, or other secrets to GitHub.

5. Install Project Dependencies

From the repository root:

dbt deps

This installs the packages declared in the project's package configuration.

6. Validate the Environment

Check the connection and configuration:

- dbt debug

Parse the project:

- dbt parse

Resolve connection, permission, dependency, and parsing errors before attempting a full build.

Running the Project

Execute dbt commands from the directory containing dbt_project.yml.

Compile the Project

- dbt compile

Compilation validates dbt parsing and SQL generation. It does not guarantee that every compiled query will execute successfully in Snowflake.

Run All Models

- dbt run

Run a single model:

dbt run --select dim_listing_cleansed

Run a model together with its upstream dependencies:

dbt run --select +dim_listing_cleansed

Replace the model name with one that exists in your current project.

Run Data Tests

dbt test

Execute Snapshots

dbt snapshot

Load Seeds

dbt seed

Build and Test Resources

dbt build

dbt build executes the selected resources according to the project's dependency graph and resource configuration. Review the terminal output to confirm which resources ran and whether each succeeded.

Generate Documentation

dbt docs generate
dbt docs serve

The generated documentation can provide model descriptions, column metadata, lineage, and test information where those details are defined and available.

Audit Logging and Access Control

The project's dbt_project.yml defines an on-run-start hook that creates an audit_log table if it does not already exist. A model-level post-hook inserts a record containing the model identifier and run timestamp after model execution.

The project also configures SELECT grants for the transform and reporter Snowflake roles.

These configurations depend on the roles existing and the executing role having the required privileges. Review the hook and grant definitions before running the project in a different environment.

The audit implementation provides basic execution records. It should not be confused with a complete monitoring platform: it does not, by itself, provide comprehensive failure tracking, alerting, execution-duration monitoring, or incident management.

Expected Outputs

After successful execution, the selected models are materialised in the target Snowflake database and schema according to their configurations.

Depending on the resources selected, outputs may include:

Cleaned listing datasets.

Host and listing-related dimensional datasets.

Python/Snowpark transformation outputs.

Seeded reference data.

Snapshot tables for configured historical tracking.

An audit_log table populated by the configured hooks.

The exact output names, schemas, and row counts depend on the current project files, source data, and execution configuration.

Troubleshooting

Connection or Profile Errors

If dbt debug fails:

Confirm that the airbnb profile exists in ~/.dbt/profiles.yml.

Verify the account identifier and authentication method.

Check your database, warehouse, schema, and role.

Confirm that the Snowflake role has the necessary privileges.

Dependency or Parsing Errors

If dbt deps or dbt parse fails:

Check packages.yml and the package lock file.

Install the declared dependencies.

Review model SQL and YAML configuration.

Investigate deprecation warnings and syntax errors.

Invalid Identifier Errors

If a model fails because a column cannot be found:

Confirm the column exists in the upstream relation.

Check the column name and casing.

Verify the source definitions and downstream SQL use consistent names.

Inspect the compiled SQL in target/compiled/.

Data Test Failures

If a test fails:

Identify the records or conditions violating the test.

Determine whether the problem is in the source data, transformation, or test assumption.

Fix the underlying issue where possible.

Re-run the affected model and tests to verify the correction.

Avoid removing or weakening a test merely to obtain a passing result.

Python Errors

If a Python model fails:

Check package availability and runtime compatibility.

Verify column references and data types.

Inspect null values before applying comparisons or filters.

Validate type conversions and threshold logic.

Run the affected model separately to isolate the problem.

Security Considerations

Never commit credentials or private keys.

Keep local connection profiles outside version control.

Use least-privilege access for development and reporting roles.

Review hooks and grants before executing against shared environments.

Avoid committing sensitive or restricted source data.

Keep environment-specific settings separate from reusable project code.

Future Enhancements

Potential improvements include:

Expanding model and column-level documentation.

Adding more business-rule and relationship tests.

Introducing source freshness checks where supported.

Improving audit records with status, duration, and error details.

Integrating CI checks for parsing, compilation, and selected tests.

Adding a documented data dictionary and model lineage diagram.

Connecting curated models to a BI dashboard with defined analytical questions.

Benchmarking frequently queried models and reviewing warehouse cost.

Adding automated deployment practices for controlled promotion between environments.

These are proposed extensions and should not be interpreted as features already implemented.

## Key Takeaways

This project demonstrates how dbt and Snowflake can be used to establish a structured, testable, and maintainable analytics transformation layer.

It brings together layered data modelling, reusable transformation logic, automated validation, historical tracking, documentation, and basic warehouse access configuration. The result is a foundation for producing analytics-ready datasets that can support reliable reporting and further business analysis.

The central engineering principle is that useful analytics depends not only on transforming data, but also on making those transformations consistent, transparent, testable, and maintainable.

## References

GitHub Repository: https://github.com/bamzyyyy/AIRBNB-PROJECT---ELT

dbt Documentation: https://docs.getdbt.com/

dbt and Snowflake Setup: https://docs.getdbt.com/docs/core/connect-data-platform/snowflake-setup

Snowflake Documentation: https://docs.snowflake.com/

Author: Aminu Oluwarotimi Desmond
Focus Areas: Analytics Engineering | ELT | dbt | Snowflake | SQL | Python | Data Modelling | Data Quality
