view: column_lineage {
  sql_table_name: `modus-playground.sephora_demo.column_lineage` ;;

  dimension: lineage_id {
    type: string
    sql: ${TABLE}.lineage_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: source_table {
    type: string
    sql: ${TABLE}.source_table ;;
    label: "Source Table"
  }

  dimension: source_column {
    type: string
    sql: ${TABLE}.source_column ;;
    label: "Source Column"
  }

  dimension: target_table {
    type: string
    sql: ${TABLE}.target_table ;;
    label: "Target Table / Model"
  }

  dimension: target_column {
    type: string
    sql: ${TABLE}.target_column ;;
    label: "Target Column"
  }

  dimension: transformation {
    type: string
    sql: ${TABLE}.transformation ;;
    label: "Transformation"
  }

  dimension_group: created {
    type: time
    timeframes: [date, month, year]
    sql: SAFE_CAST(${TABLE}.created_at AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Registered"
  }

  measure: edge_count {
    type: count
    label: "Lineage Edges"
    drill_fields: [source_table, source_column, target_table, target_column, transformation]
  }

  measure: distinct_sources {
    type: count_distinct
    sql: ${TABLE}.source_table ;;
    label: "Distinct Source Tables"
  }

  measure: distinct_targets {
    type: count_distinct
    sql: ${TABLE}.target_table ;;
    label: "Distinct Target Objects"
  }
}
