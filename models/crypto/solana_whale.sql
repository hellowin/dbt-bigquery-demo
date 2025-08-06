SELECT
  bc.account,
  SUM(bc.before - bc.after) AS total_changes,
  TIMESTAMP_TRUNC(block_timestamp, HOUR) AS hour,
FROM
  {{ ref('solana_transactions') }} AS t
CROSS JOIN UNNEST(balance_changes) AS bc
WHERE
  TIMESTAMP_TRUNC(block_timestamp, DAY) = TIMESTAMP("2025-08-05")
GROUP BY bc.account, TIMESTAMP_TRUNC(block_timestamp, HOUR)
ORDER BY total_changes DESC