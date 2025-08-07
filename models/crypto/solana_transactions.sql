{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'block_hash',
    partition_by = {
        "field": "block_timestamp",
        "data_type": "timestamp",
        "granularity": "day"
    },
    description = 'Solana transactions'
) }}

WITH solana_transactions AS (
  SELECT
    block_timestamp,
    block_slot,
    block_hash,
    fee,
    accounts,
    balance_changes
  FROM
    {{ source('solana', 'Transactions') }}
  WHERE TIMESTAMP_TRUNC(block_timestamp, MONTH) = TIMESTAMP("2025-08-01")
)

SELECT * FROM solana_transactions