SELECT
  conname AS constraint_name,
  conrelid::regclass AS table_name,
  confrelid::regclass AS referenced_table_name,
  confdeltype AS on_delete_action
FROM
  pg_constraint
WHERE
  contype = 'f'
  AND conname ILIKE '%film%' OR conname ILIKE '%rental%';
