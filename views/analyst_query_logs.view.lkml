view: analyst_query_logs {
  sql_table_name: `modus-playground.sephora_demo.analyst_query_logs` ;;

  dimension: query_id {
    type: string
    sql: ${TABLE}.query_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: query_name {
    type: string
    sql: ${TABLE}.query_name ;;
    label: "Query Name"
  }

  dimension: analyst_name {
    type: string
    sql: ${TABLE}.analyst_name ;;
    label: "Analyst"
  }

  dimension: tool {
    type: string
    sql: ${TABLE}.tool ;;
    label: "Tool"
  }

  dimension: sql_text {
    type: string
    sql: ${TABLE}.sql_text ;;
    label: "SQL Text"
    hidden: yes
  }

  dimension: tables_referenced {
    type: string
    sql: ${TABLE}.tables_referenced ;;
    label: "Tables Referenced"
    description: "Pipe-separated table names"
  }

  dimension: columns_referenced {
    type: string
    sql: ${TABLE}.columns_referenced ;;
    label: "Columns Referenced"
    description: "Pipe-separated column names"
  }

  dimension_group: run {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.run_at ;;
    datatype: timestamp
    label: "Run"
  }

  dimension: runtime_seconds {
    type: number
    sql: ${TABLE}.runtime_seconds ;;
    value_format_name: decimal_1
    label: "Runtime (sec)"
  }

  dimension: row_count {
    type: number
    sql: ${TABLE}.row_count ;;
    label: "Row Count Returned"
  }

  measure: query_count {
    type: count
    label: "Query Count"
    drill_fields: [query_name, analyst_name, tool, run_time, runtime_seconds]
  }

  measure: avg_runtime {
    type: average
    sql: ${TABLE}.runtime_seconds ;;
    value_format_name: decimal_1
    label: "Avg Runtime (sec)"
  }

  measure: total_queries_by_analyst {
    type: count_distinct
    sql: ${TABLE}.query_id ;;
    label: "Total Distinct Queries"
  }
}
