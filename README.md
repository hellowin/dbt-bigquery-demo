# dbt BigQuery Demo

A comprehensive guide to getting started with dbt (data build tool) and Google BigQuery. This project demonstrates how to set up and run dbt transformations using BigQuery as the data warehouse.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Google Cloud Platform Setup](#google-cloud-platform-setup)
- [BigQuery Setup](#bigquery-setup)
- [Python Environment Setup](#python-environment-setup)
- [dbt Installation](#dbt-installation)
- [Project Configuration](#project-configuration)
- [Authentication Setup](#authentication-setup)
- [Running Your First dbt Project](#running-your-first-dbt-project)
- [Understanding the Project Structure](#understanding-the-project-structure)
- [Next Steps](#next-steps)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before getting started, ensure you have:

- Python 3.8 or higher installed
- A Google Cloud Platform (GCP) account
- Basic knowledge of SQL
- Command line familiarity

## Google Cloud Platform Setup

### 1. Create a GCP Project

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Click on the project dropdown and select "New Project"
3. Enter a project name (e.g., "dbt-bigquery-demo", in this example I'm using "hellowin-dbt-demo")
4. Note your Project ID (you'll need this later)
5. Click "Create"

### 2. Set Up Authentication

We are using OAuth (Recommended for development). More options can be [read here](https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup#authentication-methods).

1. Make sure the gcloud command is [installed on your computer](https://cloud.google.com/sdk/docs/install)
2. Activate the application-default account with
    ```
    gcloud auth application-default login
    ```

## Working Environment Setup

### 1. Create a Virtual Environment (Recommended)

```bash
# Create a virtual environment
python -m venv .venv

# Activate the virtual environment
# On Linux/macOS:
source .venv/bin/activate

# On Windows:
# .venv\Scripts\activate
```

### 2. Install dbt-core and dbt-bigquery

```bash
pip install -r requirements.txt
```

This will install:
- `dbt-core==1.10.6` - The core dbt functionality
- `dbt-bigquery==1.10.1` - BigQuery adapter for dbt

### 3. Verify Installation

```bash
dbt --version
```

You should see output showing dbt version and installed adapters.

## Project Configuration

### 1. Update profiles.yml

The `profiles.yml` file contains your BigQuery connection details. Update it with your project information:

```yaml
demo:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: oauth  # or 'service-account'
      project: YOUR_GCP_PROJECT_ID  # Replace with your actual project ID
      dataset: demo  # Or your dataset name
      threads: 1
      # If using service account, add:
      # keyfile: /path/to/your/service-account-key.json
```

### 2. Update dbt_project.yml (if needed)

The project configuration is already set up, but you can modify:
- Project name
- Model configurations
- Other dbt settings

## Running Your First dbt Project

### 1. Test Your Connection

```bash
dbt debug
```

This command checks:
- dbt installation
- Profile configuration
- BigQuery connection
- Required permissions

### 2. Install Dependencies (if any)

```bash
dbt deps
```

### 3. Run dbt Models

```bash
dbt run
```

This command will:
- Compile your SQL models
- Execute them in BigQuery
- Create tables/views as defined in your models

### 4. Test Your Models

```bash
dbt test
```

### 5. Generate Documentation

```bash
dbt docs generate
dbt docs serve
```

This will create and serve documentation for your project at `http://localhost:8080`.

## Understanding the Project Structure

```
dbt-bigquery-demo/
├── dbt_project.yml          # Project configuration
├── profiles.yml             # Database connection settings
├── requirements.txt         # Python dependencies
├── models/                  # SQL model files
│   └── example/
│       ├── my_first_dbt_model.sql
│       ├── my_second_dbt_model.sql
│       └── schema.yml       # Model documentation and tests
├── macros/                  # Reusable SQL code
├── tests/                   # Custom data tests
├── seeds/                   # CSV files to load
├── snapshots/              # SCD Type 2 implementations
├── analyses/               # Analytical SQL files
└── target/                 # Compiled SQL and artifacts
```

### Key Files Explained

- **`models/`**: Contains your transformation logic in SQL
- **`dbt_project.yml`**: Main project configuration
- **`profiles.yml`**: Database connection configuration
- **`schema.yml`**: Model documentation, tests, and metadata

## Next Steps

1. **Explore Example Models**: Look at the example models in `models/example/`
2. **Create Your Own Models**: Add new `.sql` files in the `models/` directory
3. **Add Tests**: Define data quality tests in `schema.yml` files
4. **Add Documentation**: Document your models with descriptions
5. **Learn dbt Features**: Explore macros, packages, and advanced configurations

### Useful dbt Commands

```bash
# Run specific models
dbt run --select my_first_dbt_model

# Run models with tags
dbt run --select tag:example

# Run in full-refresh mode
dbt run --full-refresh

# Compile without running
dbt compile

# Run and test
dbt build
```

## Troubleshooting

### Common Issues

1. **Authentication Errors**
   - Verify your GCP credentials are set up correctly
   - Check that required APIs are enabled
   - Ensure your service account has proper permissions

2. **Permission Errors**
   - Verify BigQuery permissions (BigQuery Admin, Data Editor, Job User)
   - Check that your dataset exists and is accessible

3. **Connection Issues**
   - Run `dbt debug` to diagnose connection problems
   - Verify your `profiles.yml` configuration
   - Check your project ID is correct

4. **Model Compilation Errors**
   - Review SQL syntax in your models
   - Check for missing dependencies
   - Verify column names and references

### Getting Help

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Community Slack](https://getdbt.slack.com/)
- [BigQuery Documentation](https://cloud.google.com/bigquery/docs)

## Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is provided as-is for educational purposes.